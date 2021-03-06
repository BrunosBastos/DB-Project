﻿using System;
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
                    Console.WriteLine("https://"+reader["logo"].ToString());
                    Logo.LoadAsync("https://"+reader["logo"].ToString());
                }
                else
                {
                    Logo.LoadAsync("https://lh3.googleusercontent.com/proxy/EyPq4EEmV1x0bWYRfIF9c8j0L2mE2GI5jJ_8D45ZbZn-eFiAQh8Q5td74dQYMzqV8llxG_l-a51zetbqqZ-e-tJBxUu3yqHPBwLQ14-20jxcW2Jq");
                }
                reader.Close();
                cmd = new SqlCommand("Select Project.udf_getNumberCompGames(" + IDCompany + ")", Program.cn);
                int ngames = (int)cmd.ExecuteScalar();
                NGames.Text = ngames.ToString();
                cmd = new SqlCommand("Select * from Project.udf_getCompGames (" + IDCompany + ")", Program.cn);
                reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    listBox2.Items.Add(reader["Name"].ToString());
                }
                reader.Close();
                cmd = new SqlCommand("Select Project.udf_getNumberFranchiseComp(" + IDCompany + ")", Program.cn);
                int nfranchises = (int)cmd.ExecuteScalar();
                NFranchises.Text = nfranchises.ToString();
                cmd = new SqlCommand("Select * From Project.udf_getFranchisesComp("+IDCompany+")",Program.cn);
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
