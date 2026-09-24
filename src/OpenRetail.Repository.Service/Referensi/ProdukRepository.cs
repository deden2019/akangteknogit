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
using System.Data;
using System.Linq;
using log4net;
using Dapper;
using Dapper.Contrib.Extensions;
using OpenRetail.Model;
using OpenRetail.Repository.Api;


namespace OpenRetail.Repository.Service
{
    public class ProdukRepository : IProdukRepository
    {
        private const string SQL_TEMPLATE = @"SELECT m_produk.produk_id, m_produk.kode_produk, m_produk.nama_produk, m_produk.satuan, m_produk.stok, m_produk.harga_beli, m_produk.harga_jual, m_produk.diskon, m_produk.persentase_keuntungan,
                                              m_produk.minimal_stok, m_produk.stok_gudang, m_produk.minimal_stok_gudang, m_produk.is_aktif, m_produk.last_update,
                                              m_golongan.golongan_id, m_golongan.nama_golongan, m_golongan.diskon
                                              FROM m_produk LEFT JOIN public.m_golongan ON m_produk.golongan_id = m_golongan.golongan_id
                                              {WHERE}
                                              {ORDER BY}
                                              {OFFSET}";

        private const string SQL_TEMPLATE_FOR_PAGING = @"SELECT COUNT(*) 
                                                         FROM m_produk LEFT JOIN public.m_golongan ON m_produk.golongan_id = m_golongan.golongan_id
                                                         {WHERE}";

        private readonly IDapperContext _context;
        private readonly ILog _log;

        private string _sql;

        public ProdukRepository(IDapperContext context, ILog log)
        {
            this._context = context;
            this._log = log;
        }

        private IEnumerable<Produk> MappingRecordToObject(string sql, object param = null)
        {
            IEnumerable<Produk> oList = _context.db.Query<Produk, Golongan, Produk>(sql, (p, g) =>
            {
                if (g != null)
                {
                    p.golongan_id = g.golongan_id;
                    p.Golongan = g;
                }

                return p;
            }, param, splitOn: "golongan_id");

            return oList;
        }

        private HargaGrosir GetHargaGrosir(string produkId, int hargaKe, IDbTransaction transaction = null)
        {
            IHargaGrosirRepository repo = new HargaGrosirRepository(_context, _log);
            return repo.GetHargaGrosir(produkId, hargaKe, transaction);
        }

        private IList<HargaGrosir> GetListHargaGrosir(string produkId)
        {
            IHargaGrosirRepository repo = new HargaGrosirRepository(_context, _log);
            return repo.GetListHargaGrosir(produkId);
        }

        private IList<HargaGrosir> GetListHargaGrosir(string[] listOfProdukId)
        {
            IHargaGrosirRepository repo = new HargaGrosirRepository(_context, _log);
            return repo.GetListHargaGrosir(listOfProdukId);
        }

        public Produk GetByID(string id)
        {
            Produk obj = null;

            try
            {
                _sql = SQL_TEMPLATE.Replace("{WHERE}", "WHERE m_produk.produk_id = @id")
                                   .Replace("{ORDER BY}", "")
                                   .Replace("{OFFSET}", "");

                obj = MappingRecordToObject(_sql, new { id }).SingleOrDefault();
            }
            catch (Exception ex)
            {
                _log.Error("Error:", ex);
            }

            return obj;
        }

        public Produk GetByKode(string kodeProduk, bool isCekStatusAktif = false)
        {
            Produk obj = null;

            try
            {
                string whereClause = isCekStatusAktif
                    ? "WHERE LOWER(m_produk.kode_produk) = @kodeProduk AND m_produk.is_aktif = true"
                    : "WHERE LOWER(m_produk.kode_produk) = @kodeProduk";

                _sql = SQL_TEMPLATE.Replace("{WHERE}", whereClause)
                                   .Replace("{ORDER BY}", "")
                                   .Replace("{OFFSET}", "");

                kodeProduk = kodeProduk.ToLower();

                obj = MappingRecordToObject(_sql, new { kodeProduk }).SingleOrDefault();

                if (obj != null)
                    obj.list_of_harga_grosir = GetListHargaGrosir(obj.produk_id).ToList();
            }
            catch (Exception ex)
            {
                _log.Error("Error:", ex);
            }

            return obj;
        }

        public string GetLastKodeProduk()
        {
            return _context.GetLastNota(new Produk().GetTableName());
        }

        private void SetHargaGrosir(IList<Produk> listOfProduk)
        {
            if (listOfProduk == null || !listOfProduk.Any()) return;

            var listOfProdukId = listOfProduk.Select(p => p.produk_id).ToArray();
            var listOfHargaGrosir = GetListHargaGrosir(listOfProdukId);

            foreach (var produk in listOfProduk)
            {
                produk.list_of_harga_grosir = listOfHargaGrosir.Where(f => f.produk_id == produk.produk_id)
                                                               .OrderBy(f => f.harga_ke)
                                                               .ToList();
            }
        }

