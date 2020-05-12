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

    public partial class Register : Form
    {
        private SqlConnection cn;
        
        public Register()
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

        private void Register(object sender, EventArgs e)
        {
            return;

        }
    }
}
