using OpenRetail.Model;

namespace OpenRetail.Bll.Api
{
    public interface ILisensiBll
    {
        Lisensi GetLisensi();
        int Save(Lisensi obj);
    }
}
