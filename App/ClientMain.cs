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
    public partial class ClientMain : Form
    {
        public ClientMain()
        {
            InitializeComponent();
            LoadGames();
        }

        private void LoadGames()
        {

            Console.WriteLine("Load Games");
            if (!Program.verifySGBDConnection())
                return;

            SqlCommand cmd = new SqlCommand("SELECT * FROM Project.Game", Program.cn);
            SqlDataReader reader = cmd.ExecuteReader();
            listBox1.Items.Clear();

            while (reader.Read())
            {
                Game g = new Game();
                g.SetName(reader["Name"].ToString());
                listBox1.Items.Add(g);
            }

            Program.cn.Close();

        }


        private void ShowContact()
        {
            Game g = (Game)listBox1.SelectedItem;


        }

        private void LogOut(object sender, EventArgs e)
        {
            Program.currentUser = 0;
            this.Hide();
            Login l = new Login();
            l.ShowDialog();
            this.Close();
        }

        
    }
}
