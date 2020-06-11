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
                //You
                cmd = new SqlCommand("Select Project.[udf_countuserGames](" + Program.currentUser + ")", Program.cn);
                int val = (int)cmd.ExecuteScalar();
                YouGames.Text = val.ToString();



                cmd = new SqlCommand("Select * From Project.udf_favComp("+Program.currentUser+")", Program.cn);
                reader = cmd.ExecuteReader();
                reader.Read();

                if (reader.HasRows)
                {
                    YouCompany.Text = reader["CompanyName"].ToString();
                }
                reader.Close();

                cmd = new SqlCommand("Select * From Project.udf_favGenre(" + Program.currentUser + ")", Program.cn);
                reader = cmd.ExecuteReader();
                reader.Read();
                if (reader.HasRows)
                {
                    YouGenre.Text = reader["GenName"].ToString();
                }
                reader.Close();

                cmd = new SqlCommand("Select * From Project.udf_favPlatform(" + Program.currentUser + ")", Program.cn);
                reader = cmd.ExecuteReader();
                reader.Read();
                if (reader.HasRows)
                {
                    YouPlatform.Text = reader["PlatformName"].ToString();
                }
                reader.Close();

                cmd = new SqlCommand("Select * From Project.udf_favFran(" + Program.currentUser + ")", Program.cn);
                reader = cmd.ExecuteReader();
                reader.Read();
                if (reader.HasRows)
                {
                    YouFranchise.Text = reader["Name"].ToString();
                }

                reader.Close();


                //User
                cmd = new SqlCommand("Select Project.[udf_countuserGames](" + other + ")", Program.cn);
                val = (int)cmd.ExecuteScalar();
                UserGames.Text = val.ToString();
                cmd = new SqlCommand("Select * From Project.udf_favComp(" + other + ")", Program.cn);
                reader = cmd.ExecuteReader();
                reader.Read();
                if (reader.HasRows)
                {
                    UserCompany.Text = reader["CompanyName"].ToString();
                } 
                reader.Close();

                cmd = new SqlCommand("Select * From Project.udf_favGenre(" + other + ")", Program.cn);
                reader = cmd.ExecuteReader();
                reader.Read();
                if (reader.HasRows)
                {
                    UserGenre.Text = reader["GenName"].ToString();
                }
                reader.Close();

                cmd = new SqlCommand("Select * From Project.udf_favPlatform(" + other + ")", Program.cn);
                reader = cmd.ExecuteReader();
                reader.Read();
                if (reader.HasRows)
                {
                    UserPlatform.Text = reader["PlatformName"].ToString();
                }
                reader.Close();

                cmd = new SqlCommand("Select * From Project.udf_favFran(" + other + ")", Program.cn);
                reader = cmd.ExecuteReader();
                reader.Read();
                if (reader.HasRows)
                {
                    UserFranchise.Text = reader["Name"].ToString();
                }

                reader.Close();



            }
        }

        private void close(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
