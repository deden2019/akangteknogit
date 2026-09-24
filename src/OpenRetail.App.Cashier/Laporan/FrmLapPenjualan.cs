using log4net;
using OpenRetail.Bll.Api;
using OpenRetail.Bll.Api.Report;
using OpenRetail.Bll.Service;
using OpenRetail.Bll.Service.Report;
using OpenRetail.Helper;
using OpenRetail.Helper.RAWPrinting;
using OpenRetail.Model;
using OpenRetail.Model.Report;
using PdfSharp.Drawing;
using PdfSharp.Drawing;
using PdfSharp.Pdf;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Drawing.Printing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace OpenRetail.App.Cashier.Laporan
{
    public partial class FrmLapPenjualan : Form
    {
        private ILog _log;
        private PengaturanUmum _pengaturanUmum = null;
        private Pengguna _pengguna;
        private IList<ReportMesinKasir> _listOfMesinKasir;

        // Deklarasi kontrol filter
        private DateTimePicker dtpTanggal = new DateTimePicker();
        private Button btnRefresh = new Button();
        private Button btnExportPdf = new Button();

        private ComboBox cboKasir = new ComboBox();
        private Label lblKasir = new Label();
        private Label lblTanggal = new Label();

        private void InisialisasiKontrolFilter()
        {

            lblTanggal.Text = "Tanggal";
            lblTanggal.Location = new Point(10, 38);
            lblTanggal.AutoSize = true;
            pnlHeader.Controls.Add(lblTanggal);

            lblKasir.Text = "Kasir";
            lblKasir.Location = new Point(180, 38);
            lblKasir.AutoSize = true;
            pnlHeader.Controls.Add(lblKasir);

            cboKasir.Location = new Point(220, 35);
            cboKasir.Size = new Size(115, 21);
            pnlHeader.Controls.Add(cboKasir);

            // 1. Buat DateTimePicker untuk pilih tanggal
            dtpTanggal.Format = DateTimePickerFormat.Custom;
            dtpTanggal.CustomFormat = "dd/MM/yyyy";
            dtpTanggal.Value = DateTime.Today;
            dtpTanggal.Location = new Point(60, 35);
            dtpTanggal.Size = new Size(105, 20);
            dtpTanggal.Anchor = AnchorStyles.Top | AnchorStyles.Left;
            pnlHeader.Controls.Add(dtpTanggal);

            // 2. Buat Tombol Tampilkan
            btnRefresh.Text = "Tampil";
            btnRefresh.Location = new Point(220, 58);
            btnRefresh.Size = new Size(70, 22);
            btnRefresh.UseVisualStyleBackColor = true;

            btnRefresh.Click += (sender, e) =>
            {
                txtOutput.Text = GenerateReport(dtpTanggal.Value);
            };

            pnlHeader.Controls.Add(btnRefresh);

            // 3. Ubah posisi TableLayoutPanel3 tempat txtOutput berada agar turun ke bawah filter
            tableLayoutPanel3.Top = 75;
            tableLayoutPanel3.Height = this.ClientSize.Height - tableLayoutPanel3.Top - tableLayoutPanel2.Height;
        }


        private void LoadKasir()
        {
            IPenggunaBll bll = new PenggunaBll(_log);

            var listKasir = bll.GetAll().ToList();

            cboKasir.DisplayMember = "nama_pengguna";
            cboKasir.ValueMember = "pengguna_id";
            cboKasir.DataSource = listKasir;

            cboKasir.SelectedValue = _pengguna.pengguna_id;
        }

        private void SimpanKePdf()
        {
            using (var saveDialog = new SaveFileDialog())
            {
                saveDialog.Filter = "Text Document (*.txt)|*.txt|PDF Document (*.pdf)|*.pdf";
                saveDialog.FileName = $"Laporan_Penjualan_{_pengguna.nama_pengguna}_{DateTime.Now:yyyyMMdd_HHmmss}";

                if (saveDialog.ShowDialog() == DialogResult.OK)
                {
                    try
                    {
                        System.IO.File.WriteAllText(saveDialog.FileName, txtOutput.Text);
                        MsgHelper.MsgInfo("Laporan berhasil diexport!");
                    }
                    catch (Exception ex)
                    {
                        MsgHelper.MsgError("Gagal menyimpan file: " + ex.Message);
                    }
                }
            }
        }

        private string GenerateReport(DateTime tanggalFilter)
        {
            var txtOutputBuilder = new StringBuilder();
            var garisPemisah = StringHelper.PrintChar('=', 40);

            var totalSaldoAwal = 0d;
            var totalDiskon = 0d;
            var totalPPN = 0d;
            var grandTotal = 0d;
            var maxFormatNumber = 10;

            txtOutputBuilder.Append("Laporan Penjualan Per Kasir").Append(Environment.NewLine);
            txtOutputBuilder.Append("Per tanggal: ").Append(DateTimeHelper.DateToString(tanggalFilter)).Append(Environment.NewLine).Append(Environment.NewLine);

            txtOutputBuilder.Append("Kasir      : ")
                     .Append(cboKasir.Text)
                     .Append(Environment.NewLine);

            txtOutputBuilder.Append("Shift      : ")
                     .Append(MainProgram.namaShift)
                     .Append(Environment.NewLine);
            txtOutputBuilder.Append(garisPemisah).Append(Environment.NewLine).Append(Environment.NewLine);

            IReportMesinKasirBll bll = new ReportMesinKasirBll(_log);

            var isAdaTransaksi = false;

            var kasirId = cboKasir.SelectedValue.ToString();

            _listOfMesinKasir =
                bll.PerKasirGetByPenggunaId(
                    kasirId,
                    MainProgram.shiftId,
                    tanggalFilter.Date);


            double totalTunai = 0;
            double totalKartu = 0;
            double totalPiutang = 0;



            totalSaldoAwal = _listOfMesinKasir
                .OrderBy(x => x.tanggal_sistem)
                .FirstOrDefault()?.saldo_awal ?? 0;

            foreach (var mesin in _listOfMesinKasir.Where(f =>
                f.saldo_awal > 0 ||
                (f.jual != null && f.jual.total_nota > 0)))
            {
                isAdaTransaksi = true;

                totalTunai += mesin.total_tunai;
                totalKartu += mesin.total_kartu;
                totalPiutang += mesin.total_piutang;

                if (mesin.jual != null)
                {
                    totalDiskon += mesin.jual.diskon;
                    totalPPN += mesin.jual.ppn;
                    grandTotal += mesin.jual.grand_total;
                }
            }

            if (isAdaTransaksi)
            {
                txtOutputBuilder.Append("RINGKASAN PEMBAYARAN")
                       .Append(Environment.NewLine);

                txtOutputBuilder.Append(garisPemisah)
                       .Append(Environment.NewLine);

                txtOutputBuilder.Append("Tunai          : ")
                       .Append(StringHelper.RightAlignment(NumberHelper.NumberToString(totalTunai), maxFormatNumber))
                       .Append(Environment.NewLine);

                txtOutputBuilder.Append("Kartu / QRIS    : ")
                       .Append(StringHelper.RightAlignment(NumberHelper.NumberToString(totalKartu), maxFormatNumber))
                       .Append(Environment.NewLine);

                txtOutputBuilder.Append("Piutang        : ")
                       .Append(StringHelper.RightAlignment(NumberHelper.NumberToString(totalPiutang), maxFormatNumber))
                       .Append(Environment.NewLine);

                txtOutputBuilder.Append(garisPemisah)
                       .Append(Environment.NewLine)
                       .Append(Environment.NewLine);

                txtOutputBuilder.Append("GRAND TOTAL")
                       .Append(Environment.NewLine);

                txtOutputBuilder.Append(garisPemisah)
                       .Append(Environment.NewLine);

                txtOutputBuilder.Append("Saldo Awal      : ")
                       .Append(StringHelper.RightAlignment(NumberHelper.NumberToString(totalSaldoAwal), maxFormatNumber))
                       .Append(Environment.NewLine);

                txtOutputBuilder.Append("Total Diskon    : ")
                       .Append(StringHelper.RightAlignment(NumberHelper.NumberToString(totalDiskon), maxFormatNumber))
                       .Append(Environment.NewLine);

                txtOutputBuilder.Append("Total PPN       : ")
                       .Append(StringHelper.RightAlignment(NumberHelper.NumberToString(totalPPN), maxFormatNumber))
                       .Append(Environment.NewLine);

                txtOutputBuilder.Append("Total Penjualan : ")
                       .Append(StringHelper.RightAlignment(NumberHelper.NumberToString(grandTotal), maxFormatNumber))
                       .Append(Environment.NewLine);
            }
            else
            {
                txtOutputBuilder.Append(">> Belum ada transaksi <<").Append(Environment.NewLine);
            }

            return txtOutputBuilder.ToString();
        }

        private void CetakLaporan()
        {
            if (!MsgHelper.MsgKonfirmasi("Apakah proses pencetakan ingin dilanjutkan ?"))
                return;

            try
            {
                PrintDocument pd = new PrintDocument();

                pd.PrinterSettings.PrinterName =
                    _pengaturanUmum.nama_printer;

                string isiLaporan = txtOutput.Text;

                pd.PrintPage += (s, e) =>
                {
                    using (Font font = new Font("Courier New", 10))
                    {
                        e.Graphics.DrawString(
                            isiLaporan,
                            font,
                            Brushes.Black,
                            20,
                            20);
                    }
                };

                pd.Print();
            }
            catch (Exception ex)
            {
                MsgHelper.MsgError(ex.Message);
            }
        }

        public FrmLapPenjualan(string header, Pengguna pengguna, PengaturanUmum pengaturanUmum)
        {
            InitializeComponent();
            ColorManagerHelper.SetTheme(this, this);

            this._log = MainProgram.log;
            this._pengguna = pengguna;
            this._pengaturanUmum = pengaturanUmum;

            this.Text = header;
            this.lblHeader.Text = header;

            // Inisialisasi komponen filter tanggal dan tombol export PDF di form
            InisialisasiKontrolFilter();

            LoadKasir();

            txtOutput.Text = GenerateReport(dtpTanggal.Value);
        }

        private void btnCetak_Click(object sender, EventArgs e)
        {
            CetakLaporan();
        }

        private void btnSelesai_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void FrmLapPenjualan_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (KeyPressHelper.IsEsc(e))
                this.Close();
        }

        private void FrmLapPenjualan_KeyDown(object sender, KeyEventArgs e)
        {
            switch (e.KeyCode)
            {
                case Keys.F10:
                    e.SuppressKeyPress = true;
                    break;

                case Keys.F11:
                    if (btnCetak.Enabled)
                        CetakLaporan();
                    break;

                default:
                    break;
            }
        }
        private void btnExportPdfManual_Click(object sender, EventArgs e)
        {
            using (var saveDialog = new SaveFileDialog())
            {
                saveDialog.Filter = "PDF Document (*.pdf)|*.pdf";
                saveDialog.FileName = $"Laporan_Penjualan_{_pengguna.nama_pengguna}_{DateTime.Now:yyyyMMdd_HHmmss}.pdf";

                if (saveDialog.ShowDialog() == DialogResult.OK)
                {
                    try
                    {
                        // Konfigurasi Fallback Font Resolver agar PDFsharp versi Core mengenali font sistem
                        PdfSharp.Fonts.GlobalFontSettings.FallbackFontResolver = new PdfSharp.Snippets.Font.FailsafeFontResolver();

                        // 1. Buat Dokumen PDF baru
                        PdfSharp.Pdf.PdfDocument document = new PdfSharp.Pdf.PdfDocument();
                        document.Info.Title = "Laporan Penjualan";

                        // 2. Tambah Halaman baru
                        PdfSharp.Pdf.PdfPage page = document.AddPage();

                        // 3. Ambil objek Grafis untuk menggambar teks
                        XGraphics gfx = XGraphics.FromPdfPage(page);

                        // Gunakan font standar
                        XFont font = new XFont("Arial", 10);

                        // Atur posisi awal teks di dalam halaman PDF
                        XPoint position = new XPoint(20, 30);

                        // Pecah teks laporan berdasarkan baris
                        string[] lines = txtOutput.Text.Split(new[] { Environment.NewLine }, StringSplitOptions.None);

                        foreach (string line in lines)
                        {
                            gfx.DrawString(line, font, XBrushes.Black, position);
                            position.Y += 15; // Jarak antar baris ke bawah
                        }

                        // 4. Simpan dokumen ke path tujuan
                        document.Save(saveDialog.FileName);
                        document.Close();

                        MsgHelper.MsgInfo("Laporan berhasil diexport ke PDF!");
                    }
                    catch (Exception ex)
                    {
                        MsgHelper.MsgError("Gagal menyimpan file PDF: " + ex.Message);
                    }
                }
            }
        }
    }
}