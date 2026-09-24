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
using System.Linq;
using System.Text;

using log4net;
using Dapper;
using OpenRetail.Model;
using OpenRetail.Model.Report;
using OpenRetail.Repository.Api;
using OpenRetail.Repository.Api.Report;

namespace OpenRetail.Repository.Service.Report
{
    public class ReportMesinKasirRepository : IReportMesinKasirRepository
    {
        private IDapperContext _context;
        private ILog _log;

        public ReportMesinKasirRepository(IDapperContext context, ILog log)
        {
            this._context = context;
            this._log = log;
        }

        private double GetTotalPembayaran(string mesinId, string namaKartu)
        {
            var sql = @"
        SELECT COALESCE(SUM(
            t_jual_produk.total_nota
            - t_jual_produk.diskon
            + t_jual_produk.ppn
            + t_jual_produk.ongkos_kirim),0)
        FROM t_jual_produk
        INNER JOIN m_kartu
            ON m_kartu.kartu_id = t_jual_produk.kartu_id
        WHERE t_jual_produk.mesin_id = @mesinId
        AND m_kartu.nama_kartu = @namaKartu";

            return _context.db.ExecuteScalar<double>(
                sql,
                new { mesinId, namaKartu });
        }

        private double GetTotalTunai(string mesinId)
        {
            var sql = @"
        SELECT COALESCE(SUM(
            total_nota - diskon + ppn + ongkos_kirim),0)
        FROM t_jual_produk
        WHERE mesin_id = @mesinId
        AND tanggal_tempo IS NULL
        AND kartu_id IS NULL";

            return _context.db.ExecuteScalar<double>(
                sql,
                new { mesinId });
        }

        private double GetTotalPiutang(string mesinId)
        {
            var sql = @"
        SELECT COALESCE(SUM(
            total_nota - diskon + ppn + ongkos_kirim),0)
        FROM t_jual_produk
        WHERE mesin_id = @mesinId
        AND tanggal_tempo IS NOT NULL";

            return _context.db.ExecuteScalar<double>(
                sql,
                new { mesinId });
        }

        private double GetTotalKartu(string mesinId)
        {
            try
            {
                var sql = @"SELECT COALESCE(
                        SUM(total_nota - diskon + ppn + ongkos_kirim), 0)
                    FROM t_jual_produk
                    WHERE mesin_id = @mesinId
                    AND kartu_id IS NOT NULL";

                return _context.db.ExecuteScalar<double>(
                    sql,
                    new { mesinId });
            }
            catch
            {
                return 0;
            }
        }

        public IList<ReportMesinKasir> PerKasirGetByPenggunaId(
            string penggunaId,
            string shiftId,
            DateTime tanggal)
        {
            IList<ReportMesinKasir> oList = new List<ReportMesinKasir>();

            try
            {
                var sql = @"SELECT t_mesin.mesin_id, t_mesin.tanggal, t_mesin.saldo_awal, t_mesin.tanggal_sistem,
                            m_pengguna.pengguna_id, m_pengguna.nama_pengguna
                            FROM public.t_mesin INNER JOIN public.m_pengguna ON t_mesin.pengguna_id = m_pengguna.pengguna_id
                            WHERE t_mesin.tanggal = @tanggal
AND m_pengguna.pengguna_id = @penggunaId

ORDER BY t_mesin.tanggal_sistem";

                oList = _context.db.Query<ReportMesinKasir, Pengguna, ReportMesinKasir>(
    sql,
    (m, p) =>
    {
        m.pengguna_id = p.pengguna_id;
        m.Pengguna = p;
        return m;
    },
new
{
    penggunaId,
    shiftId,
    tanggal = tanggal.Date
},
    splitOn: "pengguna_id")
    .ToList();


                foreach (var item in oList)
                {
                    item.jual = GetJual(
    item.mesin_id,
    tanggal);
                    item.total_tunai = GetTotalTunai(item.mesin_id);
                    item.total_piutang = GetTotalPiutang(item.mesin_id);
                    item.total_kartu = GetTotalKartu(item.mesin_id);

                    item.jual = GetJual(
    item.mesin_id,
    tanggal);

                    item.total_qris = GetTotalPembayaran(item.mesin_id, "QRIS");
                    item.total_debit_bni = GetTotalPembayaran(item.mesin_id, "Debit BNI");
                    item.total_debit_mandiri = GetTotalPembayaran(item.mesin_id, "Debit Mandiri");
                    item.total_visa = GetTotalPembayaran(item.mesin_id, "Visa");
                    item.total_mastercard = GetTotalPembayaran(item.mesin_id, "Mastercard");

                    if (item.jual != null)
                        item.item_jual = GetItemJual(item.mesin_id);
                }

            }
            catch (Exception ex)
            {
                _log.Error("Error:", ex);
            }

            return oList;
        }

        private ReportPenjualanProdukHeader GetJual(
    string mesinId,
    DateTime tanggal)
        {            
            ReportPenjualanProdukHeader obj = null;

            try
            {
                var sql = @"SELECT SUM(t_jual_produk.ppn) AS ppn, SUM(t_jual_produk.diskon) AS diskon, SUM(t_jual_produk.total_nota) AS total_nota
                            FROM public.t_mesin INNER JOIN public.t_jual_produk ON t_jual_produk.mesin_id = t_mesin.mesin_id
                            WHERE t_mesin.tanggal = @tanggal
AND t_mesin.mesin_id = @mesinId";
                obj = _context.db.QuerySingleOrDefault<ReportPenjualanProdukHeader>(
    sql,
    new
    {
        mesinId,
        tanggal = tanggal.Date
    });
            }
            catch (Exception ex)
            {
                _log.Error("Error:", ex);
            }

            return obj;
        }

        private IList<ReportPenjualanProduk> GetItemJual(string mesinId)
        {
            IList<ReportPenjualanProduk> oList = new List<ReportPenjualanProduk>();

            try
            {
                var sql = @"SELECT m_produk.produk_id, m_produk.nama_produk, t_item_jual_produk.harga_jual, t_item_jual_produk.diskon,
                            SUM(t_item_jual_produk.jumlah - t_item_jual_produk.jumlah_retur) AS jumlah
                            FROM public.t_jual_produk INNER JOIN public.t_item_jual_produk ON t_item_jual_produk.jual_id = t_jual_produk.jual_id 
                            INNER JOIN public.m_produk ON t_item_jual_produk.produk_id = m_produk.produk_id
                            WHERE t_jual_produk.mesin_id = @mesinId
                            GROUP BY m_produk.produk_id, m_produk.nama_produk, t_item_jual_produk.harga_jual, t_item_jual_produk.diskon
                            ORDER BY m_produk.nama_produk";
                oList = _context.db.Query<ReportPenjualanProduk>(sql, new { mesinId }).ToList();
            }
            catch (Exception ex)
            {
                _log.Error("Error:", ex);
            }

            return oList;
        }
    }
}
