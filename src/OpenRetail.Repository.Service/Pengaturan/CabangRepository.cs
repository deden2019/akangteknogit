using System;
using System.Collections.Generic;
using System.Linq;

using Dapper;
using log4net;

using OpenRetail.Model;
using OpenRetail.Repository.Api;

namespace OpenRetail.Repository.Service
{
    public class CabangRepository : ICabangRepository
    {
        private IDapperContext _context;
        private ILog _log;

        public CabangRepository(IDapperContext context, ILog log)
        {
            _context = context;
            _log = log;
        }

        public IList<Cabang> GetAll()
        {
            IList<Cabang> oList = new List<Cabang>();

            try
            {
                string sql = @"
                    SELECT
                        cabang_id,
                        nama_cabang
                    FROM m_cabang
                    ORDER BY nama_cabang";

                oList = _context.db.Query<Cabang>(sql).ToList();
            }
            catch (Exception ex)
            {
                _log.Error("Error:", ex);
            }

            return oList;
        }
    }
}