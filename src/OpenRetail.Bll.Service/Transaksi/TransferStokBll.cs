using OpenRetail.Bll.Api;
using OpenRetail.Model;
using OpenRetail.Repository.Api;

namespace OpenRetail.Bll.Service
{
    public class TransferStokBll : ITransferStokBll
    {
        private readonly ITransferStokRepository _repository;

        public TransferStokBll(
            ITransferStokRepository repository)
        {
            _repository = repository;
        }

        public int Save(
            TransferStok transfer,
            ref ValidationError validationError)
        {
            return _repository.Save(transfer);
        }
    }
}