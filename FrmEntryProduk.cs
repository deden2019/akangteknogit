/**
 * Copyright (C) 2017 Kamarudin (http://coding4ever.net/)
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 *
 * The latest version of this file can be found at https://github.com/rudi-krsoftware/open-retail
 */

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

using OpenRetail.Model;
using OpenRetail.Bll.Api;
using OpenRetail.Helper.UI.Template;
using OpenRetail.Helper;
using OpenRetail.Helper.UserControl;
using ConceptCave.WaitCursor;

namespace OpenRetail.App.Referensi
{
    public partial class FrmEntryProduk : FrmEntryStandard
    {        
        private IProdukBll _bll = null; // deklarasi objek business logic layer 
        private Produk _produk = null;
        private IList<Golongan> _listOfGolongan;

        private IList<AdvancedTextbox> _listOfTxtHargaGrosir = new List<AdvancedTextbox>();
        private IList<AdvancedTextbox> _listOfTxtJumlahGrosir = new List<AdvancedTextbox>();
        private IList<AdvancedTextbox> _listOfTxtDiskonGrosir = new List<AdvancedTextbox>();

        private bool _isNewData = false;
        
        public IListener Listener { private get; set; }

        public FrmEntryProduk(string header, Golongan golongan, IList<Golongan> listOfGolongan, IProdukBll bll)

            : base()
        {
            MessageBox.Show("CONSTRUCTOR TAMBAH");
            InitializeComponent();
            ColorManagerHelper.SetTheme(this, this);
            InitGridSatuan();

            base.SetHeader(header);
            this._listOfGolongan = listOfGolongan;
            this._bll = bll;
            this._isNewData = true;

            LoadDataGolongan();
            LoadInputGrosir();

            if (golongan != null)
                cmbGolongan.SelectedItem = golongan.nama_golongan;

            txtKodeProduk.Text = this._bll.GetLastKodeProduk();
            txtKeuntungan.Text = golongan.persentase_keuntungan.ToString();            
        }

        public FrmEntryProduk(string header, Produk produk, IList<Golongan> listOfGolongan, IProdukBll bll)
            : base()
        {
            InitializeComponent();
            ColorManagerHelper.SetTheme(this, this);


            InitGridSatuan();

            base.SetHeader(header);
            base.SetButtonSelesaiToBatal();
            this._listOfGolongan = listOfGolongan;
            this._bll = bll;
            this._produk = produk;

            LoadInputGrosir();
            LoadDataGolongan();

            if (this._produk.Golongan != null)
                cmbGolongan.SelectedItem = this._produk.Golongan.nama_golongan;

            txtKodeProduk.Text = this._produk.kode_produk;
            chkAktif.Checked = this._produk.is_aktif;
            txtNamaProduk.Text = this._produk.nama_produk;
            txtSatuan.Text = this._produk.satuan;
            txtHargaBeli.Text = this._produk.harga_beli.ToString();
            txtKeuntungan.Text = this._produk.persentase_keuntungan.ToString();
            txtHargaJual.Text = this._produk.harga_jual.ToString();
            txtDiskon.Text = this._produk.diskon.ToString();
            txtStok.Text = this._produk.stok.ToString();
            txtStokGudang.Text = this._produk.stok_gudang.ToString();
            txtMinStokGudang.Text = this._produk.minimal_stok_gudang.ToString();            
        }

