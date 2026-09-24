using System;
using System.Security.Cryptography;
using System.Text;

namespace AkangTekno.LicenseGenerator
{
    public static class LicenseGeneratorHelper
    {
        private const string SECRET_KEY =
            "AKANGTEKNO2026_POS_SECRET";

        public static string Generate(
            string machineId,
            DateTime expiredDate,
            bool isPermanent)
        {
            string raw;

            if (isPermanent)
            {
                raw = machineId
                     + "|PERMANENT|"
                     + SECRET_KEY;
            }
            else
            {
                raw = machineId
                     + "|"
                     + expiredDate.ToString("yyyyMMdd")
                     + "|"
                     + SECRET_KEY;
            }

            using (SHA256 sha = SHA256.Create())
            {
                byte[] bytes =
                    sha.ComputeHash(
                        Encoding.UTF8.GetBytes(raw));

                string hash =
                    BitConverter
                    .ToString(bytes)
                    .Replace("-", "");

                return string.Format(
                    "{0}-{1}-{2}-{3}",
                    hash.Substring(0, 4),
                    hash.Substring(4, 4),
                    hash.Substring(8, 4),
                    hash.Substring(12, 4));
            }
        }
    }
}