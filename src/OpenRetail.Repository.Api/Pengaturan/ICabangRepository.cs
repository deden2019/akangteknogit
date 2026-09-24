using System.Collections.Generic;
using OpenRetail.Model;

namespace OpenRetail.Repository.Api
{
    public interface ICabangRepository
    {
        IList<Cabang> GetAll();
    }
}