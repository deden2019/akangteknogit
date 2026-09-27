using OpenRetail.App.Lookup;
using OpenRetail.Bll.Api;
using OpenRetail.Bll.Service;
using OpenRetail.Helper;
using OpenRetail.Helper.UI.Template;
using OpenRetail.Model;
using System;
using System.Windows.Forms;
using OpenRetail.App.Lookup;

namespace OpenRetail.App.Transaksi
{
    public partial class FrmEntryTransferStok :
        FrmEntryStandard, IListener
    {
        private Produk _produk;

        private double GetStokProduk()
        {
            if (_produk == null)
                return 0;

            return _produk.stok;
        }

        public FrmEntryTransferStok(string header)
                : base()
        {
            InitializeComponent();

            gridControl.RowCount = 1;
            gridControl.ColCount = 4;

            gridControl[1, 1].CellValue = "No";
            gridControl[1, 2].CellValue = "Kode Produk";
            gridControl[1, 3].CellValue = "Nama Produk";
            gridControl[1, 4].CellValue = "Qty";


            ColorManagerHelper.SetTheme(this, this);

            base.SetHeader(header);

            txtNoTransfer.Text =
                "TRF" + DateTime.Now.ToString("yyyyMMddHHmmss");

            dtpTanggal.Value = DateTime.Now;

            cmbCabangAsal.Items.Add("UTM");
            cmbCabangAsal.Items.Add("PNR");

            cmbCabangTujuan.Items.Add("UTM");
            cmbCabangTujuan.Items.Add("PNR");

            cmbCabangAsal.SelectedIndex = 0;
            cmbCabangTujuan.SelectedIndex = 1;
        }

        protected override void Simpan()
        {
            if (_produk == null)
            {
                MessageBox.Show("Pilih produk terlebih dahulu");
                return;
            }

            var obj = new TransferStok();

            obj.transfer_id = Guid.NewGuid().ToString();
            obj.tanggal = dtpTanggal.Value;
            obj.cabang_asal = cmbCabangAsal.Text;
            obj.cabang_tujuan = cmbCabangTujuan.Text;
            obj.keterangan = txtKeterangan.Text;
            obj.status = "SELESAI";

            var item = new ItemTransferStok();

            item.item_id = Guid.NewGuid().ToString();
            item.produk_id = _produk.produk_id;
            item.qty = Convert.ToDouble(txtQty.Text);

            obj.item_transfer.Add(item);

            MessageBox.Show(
                "Transfer : " + obj.transfer_id +
                "\nProduk : " + _produk.nama_produk +
                "\nQty : " + item.qty);
        }


        protected override void Selesai()
        {
            this.Close();
        }

        private void txtKodeProduk_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                IProdukBll bll = new ProdukBll(
                    MainProgram.isUseWebAPI,
                    MainProgram.baseUrl,
                    MainProgram.log);

                var listOfProduk =
                    bll.GetByName(txtKodeProduk.Text.Trim(), false);

                if (listOfProduk.Count == 0)
                {
                    MessageBox.Show("Produk tidak ditemukan");
                }
                else if (listOfProduk.Count == 1)
                {
                    _produk = listOfProduk[0];

                    txtKodeProduk.Text = _produk.kode_produk;
                    txtNamaProduk.Text = _produk.nama_produk;

                    lblStok.Text = _produk.stok.ToString();

                    txtQty.Focus();

                }
                else
                {
                    var frmLookup = new FrmLookupReferensi(
                        "Data Produk",
                        listOfProduk,
                        true);

                    frmLookup.Listener = this;
                    frmLookup.ShowDialog();
                }
            }
        }

        private void btnTambah_Click(object sender, EventArgs e)
        {
            if (_produk == null)
            {
                MessageBox.Show("Pilih produk terlebih dahulu");
                return;
            }

            double qty = Convert.ToDouble(txtQty.Text);

            if (qty > _produk.stok)
            {
                MessageBox.Show(
                    "Stok tidak mencukupi !" +
                    "\nStok tersedia : " + _produk.stok +
                    "\nQty transfer : " + qty,
                    "Peringatan",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Warning);

                txtQty.Focus();
                txtQty.SelectAll();
                return;
            }

            int row = gridControl.RowCount + 1;

            gridControl.RowCount = row;

            gridControl[row, 1].CellValue = row - 1;
            gridControl[row, 2].CellValue = txtKodeProduk.Text;
            gridControl[row, 3].CellValue = txtNamaProduk.Text;
            gridControl[row, 4].CellValue = txtQty.Text;

            gridControl.Refresh();

            MessageBox.Show("Data ditambahkan");
        }

        public void Ok(object sender, object data)
        {
            if (data is Produk)
            {
                _produk = (Produk)data;

                txtKodeProduk.Text = _produk.kode_produk;
                txtNamaProduk.Text = _produk.nama_produk;

                lblStok.Text = _produk.stok.ToString();

                txtQty.Focus();
            }
        }

        public void Ok(object sender, bool isNewData, object data)
        {
            // kosong dulu
        }


    }
}