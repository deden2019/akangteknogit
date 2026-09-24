/**
 * Copyright (C) 2017 Kamarudin (http://coding4ever.net/)
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 *
 * The latest version of this file can be found at https://github.com/rudi-krsoftware/open-retail
 */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;

using log4net;
using System.Globalization;
using System.Threading;
using CrashReporterDotNET;

using OpenRetail.Model;
using OpenRetail.Helper;
using OpenRetail.App.Cashier.Main;

[assembly: log4net.Config.XmlConfigurator(Watch = true)]
namespace OpenRetail.App.Cashier
{
    static class MainProgram
    {
        /// <summary>
        /// Instance log4net
        /// </summary>
        public static readonly ILog log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// Url informasi update terbaru, untuk petunjuknya cek: http://coding4ever.net/blog/2016/01/10/paket-nuget-yang-wajib-dicoba-bagian-number-2-autoupdater-dot-net/
        /// </summary>
        public static readonly string onlineUpdateUrlInfo = "https://raw.githubusercontent.com/deden2019/OpenRetail/master/updater/open-retail-cashier-auto-updater.xml";
        public static readonly string stageOfDevelopment = "";
        public static readonly string appName = "Open Retail (Cashier) AkangTekno";
        public static readonly string currentVersion = Utils.GetCurrentVersion();
        public static string shiftId = string.Empty;
        public static string namaShift = string.Empty;

        /// <summary>
        /// Kode unik untuk enkripsi password menggunakan metode md5
        /// Untuk alasan keamanan, sebaiknya nilai ini diganti
        /// </summary>
        public static readonly string securityCode = "BhGr7YwZpdX7ubFuZCuU";

        public static Profil profil = null;
        public static Pengguna pengguna = null;

        public static string CabangId { get; set; }


        public static PengaturanUmum pengaturanUmum = null;
        public static SettingPort settingPort = null;
        public static SettingCustomerDisplay settingCustomerDisplay = null;
        public static SettingLebarKolomTabelTransaksi settingLebarKolomTabelTransaksi = null;
        public static IList<Kartu> listOfKartu = null;
        public static string mesinId;

        private static bool _isLogout;

        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            AppContext.SetSwitch("Npgsql.EnableLegacyTimestampBehavior", true);

            // Tangkap semua unhandled exception dan tampilkan MessageBox
            Application.ThreadException += delegate (object sender, ThreadExceptionEventArgs e)
            {
                ReportCrash(e.Exception);
            };

            AppDomain.CurrentDomain.UnhandledException += delegate (object sender, UnhandledExceptionEventArgs e)
            {
                ReportCrash((Exception)e.ExceptionObject);
            };

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);

            Login();
        }

        static void ReportCrash(Exception exception)
        {
            // Tampilkan pesan error di layar
            MessageBox.Show(
                "Terjadi kesalahan pada aplikasi:\n\n" + exception.Message +
                "\n\nDetail:\n" + exception.StackTrace,
                "Error OpenRetail Cashier",
                MessageBoxButtons.OK,
                MessageBoxIcon.Error
            );
        }

        static void frmMain_FormClosed(object sender, FormClosedEventArgs e)
        {
            _isLogout = ((FrmMain)sender).IsLogout;
        }

        static void Login()
        {
            var frmMain = new FrmMain();
            frmMain.FormClosed += frmMain_FormClosed;

            var frmLogin = new FrmLogin();
            if (frmLogin.ShowDialog(frmMain) == DialogResult.OK)
            {
                // set Default RegionalSetting menggunakan United States
                SetDefaultRegionalSetting();

                frmMain.InisialisasiData();
                Application.Run(frmMain);

                if (_isLogout)
                    Login();
                else
                    Application.Exit();
            }
            else
                Application.Exit();
        }

        static void SetDefaultRegionalSetting()
        {
            var cultureInfo = Thread.CurrentThread.CurrentCulture;
            var regionInfo = new RegionInfo(cultureInfo.LCID);

            string englishName = regionInfo.EnglishName;

            if (!(englishName == "United States"))
            {
                try
                {
                    Thread.CurrentThread.CurrentCulture = new CultureInfo("en-US");
                }
                catch
                {
                }
            }
        }
    }
}
