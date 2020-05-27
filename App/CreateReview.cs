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
    public partial class CreateReview : Form
    {
        private int IDGame;


        public CreateReview(int IDGame)
        {
            this.IDGame = IDGame;
            InitializeComponent();
            LoadReview();
        }


        private void LoadReview()
        {

            if (Program.verifySGBDConnection())
            {
                SqlCommand cmd = new SqlCommand("Select Project.udf_checkReview("+Program.currentUser+","+IDGame+")",Program.cn);
                int value = (int)cmd.ExecuteScalar();
                if (value > 0)
                {
                    cmd = new SqlCommand("Select Title,[Text],Rating From Project.Reviews where IDGame="+IDGame+" and UserID="+Program.currentUser,Program.cn);
                    SqlDataReader reader = cmd.ExecuteReader();
                    reader.Read();
                    TitleReview.Text = reader["Title"].ToString();
                    ContentReview.Text = reader["Text"].ToString();
                    RatingReview.Value = Decimal.Parse(reader["Rating"].ToString());
                    reader.Close();

                }
            }
        }

        private void ConfirmReview(object sender, EventArgs e)
        {
            // sql command to insert review on the db
            string title = TitleReview.Text;
            string content = ContentReview.Text;
            string rating = RatingReview.Text;

            Console.WriteLine("current game is " + IDGame);
            if (title.Length == 0 )
            {
                MessageBox.Show("Please insert a title");
                return;
            }else if(title.Length >= 100)
            {
                MessageBox.Show("Please choose a smaller title.");
                return;
            }

            if (content.Length == 0)
            {
                MessageBox.Show("Please write your opinion in the content box");
                return;
            }else if(content.Length>500)
            {
                MessageBox.Show("Please write a smaller message");
                return;
            }

            if (Program.verifySGBDConnection())
            {
                SqlCommand cmd = new SqlCommand("Project.pd_insertReview");
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@Text", content);
                cmd.Parameters.AddWithValue("@Rating", Double.Parse(rating));
                cmd.Parameters.AddWithValue("@DateReview", DateTime.Now);
                cmd.Parameters.AddWithValue("@UserID", Program.currentUser);
                cmd.Parameters.AddWithValue("@IDGame", IDGame);
                cmd.Connection = Program.cn;
                cmd.ExecuteNonQuery();
            }
            else
            {
                return;
            }



            MessageBox.Show("Your Review has been added.");
            this.Close();

        }

        private void CancelReview(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
