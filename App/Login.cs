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

namespace App
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }
        private void login(object sender, EventArgs e)
        {

            if (Program.verifySGBDConnection())
            {

                String Email = LoginEmailBox.Text;
                String Password = LoginPasswordBox.Text;
                SqlCommand cm = new SqlCommand("Project.pd_Login");
                cm.CommandType = CommandType.StoredProcedure;
                cm.Parameters.Add(new SqlParameter("@Loginemail", SqlDbType.VarChar));
                cm.Parameters.Add(new SqlParameter("@password", SqlDbType.VarChar));
                cm.Parameters.Add(new SqlParameter("@response", SqlDbType.VarChar,1));
                cm.Parameters["@LoginEmail"].Value = Email;
                cm.Parameters["@password"].Value = Password;
                cm.Parameters["@response"].Direction = ParameterDirection.Output;
                cm.Connection = Program.cn;
                cm.ExecuteNonQuery();
                
                if (""+cm.Parameters["@response"].Value=="1")
                {
                    //check admin

                    SqlCommand comand = new SqlCommand("select Project.udf_isadmin ('" + Email + "')", Program.cn);
                    int value = (int)comand.ExecuteScalar();
                    Console.WriteLine(value);
                    if (value > 0)
                    {
                        Program.currentUser = value;
                        this.Hide();
                        AdminMain admin = new AdminMain();
                        admin.ShowDialog();
                        this.Close();
                    }
                    else
                    {
                        SqlCommand cmd = new SqlCommand("select Project.udf_isclient ('" + Email + "')", Program.cn);
                        value = (int)comand.ExecuteScalar();
                        Program.currentUser = value;
                        this.Hide();
                        ClientMain client = new ClientMain();
                        client.ShowDialog();
                        this.Close();

                    }

                    
                    Console.WriteLine("current_user " + Program.currentUser);
                }
                else
                {
                    MessageBox.Show("Incorrent Login"); 
                }
                Program.cn.Close();
            }
        }

       
        

        private void goToRegister(object sender, LinkLabelLinkClickedEventArgs e)
        {
            this.Hide();
            Register r = new Register();
            r.ShowDialog();
            this.Close();
        }
    }
}
