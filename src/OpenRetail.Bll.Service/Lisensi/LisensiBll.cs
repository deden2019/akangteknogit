using log4net;

using OpenRetail.Model;
using OpenRetail.Bll.Api;
using OpenRetail.Repository.Api;
using OpenRetail.Repository.Service;

namespace OpenRetail.Bll.Service
{
    public class LisensiBll : ILisensiBll
    {
        private ILog _log;
        private ILisensiRepository _repository;

        public LisensiBll(ILog log)
        {
            _log = log;

            var context = new DapperContext();
            _repository = new LisensiRepository(context, _log);
        }

        public Lisensi GetLisensi()
        {
            return _repository.GetLisensi();
        }

        public int Save(Lisensi obj)
        {
            return _repository.Save(obj);
        }
    }
}