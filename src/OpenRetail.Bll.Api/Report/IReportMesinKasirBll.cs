using OpenRetail.Model.Report;
using System;
using System.Collections.Generic;

namespace OpenRetail.Bll.Api.Report
{
    public interface IReportMesinKasirBll
    {
        IList<ReportMesinKasir> PerKasirGetByPenggunaId(
    string penggunaId,
    string shiftId,
    DateTime tanggal);
    }
}