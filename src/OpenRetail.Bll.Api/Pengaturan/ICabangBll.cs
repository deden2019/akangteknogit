using System.Collections.Generic;
using OpenRetail.Model;

namespace OpenRetail.Bll.Api
{
    public interface ICabangBll
    {
        IList<Cabang> GetAll();
    }
}