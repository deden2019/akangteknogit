using OpenRetail.Model;

namespace OpenRetail.Bll.Api
{
    public interface ITransferStokBll
    {
        int Save(
            TransferStok transfer,
            ref ValidationError validationError);
    }
}