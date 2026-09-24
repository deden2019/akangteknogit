using OpenRetail.Model;

namespace OpenRetail.Repository.Api
{
    public interface ILisensiRepository
    {
        Lisensi GetLisensi();
        int Save(Lisensi obj);
    }
}