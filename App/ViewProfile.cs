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
    public partial class ViewProfile : Form
    {

        private int UserID;
        public ViewProfile(int UserID)
        {
            this.UserID = UserID;
            InitializeComponent();
            LoadProfile();
        }

        private void LoadProfile()
        {
            if (Program.verifySGBDConnection())
            {
                SqlCommand cmd = new SqlCommand("Select Project.udf_countuserGames(" + UserID + ")", Program.cn);
                int ngames = (int)cmd.ExecuteScalar();
                NGames.Text = ngames.ToString();

                cmd = new SqlCommand("Select Project.udf_countuserFollowers(" + UserID + ")", Program.cn);
                int nfollowers = (int)cmd.ExecuteScalar();
                NFollowers.Text = nfollowers.ToString();

                // query to get 
                cmd = new SqlCommand("SELECT Username From Project.Client where UserID=" + UserID, Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();
                reader.Read();

                Username.Text = reader["Username"].ToString();
               

                reader.Close();

                seeIfFollows();
                

            }


        }

        private void seeIfFollows()
        {

            SqlCommand cmd = new SqlCommand("Select Project.udf_checkIfFollows(" + Program.currentUser + "," + UserID + ")", Program.cn);
            int value = (int)cmd.ExecuteScalar();
            if (value > 0)
            {
                Follow.Visible = false;
                Unfollow.Visible = true;
            }
            else
            {
                Follow.Visible = true;
                Unfollow.Visible = false;
            }

        }


        private void CloseProfile(object sender, EventArgs e)
        {
            this.Close();
        }

        private void unfollow(object sender, EventArgs e)
        {
            if (Program.verifySGBDConnection())
            {
                SqlCommand cmd = new SqlCommand("Project.pd_deleteFollows",Program.cn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IDFollower", Program.currentUser);
                cmd.Parameters.AddWithValue("@IDFollowed", UserID);
                cmd.Parameters.Add(new SqlParameter("@res", SqlDbType.VarChar, 255));
                cmd.Parameters["@res"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                if (cmd.Parameters["@res"].Value.ToString().Equals("Success"))
                {
                    MessageBox.Show("User no longer being followed");
                    seeIfFollows();
                }
                else
                {
                    MessageBox.Show("Could not unfollow the user");
                }

            }
        }

        private void follow(object sender, EventArgs e)
        {
            if (Program.verifySGBDConnection())
            {
                SqlCommand cmd = new SqlCommand("Project.pd_insertFollows",Program.cn);
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@IDFollower",Program.currentUser);
                cmd.Parameters.AddWithValue("@IDFollowed", UserID);
                cmd.Parameters.Add(new SqlParameter("@res", SqlDbType.VarChar, 255));
                cmd.Parameters["@res"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                if (cmd.Parameters["@res"].Value.ToString().Equals("Success inserting new Follower"))
                {
                    MessageBox.Show("User is now being followed");
                    seeIfFollows();
                }
                else
                {
                    MessageBox.Show("User is already being followed");
                }


            }
        }
    }
}
