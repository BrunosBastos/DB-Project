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

            if (Program.verifySGBDConnection())
            {
                SqlCommand cmd = new SqlCommand("Select * From Project.udf_getCompanyDetails(" + IDCompany + ")", Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();
                reader.Read();

                CName.Text = reader["CompanyName"].ToString();
                Contact.Text = reader["Contact"].ToString();
                Website.Text = reader["Website"].ToString();
                Country.Text = reader["Country"].ToString();
                City.Text = reader["City"].ToString();
                FoundationDate.Text = reader["FoundationDate"].ToString().Split(' ').ToArray()[0];
                if (!reader.IsDBNull(4))
                {
                    Logo.LoadAsync(reader["logo"].ToString());
                }




                reader.Close();

            }


        }

        private void Close(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
