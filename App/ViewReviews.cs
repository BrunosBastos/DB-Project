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
    public partial class ViewReviews : Form
    {
        private int IDGame;

        public ViewReviews(int IDGame)
        {
            this.IDGame = IDGame;
            InitializeComponent();
            LoadReviews();

        }

        private void LoadReviews()
        {
            if (Program.verifySGBDConnection())
            {
                SqlCommand cmd = new SqlCommand("Select * FROM Project.[udf_getReviewsList] (" + IDGame + ")", Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();

                Review r=new Review();
                while (reader.Read())
                {
                    r = new Review();
                    r.game = reader["Name"].ToString();
                    r.title = reader["Title"].ToString();
                    r.username = reader["Username"].ToString();
                    r.rating = reader["Rating"].ToString();
                    r.dateReview = reader["DateReview"].ToString();
                    r.text = reader["Text"].ToString();
                    listBox1.Items.Add(r);
                }

                reader.Close();

                cmd = new SqlCommand("Select Project.[udf_getNumberOfReviews](" + IDGame + ")", Program.cn);
                int value = (int)cmd.ExecuteScalar();
                NumOfReviews.Text = value.ToString();

                GameRev.Text = r.game;
            }
        }

        private void ShowReview()
        {
            if (listBox1.SelectedIndex > -1)
            {

                Review r = (Review)listBox1.Items[listBox1.SelectedIndex];
                UsernameRev.Text = r.username;
            }

        }

        private void Close(object sender, EventArgs e)
        {
            this.Close();
        }

        private void changeReview(object sender, EventArgs e)
        {
            ShowReview();
        }

        private void goToReviewDetails(object sender, EventArgs e)
        {
            Review r = (Review)listBox1.Items[listBox1.SelectedIndex];

            ReviewDetails rd = new ReviewDetails(r);
            rd.ShowDialog();
        }
    }
}
