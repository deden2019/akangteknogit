using Dapper.Contrib.Extensions;

namespace OpenRetail.Model
{
    [Table("m_cabang")]
    public class Cabang
    {
        [ExplicitKey]
        public string cabang_id { get; set; }

        public string nama_cabang { get; set; }
    }
}