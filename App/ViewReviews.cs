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

        }

        private void Close(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
