using System;
using System.Collections.Generic;
using System.Linq;
using Dapper;
using log4net;

using OpenRetail.Model;
using OpenRetail.Repository.Api;

namespace OpenRetail.Repository.Service
{
    public class ShiftRepository : IShiftRepository
    {
        private IDapperContext _context;
        private ILog _log;

        public ShiftRepository(
            IDapperContext context,
            ILog log)
        {
            _context = context;
            _log = log;
        }

        public IList<Shift> GetAll()
        {
            IList<Shift> result = null;

            try
            {
                var sql = @"
                    SELECT *
                    FROM m_shift
                    WHERE is_active = true
                    ORDER BY nama_shift";

                result = _context.db
                    .Query<Shift>(sql)
                    .ToList();
            }
            catch (Exception ex)
            {
                _log.Error("Error:", ex);
            }

            return result;
        }
    }
}