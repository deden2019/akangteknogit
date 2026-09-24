using System;
using System.Drawing;
using System.Windows.Forms;
using log4net;

using OpenRetail.Bll.Api;
using OpenRetail.Bll.Service;
using OpenRetail.Helper;
using OpenRetail.Model;

namespace OpenRetail.App.Pengaturan
{
    public partial class FrmRegistrasiLisensi : Form
    {
        private ILog _log;
        private ILisensiBll _bll;

        public FrmRegistrasiLisensi()
        {
            InitializeComponent();

            ColorManagerHelper.SetTheme(this, this);

            _log = MainProgram.log;

            _bll = new LisensiBll(_log);

            LoadData();
        }

        private void LoadData()
        {
            var lisensi = _bll.GetLisensi();

            if (lisensi == null)
            {
                MessageBox.Show(
                    "Data lisensi tidak ditemukan",
                    "Informasi",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Information);

                return;
            }

            labellisensi.Text = lisensi.nama_perusahaan;

            labellisensi2.Text =
                lisensi.tgl_aktif.ToString("dd/MM/yyyy");

            labellisensi3.Text =
                lisensi.tgl_expired.ToString("dd/MM/yyyy");

            txtKodeLisensi.Text =
                lisensi.kode_lisensi;

            var sisaHari =
                (lisensi.tgl_expired.Date -
                 DateTime.Today).Days;

            labellisensi4.Text =
                sisaHari + " Hari";

            lblMachineId.Text =
    HardwareHelper.GetMachineId();  

            lblVersi.Text =
                Application.ProductVersion;

            if (lisensi.is_permanent)
            {
                labellisensi1.Text = "LIFETIME";
                labellisensi1.ForeColor = Color.Blue;
            }
            else if (!lisensi.is_aktif)
            {
                labellisensi1.Text = "MODE TRIAL";
                labellisensi1.ForeColor = Color.Orange;
            }
            else if (sisaHari < 0)
            {
                labellisensi1.Text = "EXPIRED";
                labellisensi1.ForeColor = Color.Red;
            }
            else
            {
                labellisensi1.Text = "AKTIF";
                labellisensi1.ForeColor = Color.Green;
            }
        }

        private void btnAktivasi_Click(
     object sender,
     EventArgs e)
        {


            try
            {
                var lisensi = _bll.GetLisensi();

                if (lisensi == null)
                    return;
                DateTime expiredDate;

                if (!DateTime.TryParse(
                    txtExpired.Text,
                    out expiredDate))
                {
                    MessageBox.Show(
                        "Tanggal Expired tidak valid.",
                        "Peringatan",
                        MessageBoxButtons.OK,
                        MessageBoxIcon.Warning);

                    return;
                }



                bool valid =
    LicenseKeyHelper.Validate(
        txtKodeLisensi.Text.Trim(),
        HardwareHelper.GetMachineId(),
        expiredDate,
        false);

                if (!valid)
                {
                    MsgHelper.MsgWarning(
                        "Kode lisensi tidak valid.");

                    return;
                }

                lisensi.kode_lisensi =
                    txtKodeLisensi.Text.Trim();


                lisensi.is_trial = false;
                lisensi.is_aktif = true;

                if (expiredDate.Year >= 2099)
                {
                    lisensi.is_permanent = true;
                }
                else
                {
                    lisensi.is_permanent = false;
                }

                var result = _bll.Save(lisensi);

                

                if (result > 0)
                {
                    MessageBox.Show(
                        "Lisensi berhasil diaktivasi",
                        "Informasi",
                        MessageBoxButtons.OK,
                        MessageBoxIcon.Information);

                    LoadData();
                }
                else
                {
                    MessageBox.Show(
                        "Gagal menyimpan lisensi",
                        "Peringatan",
                        MessageBoxButtons.OK,
                        MessageBoxIcon.Warning);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(
                    ex.Message,
                    "Error",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Error);
            }
        }

        private void btnCopyMachineId_Click(
    object sender,
    EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(lblMachineId.Text))
            {
                MessageBox.Show(
                    "Machine ID tidak tersedia.",
                    "Peringatan",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Warning);

                return;
            }

            Clipboard.SetText(lblMachineId.Text);

            MessageBox.Show(
                "Machine ID berhasil disalin.",
                "Informasi",
                MessageBoxButtons.OK,
                MessageBoxIcon.Information);
        }
    }
}