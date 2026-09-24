using System.Collections.Generic;
using log4net;

using OpenRetail.Model;
using OpenRetail.Bll.Api;
using OpenRetail.Repository.Api;
using OpenRetail.Repository.Service;

namespace OpenRetail.Bll.Service
{
    public class ShiftBll : IShiftBll
    {
        private ILog _log;
        private IUnitOfWork _unitOfWork;

        public ShiftBll(ILog log)
        {
            _log = log;
        }

        public IList<Shift> GetAll()
        {
            IList<Shift> result = null;

            using (IDapperContext context = new DapperContext())
            {
                _unitOfWork = new UnitOfWork(context, _log);

                result = _unitOfWork
                    .ShiftRepository
                    .GetAll();
            }

            return result;
        }
    }
}