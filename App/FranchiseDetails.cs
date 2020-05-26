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
    public partial class FranchiseDetails : Form
    {
        private int IDFranchise;
        public FranchiseDetails(int IDFranchise)
        {
            this.IDFranchise = IDFranchise;
            InitializeComponent();
            LoadFranchiseDetails();
        }
        private void LoadFranchiseDetails()
        {
            // query to get the franchise details

        }
    }
}
