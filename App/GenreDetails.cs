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
    public partial class GenreDetails : Form
    {

        private string genre;
        public GenreDetails(string genre)
        {
            this.genre = genre;
            InitializeComponent();
            LoadGenreDetails();
        }

        private void LoadGenreDetails()
        {
            // query para dar load aos campos do genero
        }

        private void CloseDetails(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
