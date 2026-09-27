using System.Collections.Generic;
using OpenRetail.Model;

namespace OpenRetail.Repository.Api
{
    public interface ITransferStokRepository
    {
        int Save(TransferStok obj);

        IList<TransferStok> GetAll();

        TransferStok GetByID(string id);

        int Delete(TransferStok obj);
    }
}