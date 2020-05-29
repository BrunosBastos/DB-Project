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
                SqlCommand cmd = new SqlCommand("Select Project.udf_countuserGames("+UserID+")", Program.cn);
                int ngames = (int)cmd.ExecuteScalar();
                NGames.Text = ngames.ToString();

                cmd = new SqlCommand("Select Project.udf_countuserFollowers("+UserID+")",Program.cn);
                int nfollowers = (int)cmd.ExecuteScalar();
                NFollowers.Text = nfollowers.ToString();






            }


        }

    }
}
