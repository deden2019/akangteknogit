using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenRetail.Model
{
    public class ProdukSatuan
    {
        public string produk_satuan_id { get; set; }

        public string produk_id { get; set; }

        public string satuan_id { get; set; }

        public double konversi { get; set; }

        public double harga_jual { get; set; }

        public string barcode { get; set; }
    }
}