        public IList<Produk> GetByName(string name, bool isLoadHargaGrosir = true, bool isCekStatusAktif = false)
        {
            IList<Produk> oList = new List<Produk>();

            try
            {
                string whereClause = isCekStatusAktif
                    ? "WHERE (LOWER(m_produk.nama_produk) LIKE @name OR LOWER(m_produk.kode_produk) LIKE @name) AND m_produk.is_aktif = true"
                    : "WHERE (LOWER(m_produk.nama_produk) LIKE @name OR LOWER(m_produk.kode_produk) LIKE @name)";

                _sql = SQL_TEMPLATE.Replace("{WHERE}", whereClause)
                                   .Replace("{ORDER BY}", "ORDER BY m_produk.nama_produk")
                                   .Replace("{OFFSET}", "");

                name = "%" + name.ToLower() + "%";

                oList = MappingRecordToObject(_sql, new { name }).ToList();

                if (isLoadHargaGrosir) SetHargaGrosir(oList);
            }
            catch (Exception ex)
            {
                _log.Error("Error:", ex);
            }

            return oList;
        }

        public IList<Produk> GetByName(string name, string sortBy, int pageNumber, int pageSize, ref int pagesCount, bool isLoadHargaGrosir = true)
        {
            IList<Produk> oList = new List<Produk>();

            try
            {
                name = "%" + name.ToLower() + "%";

                var sqlPageCount = SQL_TEMPLATE_FOR_PAGING.Replace("{WHERE}", "WHERE LOWER(m_produk.nama_produk) LIKE @name OR LOWER(m_produk.kode_produk) LIKE @name");
                pagesCount = _context.GetPagesCount(sqlPageCount, pageSize, new { name });

                sortBy = string.Format("ORDER BY {0}", sortBy);

                _sql = SQL_TEMPLATE.Replace("{WHERE}", "WHERE LOWER(m_produk.nama_produk) LIKE @name OR LOWER(m_produk.kode_produk) LIKE @name")
                                   .Replace("{ORDER BY}", sortBy)
                                   .Replace("{OFFSET}", "OFFSET @pageSize * (@pageNumber - 1) LIMIT @pageSize");

                oList = MappingRecordToObject(_sql, new { name, pageNumber, pageSize }).ToList();

                if (isLoadHargaGrosir) SetHargaGrosir(oList);
            }
            catch (Exception ex)
            {
                _log.Error("Error:", ex);
            }

            return oList;
        }

        public IList<Produk> GetByGolongan(string golonganId)
        {
            IList<Produk> oList = new List<Produk>();

            try
            {
                _sql = SQL_TEMPLATE.Replace("{WHERE}", "WHERE m_produk.golongan_id = @golonganId")
                                   .Replace("{ORDER BY}", "ORDER BY m_produk.nama_produk")
                                   .Replace("{OFFSET}", "");

                oList = MappingRecordToObject(_sql, new { golonganId }).ToList();

                SetHargaGrosir(oList);
            }
            catch (Exception ex)
            {
                _log.Error("Error:", ex);
            }

            return oList;
        }

        public IList<Produk> GetByGolongan(string golonganId, string sortBy, int pageNumber, int pageSize, ref int pagesCount)
        {
            IList<Produk> oList = new List<Produk>();

            try
            {
                var sqlPageCount = SQL_TEMPLATE_FOR_PAGING.Replace("{WHERE}", "WHERE m_produk.golongan_id = @golonganId");
                pagesCount = _context.GetPagesCount(sqlPageCount, pageSize, new { golonganId });

                sortBy = string.Format("ORDER BY {0}", sortBy);

                _sql = SQL_TEMPLATE.Replace("{WHERE}", "WHERE m_produk.golongan_id = @golonganId")
                                   .Replace("{ORDER BY}", sortBy)
                                   .Replace("{OFFSET}", "OFFSET @pageSize * (@pageNumber - 1) LIMIT @pageSize");

                oList = MappingRecordToObject(_sql, new { golonganId, pageNumber, pageSize }).ToList();

                SetHargaGrosir(oList);
            }
            catch (Exception ex)
            {
                _log.Error("Error:", ex);
            }

            return oList;
        }

        public IList<Produk> GetInfoMinimalStok()
        {
            IList<Produk> oList = new List<Produk>();

            try
            {
                _sql = SQL_TEMPLATE.Replace("{WHERE}", "WHERE m_produk.minimal_stok_gudang > 0 AND (m_produk.stok + m_produk.stok_gudang) <= m_produk.minimal_stok_gudang")
                                   .Replace("{ORDER BY}", "ORDER BY m_produk.nama_produk")
                                   .Replace("{OFFSET}", "");

                oList = MappingRecordToObject(_sql).ToList();
            }
            catch (Exception ex)
            {
                _log.Error("Error:", ex);
            }

            return oList;
        }

        public IList<Produk> GetAll()
        {
            IList<Produk> oList = new List<Produk>();

            try
            {
                _sql = SQL_TEMPLATE.Replace("{WHERE}", "")
                                   .Replace("{ORDER BY}", "ORDER BY m_produk.nama_produk")
                                   .Replace("{OFFSET}", "");

                oList = MappingRecordToObject(_sql).ToList();

                SetHargaGrosir(oList);
            }
            catch (Exception ex)
            {
                _log.Error("Error:", ex);
            }

            return oList;
        }

