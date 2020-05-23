using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace App
{
    public partial class CreateReview : Form
    {
        private int IDGame;


        public CreateReview(int IDGame)
        {
            this.IDGame = IDGame;
            InitializeComponent();
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



            MessageBox.Show("Your Review has been added.");
            this.Close();

        }

        private void CancelReview(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
