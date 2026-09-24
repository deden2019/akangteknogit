using System.Collections.Generic;
using OpenRetail.Model;

namespace OpenRetail.Repository.Api
{
    public interface IProdukSatuanRepository
    {
        IList<ProdukSatuan> GetByProduk(
            string produkId);

        ProdukSatuan GetByBarcode(
            string barcode);

        int Save(ProdukSatuan obj);

        int DeleteByProduk(
            string produkId);
    }
}