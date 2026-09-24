using System;
using System.Linq;
using Dapper;
using log4net;

using OpenRetail.Model;
using OpenRetail.Repository.Api;

namespace OpenRetail.Repository.Service
{
    public class LisensiRepository : ILisensiRepository
    {
        private IDapperContext _context;
        private ILog _log;

        public LisensiRepository(IDapperContext context, ILog log)
        {
            _context = context;
            _log = log;
        }

        public Lisensi GetLisensi()
        {
            try
            {
                var sql = @"SELECT *
                            FROM m_lisensi
                            LIMIT 1";

                return _context.db.Query<Lisensi>(sql)
                                  .FirstOrDefault();
            }
            catch (Exception ex)
            {
                _log.Error("Error:", ex);
                return null;
            }
        }

        public int Save(Lisensi obj)
        {
            try
            {
                var sql = @"UPDATE m_lisensi
                    SET nama_perusahaan = @nama_perusahaan,
                        kode_lisensi = @kode_lisensi,
                        tgl_aktif = @tgl_aktif,
                        tgl_expired = @tgl_expired,
                        is_aktif = @is_aktif,
                        is_trial = @is_trial,
                        machine_id = @machine_id
                    WHERE lisensi_id = @lisensi_id";

                return _context.db.Execute(sql, obj);
            }
            catch (Exception ex)
            {
                _log.Error("Error:", ex);
                return 0;
            }
        }
    }
}