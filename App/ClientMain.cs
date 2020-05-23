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
using System.Web;
using System.Net;


namespace App
{
    public partial class ClientMain : Form
    {
        private int current_game = 0;
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
                g.IDGame = reader["IDGame"].ToString();
                g.Name=reader["Name"].ToString();
                g.Description = reader["Description"].ToString();
                g.ReleaseDate = reader["ReleaseDate"].ToString();
                g.Price = reader["Price"].ToString();
                g.IDCompany = reader["IDCompany"].ToString();
                g.IDFranchise = reader["IDFranchise"].ToString();
                g.AgeRestriction = reader["AgeRestriction"].ToString();

                g.CoverImg = reader["CoverImg"].ToString();
                listBox1.Items.Add(g);
                ShowGame();
            }


            // fazer query para saber se ele ja tem uma review neste jogo ou n
            // e mudar o texto do botao para Edit Review caso ele tenha
            // assim como o conteudo do add review ja devia estar preenchido com
            // as cenas da review antiga

            Program.cn.Close();

        }


        private void ShowGame()
        {
            if (listBox1.Items.Count == 0 | current_game < 0)
                return;
            Game g = new Game();
            g = (Game)listBox1.Items[current_game];
            MGDName.Text = g.Name;
            MGDDescription.Text = g.Description;
            MGDCompany.Text = g.IDCompany;
            MGDFranchise.Text = g.IDFranchise;
            MGDAgeRestriction.Text = g.AgeRestriction;
            MGDDay.Text = g.ReleaseDate.Split('/').ToArray()[0];
            MGDMonth.Text = g.ReleaseDate.Split('/').ToArray()[1];
            MGDYear.Text = g.ReleaseDate.Split('/').ToArray()[2].Split(' ').ToArray()[0];
            MGDImage.LoadAsync("https://"+g.CoverImg);
            
            
            // querys para meter o genero, plataforma e aquire date




        }

        private void LogOut(object sender, EventArgs e)
        {
            Program.currentUser = 0;
            this.Hide();
            Login l = new Login();
            l.ShowDialog();
            this.Close();
        }

        private void Change_tabs(object sender, EventArgs e)
        {

            Console.WriteLine("selected index" + tabControl1.SelectedIndex);
            if (tabControl1.SelectedIndex == 0)
            {
                Console.WriteLine("Inside tab Your games");
                LoadGames();
            }else if(tabControl1.SelectedIndex == 1)
            {
                Console.WriteLine("Inside tab Store");
                
            }else if(tabControl1.SelectedIndex == 2)
            {
                Console.WriteLine("Inside tab Profile");

            }else if(tabControl1.SelectedIndex == 3)
            {
                Console.WriteLine("Inside tab Follows");
            }else if(tabControl1.SelectedIndex == 4)
            {
                Console.WriteLine("Inside tab Transactions");
            }

        }

        private void UpdateCurrentGame(object sender, EventArgs e)
        {
            current_game = listBox1.SelectedIndex;
            ShowGame();
        }

        private void AddReview(object sender, EventArgs e)
        {
            CreateReview cr = new CreateReview(current_game);
            cr.ShowDialog();
        }
    }
}
