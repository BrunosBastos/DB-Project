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
    public partial class PlatformDetails : Form
    {

        private string platform;
        public PlatformDetails(string platform)
        {
            this.platform = platform;
            InitializeComponent();
            LoadPlatformDetails();
        }

        private void LoadPlatformDetails()
        {
            if (Program.verifySGBDConnection())
            {
                SqlCommand cmd = new SqlCommand("Select * From Project.udf_getPlatformDetails('"+platform+"')", Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();
                reader.Read();
                PlatformName.Text = reader["PlatformName"].ToString();
                Producer.Text = reader["Producer"].ToString();
                ReleaseDate.Text = reader["ReleaseDate"].ToString().Split(' ').ToArray()[0];
                reader.Close();

                cmd = new SqlCommand("Select * From Project.udf_getPlatformGames('"+platform+"')",Program.cn);
                reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    listBox1.Items.Add(reader["Name"].ToString());
                }
                reader.Close();

                cmd = new SqlCommand("Select Project.udf_getNumberPlatformGames('"+platform+"')",Program.cn);
                NGames.Text = ((int)cmd.ExecuteScalar()).ToString();

            }
        }

        private void Close(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
