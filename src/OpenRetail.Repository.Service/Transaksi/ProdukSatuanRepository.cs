using Dapper;
using log4net;

using OpenRetail.Model;
using OpenRetail.Repository.Api;

using System;
using System.Collections.Generic;
using System.Linq;

namespace OpenRetail.Repository.Service
{
    public class ProdukSatuanRepository : IProdukSatuanRepository
    {
        private IDapperContext _context;
        private ILog _log;

        public ProdukSatuanRepository(
            IDapperContext context,
            ILog log)
        {
            _context = context;
            _log = log;
        }

        public IList<ProdukSatuan> GetByProduk(
            string produkId)
        {
            IList<ProdukSatuan> list = new List<ProdukSatuan>();

            try
            {
                var sql = @"
                    SELECT *
                    FROM m_produk_satuan
                    WHERE produk_id = @produkId
                    ORDER BY konversi";

                list = _context.db.Query<ProdukSatuan>(
                    sql,
                    new { produkId })
                    .ToList();
            }
            catch (Exception ex)
            {
                _log.Error("Error:", ex);
            }

            return list;
        }

        public ProdukSatuan GetByBarcode(
            string barcode)
        {
            ProdukSatuan obj = null;

            try
            {
                var sql = @"
                    SELECT *
                    FROM m_produk_satuan
                    WHERE barcode = @barcode";

                obj = _context.db.Query<ProdukSatuan>(
                    sql,
                    new { barcode })
                    .FirstOrDefault();
            }
            catch (Exception ex)
            {
                _log.Error("Error:", ex);
            }

            return obj;
        }

        public int Save(ProdukSatuan obj)
        {
            var sql = @"
        INSERT INTO m_produk_satuan
        (
            produk_satuan_id,
            produk_id,
            satuan_id,
            konversi,
            harga_jual,
            barcode
        )
        VALUES
        (
            @produk_satuan_id,
            @produk_id,
            @satuan_id,
            @konversi,
            @harga_jual,
            @barcode
        )";

            return _context.db.Execute(sql, obj);
        }

        public int DeleteByProduk(string produkId)
        {
            var sql = @"
        DELETE FROM m_produk_satuan
        WHERE produk_id = @produkId";

            return _context.db.Execute(sql, new { produkId });
        }
    }
}