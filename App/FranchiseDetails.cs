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
            // query to get the details of the company
            if (Program.verifySGBDConnection())
            {
                SqlCommand cmd = new SqlCommand("Select * From Project.udf_getFranchiseDetails(" + IDFranchise + ")", Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();
                reader.Read();

                FranchiseName.Text = reader["Name"].ToString();
                string idcomp = reader["IDCompany"].ToString();
                if (!reader.IsDBNull(2))
                {
                    Logo.LoadAsync("https://"+reader["logo"].ToString());
                }
                else
                {
                    Logo.LoadAsync("https://lh3.googleusercontent.com/proxy/EyPq4EEmV1x0bWYRfIF9c8j0L2mE2GI5jJ_8D45ZbZn-eFiAQh8Q5td74dQYMzqV8llxG_l-a51zetbqqZ-e-tJBxUu3yqHPBwLQ14-20jxcW2Jq");
                }
                reader.Close();
                cmd = new SqlCommand("Select CompanyName from Project.Company where IDCompany=" + idcomp, Program.cn);
                Company.Text = (string)cmd.ExecuteScalar();


                cmd = new SqlCommand("Select Project.udf_getNumberGameFranchises(" + IDFranchise + ")", Program.cn);
                int ngames = (int)cmd.ExecuteScalar();
                NGames.Text = ngames.ToString();
                cmd = new SqlCommand("Select * from Project.udf_getGamesFranchise (" + IDFranchise + ")", Program.cn);
                reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    listBox1.Items.Add(reader["Name"].ToString());
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
