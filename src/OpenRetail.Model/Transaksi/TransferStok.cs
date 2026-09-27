using Dapper.Contrib.Extensions;
using System;
using System.Collections.Generic;

namespace OpenRetail.Model
{
    [Table("t_transfer_stok")]
    public class TransferStok
    {
        [ExplicitKey]
        public string transfer_id { get; set; }

        public DateTime tanggal { get; set; }

        public string cabang_asal { get; set; }

        public string cabang_tujuan { get; set; }

        public string status { get; set; }

        public string keterangan { get; set; }

        [Write(false)]
        public List<ItemTransferStok> item_transfer { get; set; }

        public TransferStok()
        {
            item_transfer = new List<ItemTransferStok>();
        }
    }
}