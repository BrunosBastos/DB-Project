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
    public partial class GenreDetails : Form
    {

        private string genre;
        public GenreDetails(string genre)
        {
            this.genre = genre;
            InitializeComponent();
            LoadGenreDetails();
        }

        private void LoadGenreDetails()
        {
            if (Program.verifySGBDConnection())
            {

                SqlCommand cmd= new SqlCommand("Select * from Project.udf_getGenreDetails ('"+genre+"')",Program.cn);
                SqlDataReader reader= cmd.ExecuteReader();
                reader.Read();
                GenreName.Text = reader["GenName"].ToString();
                Description.Text = reader["Description"].ToString();
                reader.Close();

                cmd = new SqlCommand("Select * from Project.udf_getGenreGames('" + genre + "')", Program.cn);
                reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    listBox1.Items.Add(reader["Name"].ToString());
                }
                reader.Close();

                cmd = new SqlCommand("Select Project.udf_getNumberGenreGames('" + genre+"')",Program.cn);
                NGames.Text = ((int)cmd.ExecuteScalar()).ToString();


            }



        }

        private void CloseDetails(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