        public IList<Produk> GetAll(string sortBy)
        {
            IList<Produk> oList = new List<Produk>();

            try
            {
                sortBy = string.Format("ORDER BY {0}", sortBy);

                _sql = SQL_TEMPLATE.Replace("{WHERE}", "")
                                   .Replace("{ORDER BY}", sortBy)
                                   .Replace("{OFFSET}", "");

                oList = MappingRecordToObject(_sql).ToList();

                SetHargaGrosir(oList);
            }
            catch (Exception ex)
            {
                _log.Error("Error:", ex);
            }

            return oList;
        }

        public IList<Produk> GetAll(string sortBy, int pageNumber, int pageSize, ref int pagesCount)
        {
            IList<Produk> oList = new List<Produk>();

            try
            {
                var sqlPageCount = SQL_TEMPLATE_FOR_PAGING.Replace("{WHERE}", "");
                pagesCount = _context.GetPagesCount(sqlPageCount, pageSize);

                sortBy = string.Format("ORDER BY {0}", sortBy);

                _sql = SQL_TEMPLATE.Replace("{WHERE}", "")
                                   .Replace("{ORDER BY}", sortBy)
                                   .Replace("{OFFSET}", "OFFSET @pageSize * (@pageNumber - 1) LIMIT @pageSize");

                oList = MappingRecordToObject(_sql, new { pageNumber, pageSize }).ToList();

                SetHargaGrosir(oList);
            }
            catch (Exception ex)
            {
                _log.Error("Error:", ex);
            }

            return oList;
        }

        /// <summary>
        /// Pengecekan efisien keberadaan kode produk langsung dari database
        /// </summary>
        private bool IsExist(string kodeProduk)
        {
            string sql = "SELECT COUNT(1) FROM m_produk WHERE LOWER(kode_produk) = @kodeProduk";
            var count = _context.db.ExecuteScalar<int>(sql, new { kodeProduk = kodeProduk.ToLower() });

            return count > 0;
        }

        // Contoh struktur di ProdukRepository.cs
        public int Save(Produk obj)
        {
            var result = 0;

            try
            {
                // Cek kode produk sudah ada atau belum
                if (IsExist(obj.kode_produk))
                    return 0;

                obj.produk_id = _context.GetGUID();

                result = _context.db.Insert<Produk>(obj) > 0 ? 1 : 0;

                if (result > 0)
                {
                    if (obj.list_of_harga_grosir != null)
                    {
                        foreach (var item in obj.list_of_harga_grosir)
                        {
                            item.harga_grosir_id = _context.GetGUID();
                            item.produk_id = obj.produk_id;

                            _context.db.Insert<HargaGrosir>(item);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                _log.Error("Error Save Produk:", ex);
                throw;
            }


            return result;
        }

        public int Update(Produk obj)
        {
            var result = 0;

            try
            {
                // 1. Validasi jika Kode Produk diubah dan ternyata kode baru tersebut sudah milik produk lain
                bool isKodeDiubah = !string.Equals(obj.kode_produk, obj.kode_produk_old, StringComparison.OrdinalIgnoreCase);

                if (isKodeDiubah && IsExist(obj.kode_produk))
                {
                    // Jika kode diganti dan sudah terpakai oleh produk lain, gagalkan update
                    return 0;
                }

                // 2. Jalankan Proses Update
                _context.BeginTransaction();

                var transaction = _context.transaction;

                // Eksekusi Update ke tabel m_produk
                bool isUpdated = _context.db.Update<Produk>(obj, transaction);

                if (isUpdated)
                {
                    // Update / Simpan Harga Grosir jika ada
                    if (obj.list_of_harga_grosir != null)
                    {
                        foreach (var item in obj.list_of_harga_grosir)
                        {
                            item.produk_id = obj.produk_id;
                            var hargaGrosir = GetHargaGrosir(obj.produk_id, item.harga_ke, transaction);

                            if (hargaGrosir == null)
                            {
                                if (string.IsNullOrEmpty(item.harga_grosir_id))
                                    item.harga_grosir_id = _context.GetGUID();

                                _context.db.Insert<HargaGrosir>(item, transaction);
                            }
                            else
                            {
                                _context.db.Update<HargaGrosir>(item, transaction);
                            }
                        }
                    }

                    _context.Commit();
                    result = 1;
                }
                else
                {
                    _context.Rollback();
                }
            }
            catch (Exception ex)
            {
                _context.Rollback();

                // 1. Catat log error terlebih dahulu
                _log.Error("Error Update Produk:", ex);

               
            }

            return result;
        }

        public int Delete(Produk obj)
        {
            var result = 0;

            try
            {
                result = _context.db.Delete<Produk>(obj) ? 1 : 0;
            }
            catch (Exception ex)
            {
                _log.Error("Error Delete Produk:", ex);
            }

            return result;
        }
    }
}