        private void LoadInputGrosir()
        {
            _listOfTxtHargaGrosir.Add(txtHargaGrosir1);
            _listOfTxtHargaGrosir.Add(txtHargaGrosir2);
            _listOfTxtHargaGrosir.Add(txtHargaGrosir3);

            _listOfTxtJumlahGrosir.Add(txtJumlahMinimalGrosir1);
            _listOfTxtJumlahGrosir.Add(txtJumlahMinimalGrosir2);
            _listOfTxtJumlahGrosir.Add(txtJumlahMinimalGrosir3);

            _listOfTxtDiskonGrosir.Add(txtDiskonGrosir1);
            _listOfTxtDiskonGrosir.Add(txtDiskonGrosir2);
            _listOfTxtDiskonGrosir.Add(txtDiskonGrosir3);

            if (this._produk != null)
            {
                var listOfHargaGrosir = this._produk.list_of_harga_grosir;
                if (listOfHargaGrosir.Count > 0)
                {
                    var index = 0;
                    foreach (var grosir in listOfHargaGrosir)
                    {
                        var txtHargaGrosir = _listOfTxtHargaGrosir[index];
                        txtHargaGrosir.Text = grosir.harga_grosir.ToString();

                        var txtJumlahMinGrosir = _listOfTxtJumlahGrosir[index];
                        txtJumlahMinGrosir.Text = grosir.jumlah_minimal.ToString();

                        var txtDiskonGrosir = _listOfTxtDiskonGrosir[index];
                        txtDiskonGrosir.Text = grosir.diskon.ToString();

                        index++;
                    }
                }
            }            
        }

        private void LoadDataGolongan()
        {
            cmbGolongan.Items.Clear();
            foreach (var golongan in _listOfGolongan)
            {
                cmbGolongan.Items.Add(golongan.nama_golongan);
            }

            if (_listOfGolongan.Count > 0)
                cmbGolongan.SelectedIndex = 0;
        }

        protected override void Simpan()
        {
            if (_isNewData)
            {
                _produk = new Produk
                {
                    list_of_harga_grosir = new List<HargaGrosir>()
                };
            }
            else
            {
                // PENTING: Simpan kode lama agar validasi Update di Repository tidak salah mendeteksi duplikat
                _produk.kode_produk_old = _produk.kode_produk;
            }

            // Pastikan list harga grosir tidak null
            if (_produk.list_of_harga_grosir == null)
                _produk.list_of_harga_grosir = new List<HargaGrosir>();

            // Handling Harga Grosir
            if (_produk.list_of_harga_grosir.Count == 0)
            {
                for (int i = 0; i < _listOfTxtHargaGrosir.Count; i++)
                {
                    var txtHargaGrosir = _listOfTxtHargaGrosir[i];
                    var txtJumlahMinGrosir = _listOfTxtJumlahGrosir[i];
                    var txtDiskonGrosir = _listOfTxtDiskonGrosir[i];

                    var hargaGrosir = new HargaGrosir
                    {
                        harga_ke = i + 1,
                        harga_grosir = NumberHelper.StringToDouble(txtHargaGrosir.Text),
                        jumlah_minimal = NumberHelper.StringToDouble(txtJumlahMinGrosir.Text, true),
                        diskon = NumberHelper.StringToDouble(txtDiskonGrosir.Text, true)
                    };

                    _produk.list_of_harga_grosir.Add(hargaGrosir);
                }
            }
            else
            {
                for (int i = 0; i < _produk.list_of_harga_grosir.Count; i++)
                {
                    if (i < _listOfTxtHargaGrosir.Count)
                    {
                        var txtHargaGrosir = _listOfTxtHargaGrosir[i];
                        var txtJumlahMinGrosir = _listOfTxtJumlahGrosir[i];
                        var txtDiskonGrosir = _listOfTxtDiskonGrosir[i];

                        _produk.list_of_harga_grosir[i].harga_grosir = NumberHelper.StringToDouble(txtHargaGrosir.Text);
                        _produk.list_of_harga_grosir[i].jumlah_minimal = NumberHelper.StringToDouble(txtJumlahMinGrosir.Text, true);
                        _produk.list_of_harga_grosir[i].diskon = NumberHelper.StringToDouble(txtDiskonGrosir.Text, true);
                    }
                }
            }

            // Assign data dari Control UI ke Objek
            if (cmbGolongan.SelectedIndex >= 0 && _listOfGolongan.Count > cmbGolongan.SelectedIndex)
            {
                var golongan = _listOfGolongan[cmbGolongan.SelectedIndex];
                _produk.golongan_id = golongan.golongan_id;
                _produk.Golongan = golongan;
            }

            _produk.kode_produk = txtKodeProduk.Text;
            _produk.is_aktif = chkAktif.Checked;
            _produk.nama_produk = txtNamaProduk.Text;
            _produk.satuan = txtSatuan.Text;
            _produk.harga_beli = NumberHelper.StringToDouble(txtHargaBeli.Text);
            _produk.harga_jual = NumberHelper.StringToDouble(txtHargaJual.Text);
            _produk.diskon = NumberHelper.StringToDouble(txtDiskon.Text, true);
            _produk.persentase_keuntungan = NumberHelper.StringToDouble(txtKeuntungan.Text, true);
            _produk.stok = NumberHelper.StringToDouble(txtStok.Text, true);
            _produk.stok_gudang = NumberHelper.StringToDouble(txtStokGudang.Text, true);
            _produk.minimal_stok_gudang = NumberHelper.StringToDouble(txtMinStokGudang.Text, true);

            var result = 0;
            var validationError = new ValidationError();

            using (new StCursor(Cursors.WaitCursor, new TimeSpan(0, 0, 0, 0)))
            {
                if (_isNewData)
                    result = _bll.Save(_produk, ref validationError);
                else
                    result = _bll.Update(_produk, ref validationError);

                if (result > 0)
                {
                    Listener.Ok(this, _isNewData, _produk);

                    if (_isNewData)
                    {
                        base.ResetForm(this);

                        chkAktif.Checked = true;
                        txtKodeProduk.Text = this._bll.GetLastKodeProduk();
                        txtKodeProduk.Focus();
                    }
                    else
                    {
                        this.Close();
                    }
                }
                else
                {
                    if (validationError.Message.NullToString().Length > 0)
                    {
                        MsgHelper.MsgWarning(validationError.Message);
                        base.SetFocusObject(validationError.PropertyName, this);
                    }
                    else
                    {
                        MsgHelper.MsgDuplicate("kode produk");
                    }
                }
            }
        }

