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
    public partial class CompanyDetails : Form
    {
        private int IDCompany;
        public CompanyDetails(int IDCompany)
        {
            this.IDCompany = IDCompany;
            InitializeComponent();
            LoadCompanyDetails();
        }

        private void LoadCompanyDetails()
        {
            // query to get the details of the company

        }

    }
}
