using System.Collections.Generic;

using log4net;

using OpenRetail.Bll.Api;
using OpenRetail.Model;
using OpenRetail.Repository.Api;
using OpenRetail.Repository.Service;

namespace OpenRetail.Bll.Service
{
    public class CabangBll : ICabangBll
    {
        private ILog _log;

        public CabangBll(ILog log)
        {
            _log = log;
        }

        public IList<Cabang> GetAll()
        {
            IList<Cabang> result = null;

            using (IDapperContext context = new DapperContext())
            {
                ICabangRepository repo =
                    new CabangRepository(context, _log);

                result = repo.GetAll();
            }

            return result;
        }
    }
}