        private void txtMinStokGudang_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (KeyPressHelper.IsEnter(e))
                Simpan();
        }

        private void HitungHargaRetail(object sender, EventArgs e)
        {
            double hargaBeli = NumberHelper.StringToNumber(txtHargaBeli.Text);
            double keuntungan = NumberHelper.StringToDouble(txtKeuntungan.Text, true);

            if (keuntungan > 0)
            {
                var hargaJual = hargaBeli + (hargaBeli * keuntungan / 100);
                txtHargaJual.Text = hargaJual.ToString();
            }
        }

        private void cmbGolongan_SelectedIndexChanged(object sender, EventArgs e)
        {
            var golongan = _listOfGolongan[cmbGolongan.SelectedIndex];
            if (golongan != null)
                txtKeuntungan.Text = golongan.persentase_keuntungan.ToString();
        }

        private void chkAktif_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (KeyPressHelper.IsEnter(e)) KeyPressHelper.NextFocus();
        }

        private void InitGridSatuan()
        {
            dgvSatuan.Columns.Clear();

            dgvSatuan.Columns.Add("colSatuan", "Satuan");
            dgvSatuan.Columns.Add("colKonversi", "Konversi");
            dgvSatuan.Columns.Add("colHargaJual", "Harga Jual");
            dgvSatuan.Columns.Add("colBarcode", "Barcode");
        }

        private void btnTambahSatuan_Click(object sender, EventArgs e)
        {
            using (var frm = new FrmEntryProdukSatuan())
            {
                frm.StartPosition = FormStartPosition.CenterParent;

                if (frm.ShowDialog(this) == DialogResult.OK)
                {
                    dgvSatuan.Rows.Add(
                        frm.ProdukSatuan.satuan_id,
                        frm.ProdukSatuan.konversi,
                        frm.ProdukSatuan.harga_jual,
                        frm.ProdukSatuan.barcode);
                }
            }
        }
    }
}
