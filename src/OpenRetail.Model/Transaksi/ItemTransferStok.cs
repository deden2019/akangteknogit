using Dapper.Contrib.Extensions;

namespace OpenRetail.Model
{
    [Table("t_item_transfer_stok")]
    public class ItemTransferStok
    {
        [ExplicitKey]
        public string item_id { get; set; }

        public string transfer_id { get; set; }

        public string produk_id { get; set; }

        public double qty { get; set; }

        [Write(false)]
        public Produk Produk { get; set; }
    }
}