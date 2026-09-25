namespace OpenRetail.WebAPI.Models.DTO
{
    public class MemberDashboardDTO
    {
        public string kode_customer { get; set; }
        public string nama_customer { get; set; }
        public int jumlah_transaksi { get; set; }
        public double total_belanja { get; set; }
    }
}