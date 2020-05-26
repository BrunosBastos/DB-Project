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
    public partial class ReviewDetails : Form
    {
        public Review r;

        public ReviewDetails(Review r)
        {
            this.r = r;
            InitializeComponent();
            Load();
        }


        private void Load()
        {
            Title.Text = r.title;
            Rating.Text = r.rating;
            User.Text = r.username;
            Game.Text = r.game;
            Content.Text = r.text;
            Date.Text = r.dateReview.Split(' ').ToArray()[0];

        }

        private void Close(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
