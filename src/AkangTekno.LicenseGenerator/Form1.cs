using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using OpenRetail.Helper;

namespace AkangTekno.LicenseGenerator
{
    public partial class FrmLicenseGenerator : Form
    {
        public FrmLicenseGenerator()
        {
            InitializeComponent();
        }

        private void btnGenerate_Click(
     object sender,
     EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtMachineId.Text))
            {
                MessageBox.Show("Machine ID wajib diisi");
                return;
            }

            if (string.IsNullOrWhiteSpace(txtNamaCustomer.Text))
            {
                MessageBox.Show("Nama Customer wajib diisi");
                return;
            }

            bool isPermanent = rbPermanent.Checked;

            DateTime expiredDate;

            if (rb1Tahun.Checked)
            {
                expiredDate = DateTime.Today.AddYears(1);
            }
            else if (rb2Tahun.Checked)
            {
                expiredDate = DateTime.Today.AddYears(2);
            }
            else
            {
                expiredDate = new DateTime(2099, 12, 31);
            }

            var key =
                LicenseGeneratorHelper.Generate(
                    txtMachineId.Text.Trim(),
                    expiredDate,
                    isPermanent);

            txtLicenseKey.Text = key;
            lblExpired.Text =

expiredDate.ToString("dd/MM/yyyy");

            MessageBox.Show(
                "Expired : "
                + expiredDate.ToString("dd/MM/yyyy"));
        }

        private void btnCopy_Click(
    object sender,
    EventArgs e)
        {
            if (string.IsNullOrEmpty(
                txtLicenseKey.Text))
            {
                return;
            }

            Clipboard.SetText(
                txtLicenseKey.Text);

            MessageBox.Show(
                "License Key berhasil disalin");
        }

        private void rbPermanent_CheckedChanged(
    object sender,
    EventArgs e)
        {

        }


        private void btnClear_Click(
     object sender,
     EventArgs e)
        {
            txtMachineId.Clear();
            txtNamaCustomer.Clear();
            txtLicenseKey.Clear();

            rb1Tahun.Checked = true;
        }


        private void FrmLicenseGenerator_Load(
       object sender,
       EventArgs e)
        {
            rb1Tahun.Checked = true;
        }

    }
}
