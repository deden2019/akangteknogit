using System;

namespace OpenRetail.Model
{
    public class Lisensi
    {
        public string lisensi_id { get; set; }
        public string nama_perusahaan { get; set; }
        public string kode_lisensi { get; set; }
        public DateTime tgl_aktif { get; set; }
        public DateTime tgl_expired { get; set; }
        public bool is_aktif { get; set; }

        public bool is_trial { get; set; }
        public string machine_id { get; set; }

        public bool is_permanent { get; set; }
    }
}