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
    public partial class CompareGames : Form
    {
        private int other;
        public CompareGames(int other)
        {
            this.other = other;
            InitializeComponent();
            LoadGames();
        }


        private void LoadGames()
        {
            if (Program.verifySGBDConnection())
            {

                SqlCommand cmd = new SqlCommand("Select * FRom Project.[udf_checkAllGamesinCommon]("+Program.currentUser+","+other +")",Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();
                listBox1.Items.Clear();
                
                while (reader.Read())
                {
                    listBox1.Items.Add(reader["Name"].ToString());
                }
                reader.Close();

                GamesInCommon.Text = listBox1.Items.Count.ToString();

            }
        }

        private void close(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
