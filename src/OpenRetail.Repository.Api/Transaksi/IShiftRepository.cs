using System.Collections.Generic;
using OpenRetail.Model;

namespace OpenRetail.Repository.Api
{
    public interface IShiftRepository
    {
        IList<Shift> GetAll();
    }
}