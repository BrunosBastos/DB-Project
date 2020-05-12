using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;


namespace TreinoBD
{
    public partial class Login : Form
    {
        private SqlConnection cn;

        public Login()
        {
            InitializeComponent();
        }

        private SqlConnection getSGBDConnection()
        {
            return new SqlConnection("data source= DESKTOP-F2O68HA;integrated security=true;initial catalog=Projeto");
        }

        private bool verifySGBDConnection()
        {
            if (cn == null)
                cn = getSGBDConnection();

            if (cn.State != ConnectionState.Open)
                cn.Open();

            return cn.State == ConnectionState.Open;
        }

        private void Login_Click(object sender, EventArgs e)
        {
            return;
        }

       
        private void GoToForm2(object sender, EventArgs e)
        {
            this.Hide();
            var frm = new Register();
            frm.ShowDialog();
            this.Close();
        }
    }
}
