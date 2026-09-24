using System.Linq;
using System.Management;
using System.Security.Cryptography;
using System.Text;

namespace OpenRetail.Helper
{
    public class HardwareHelper
    {
        public static string GetMachineId()
        {
            string raw =
                GetCpuId() +
                GetMotherboardSerial();

            using (SHA256 sha = SHA256.Create())
            {
                byte[] bytes = sha.ComputeHash(
                    Encoding.UTF8.GetBytes(raw));

                return string.Concat(
                    bytes.Select(
                        b => b.ToString("X2")));
            }
        }

        private static string GetCpuId()
        {
            try
            {
                foreach (ManagementObject mo in
                    new ManagementClass("Win32_Processor")
                    .GetInstances())
                {
                    return mo["ProcessorId"].ToString();
                }
            }
            catch
            {
            }

            return string.Empty;
        }

        private static string GetMotherboardSerial()
        {
            try
            {
                foreach (ManagementObject mo in
                    new ManagementClass("Win32_BaseBoard")
                    .GetInstances())
                {
                    return mo["SerialNumber"].ToString();
                }
            }
            catch
            {
            }

            return string.Empty;
        }
    }
}