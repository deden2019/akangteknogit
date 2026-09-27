using Dapper;
using Dapper.Contrib.Extensions;
using log4net;

using OpenRetail.Model;
using OpenRetail.Repository.Api;
using System;
using System.Collections.Generic;

namespace OpenRetail.Repository.Service
{
    public class TransferStokRepository : ITransferStokRepository
    {
        private IDapperContext _context;
        private ILog _log;

        public TransferStokRepository(
            IDapperContext context,
            ILog log)
        {
            _context = context;
            _log = log;
        }

        public int Save(TransferStok obj)
        {
            var result = 0;

            try
            {
                _context.BeginTransaction();

                var trans = _context.transaction;

                if (obj.transfer_id == null)
                    obj.transfer_id = _context.GetGUID();

                _context.db.Insert<TransferStok>(obj, trans);

                result = 1;

                _context.Commit();
            }
            catch (Exception ex)
            {
                _log.Error("Error:", ex);
                result = 0;
            }

            return result;
        }
        public IList<TransferStok> GetAll()
        {
            return new List<TransferStok>();
        }

        public TransferStok GetByID(string id)
        {
            return null;
        }

        public int Delete(TransferStok obj)
        {
            return 0;
        }
    }
}