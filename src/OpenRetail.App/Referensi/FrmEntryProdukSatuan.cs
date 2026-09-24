using System;
using System.Windows.Forms;

using OpenRetail.Model;

namespace OpenRetail.App.Referensi
{
    public partial class FrmEntryProdukSatuan : Form
    {
        public ProdukSatuan ProdukSatuan { get; private set; }

        public FrmEntryProdukSatuan()
        {
            InitializeComponent();

            this.ShowInTaskbar = false;

            cmbSatuan.Items.Add("PCS");
            cmbSatuan.Items.Add("PACK");
            cmbSatuan.Items.Add("KARDUS");
            cmbSatuan.Items.Add("BAL");
            cmbSatuan.Items.Add("LUSIN");

            if (cmbSatuan.Items.Count > 0)
                cmbSatuan.SelectedIndex = 0;
        }

        private void btnSimpan_Click(object sender, EventArgs e)
        {
            double konversi = 0;
            double hargaJual = 0;

            double.TryParse(txtKonversi.Text, out konversi);
            double.TryParse(txtHargaJual.Text, out hargaJual);

            ProdukSatuan = new ProdukSatuan
            {
                satuan_id = cmbSatuan.Text,
                konversi = konversi,
                harga_jual = hargaJual,
                barcode = txtBarcode.Text
            };

            DialogResult = DialogResult.OK;
            Close();
        }

        private void btnBatal_Click(object sender, EventArgs e)
        {
            DialogResult = DialogResult.Cancel;
            Close();
        }
    }
}