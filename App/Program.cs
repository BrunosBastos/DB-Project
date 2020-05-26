using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data;
using System.Data.SqlClient;

namespace App
{
    static class Program
    {
        public static int currentUser;
        public static SqlConnection cn;
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new Login());
        }

        private static SqlConnection getSGBDConnection()
        {

            return new SqlConnection("data source= DESKTOP-F2O68HA; integrated security=true;initial catalog=LocalDB; password=BaXSq8AZt");
        }

        public static bool verifySGBDConnection()
        {
            if (cn == null)
                cn = getSGBDConnection();

            if (cn.State != ConnectionState.Open)
                cn.Open();

            return cn.State == ConnectionState.Open;
        }
    }
}
