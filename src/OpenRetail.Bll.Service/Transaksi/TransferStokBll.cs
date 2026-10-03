using log4net;
using OpenRetail.Bll.Api;
using OpenRetail.Model;
using OpenRetail.Repository.Api;
using OpenRetail.Repository.Service;

namespace OpenRetail.Bll.Service
{
    public class TransferStokBll : ITransferStokBll
    {
        private ILog _log;
        private IUnitOfWork _unitOfWork;

        private bool _isUseWebAPI;
        private string _baseUrl;

        public TransferStokBll(ILog log)
        {
            _log = log;
        }

        public TransferStokBll(
            bool isUseWebAPI,
            string baseUrl,
            ILog log) : this(log)
        {
            _isUseWebAPI = isUseWebAPI;
            _baseUrl = baseUrl;
        }

        public int Save(
            TransferStok transfer,
            ref ValidationError validationError)
        {
            var result = 0;

            if (_isUseWebAPI)
            {
                _unitOfWork = new UnitOfWork(
                    _isUseWebAPI,
                    _baseUrl,
                    _log);

                result = _unitOfWork
                    .TransferStokRepository
                    .Save(transfer);
            }
            else
            {
                using (IDapperContext context =
                    new DapperContext())
                {
                    _unitOfWork =
                        new UnitOfWork(context, _log);

                    result = _unitOfWork
                        .TransferStokRepository
                        .Save(transfer);
                }
            }

            return result;
        }
    }
}