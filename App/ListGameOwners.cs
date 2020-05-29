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
    public partial class ListGameOwners : Form
    {

        private int IDGame;

        public ListGameOwners(int IDGame)
        {
            this.IDGame = IDGame;
            InitializeComponent();
            LoadOwners();
        }

        private void LoadOwners()
        {
            if (Program.verifySGBDConnection())
            {
                SqlCommand cmd = new SqlCommand("Select * From Project.[udf_checkGameofFollows]("+IDGame+","+Program.currentUser+")", Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    listBox1.Items.Add(reader["Username"].ToString());
                }

                reader.Close();
                if (listBox1.Items.Count > 0)
                {
                    listBox1.SelectedIndex = 0;
                    ShowUser();
                }
            }
        }

        private void ShowUser()
        {
            if(listBox1.SelectedIndex<0 || listBox1.SelectedIndex > listBox1.Items.Count)
            {
                return;
            }
            Username.Text = listBox1.Items[listBox1.SelectedIndex].ToString();
        }

        private void Close(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
