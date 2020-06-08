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
using System.Globalization;

namespace App
{
    public partial class AdminMain : Form
    {
        public AdminMain()
        {
            InitializeComponent();
        }

        private void changeTabs(object sender, EventArgs e)
        {
            if (tabControl1.SelectedIndex == 0)
            {
                Console.WriteLine("Inside DataBase");
            }
            else if(tabControl1.SelectedIndex==1)
            {
                Console.WriteLine("Inside Statistics");
            }
        }


        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }

        public bool ValidateDate(String date)
        {
            if (!string.IsNullOrEmpty(date))
            {
                string[] formats = { "yyyy-MM-dd", "dd-MM-yy" };
                DateTime value;

                if (!DateTime.TryParseExact(date, formats, new CultureInfo("en-UK"), DateTimeStyles.None, out value))
                {
                    Console.WriteLine(value);
                    return false;
                }
            }
            return true;
        }


        // Database
        private void changeTabsDatabase(object sender, EventArgs e)
        {

            if(tabControl2.SelectedIndex == 0)
            {
                Console.WriteLine("Inside Game");
            }else if (tabControl2.SelectedIndex == 1)
            {
                Console.WriteLine("Inside Discount");
            }else if (tabControl2.SelectedIndex == 2)
            {
                Console.WriteLine("Inside Genre");
            }else if (tabControl2.SelectedIndex == 3)
            {
                Console.WriteLine("Inside Company");
            }else if (tabControl2.SelectedIndex == 4)
            {
                LoadFranchise();
                Console.WriteLine("Inside Franchise");
            }else if (tabControl2.SelectedIndex == 5)
            {
                LoadPlatform();
                Console.WriteLine("Inside Platform");
            }else if (tabControl2.SelectedIndex == 6)
            {
                LoadAdmin();
                Console.WriteLine("Inside Admin");
            }
        }


        //Admin
        private void LoadAdmin()
        {
            if (Program.verifySGBDConnection())
            {
                SqlCommand cmd = new SqlCommand("Select Email From Project.[User] JOIN Project.[Admin] on [Admin].UserID=" +
                    "[User].UserID",Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();
                listBox1.Items.Clear();
                while (reader.Read())
                {
                    listBox1.Items.Add(reader["Email"].ToString());
                }
                reader.Close();
            }
        }
        private void selectAdmin(object sender, EventArgs e)
        {
            if (Program.verifySGBDConnection())
            {
                if(listBox1.SelectedIndex<0 || listBox1.SelectedIndex > listBox1.Items.Count)
                {
                    return;
                }

                string email = listBox1.SelectedItem.ToString();

                SqlCommand cmd = new SqlCommand("Select UserID From Project.[User] where Email='"+email+"'",Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();
                reader.Read();

                AdminUpdateEmail.Text = email;
                AdminUpdateUserID.Text = reader["UserID"].ToString();

                reader.Close();

            }


        }

        private void updateAdmin(object sender, EventArgs e)
        {

            if (Program.verifySGBDConnection())
            {

                string email = AdminUpdateEmail.Text;
                string password = AdminUpdatePassword.Text;
                string confirm = AdminUpdateCPassword.Text;

                if (!confirm.Equals(password))
                {
                    MessageBox.Show("Passwords do not match.");
                    return;
                }

                if (password.Length < 4 && password.Length!=0)
                {
                    MessageBox.Show("Password is too short.");
                    return;
                }

                if (!IsValidEmail(email) && email.Length!=0)
                {
                    MessageBox.Show("Email is not valid");
                    return;
                }

                SqlCommand cmd = new SqlCommand("Project.pd_UpdateUser");
                cmd.CommandType = CommandType.StoredProcedure;

                if (email.Length == 0)
                {
                    cmd.Parameters.AddWithValue("@Email",DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                }

                if (password.Length == 0)
                {
                    cmd.Parameters.AddWithValue("@Password", DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@Password", password);
                }
                if (AdminUpdateUserID.Text.Length == 0)
                {
                    MessageBox.Show("Select an Admin first");
                    return;
                }
                cmd.Parameters.AddWithValue("@UserID", int.Parse(AdminUpdateUserID.Text));
                cmd.Parameters.Add(new SqlParameter("@responseMsg", SqlDbType.VarChar, 255));
                cmd.Parameters.AddWithValue("@Username", DBNull.Value);
                cmd.Parameters.AddWithValue("@FullName", DBNull.Value);
                cmd.Parameters.AddWithValue("@Sex", DBNull.Value);
                cmd.Parameters.AddWithValue("@Birth", DBNull.Value);

                cmd.Parameters["@responseMsg"].Direction = ParameterDirection.Output;
                cmd.Connection = Program.cn;
                cmd.ExecuteNonQuery();

                MessageBox.Show(cmd.Parameters["@responseMsg"].Value.ToString());

                AdminUpdatePassword.Text = "";
                AdminUpdateCPassword.Text = "";



            }


        }

        private void addAdmin(object sender, EventArgs e)
        {
            if (Program.verifySGBDConnection())
            {
                string email = AdminAddEmail.Text;
                string password = AdminAddPassword.Text;
                string confirm = AdminAddCPassword.Text;

                if (!IsValidEmail(email) || email.Length>50)
                {
                    MessageBox.Show("That's not a valid email");
                    return;
                }

                if (!password.Equals(confirm))
                {
                    MessageBox.Show("Passwords do not match.");
                    return;
                }

                if (password.Length < 4 )
                {
                    MessageBox.Show("Password is too short.");
                    return;
                }
                if (password.Length > 20)
                {
                    MessageBox.Show("Password is too long.");
                    return;
                }

                SqlCommand cmd = new SqlCommand("Project.pd_insertAdmin",Program.cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Email",email);
                cmd.Parameters.AddWithValue("@Password", password);
                cmd.Parameters.AddWithValue("@RegisterDate", DateTime.Now);
                cmd.Parameters.Add(new SqlParameter("@res", SqlDbType.VarChar, 255));
                cmd.Parameters["@res"].Direction = ParameterDirection.Output;

                cmd.Connection = Program.cn;
                cmd.ExecuteNonQuery();

                MessageBox.Show(cmd.Parameters["@res"].Value.ToString());
                LoadAdmin();
            }
        }


        // Platform

        private void LoadPlatform()
        {
            if (Program.verifySGBDConnection())
            {
                SqlCommand cmd = new SqlCommand("Select PlatformName from Project.Platform",Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();
                listBox2.Items.Clear();
                while (reader.Read())
                {
                    listBox2.Items.Add(reader["PlatformName"].ToString());
                }
                reader.Close();
            }


        }



        private void selectPlatform(object sender, EventArgs e)
        {
            if(listBox2.SelectedIndex<0 || listBox2.SelectedIndex > listBox2.Items.Count)
            {
                return;
            }

            if (Program.verifySGBDConnection())
            {
                string name = listBox2.SelectedItem.ToString();
                SqlCommand cmd = new SqlCommand("Select * from Project.Platform where PlatformName='"+name+"'",Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();
                reader.Read();

                PlatformUpdateName.Text = reader["PlatformName"].ToString();
                PlatformUpdateProducer.Text = reader["Producer"].ToString();
                string rdate = reader["ReleaseDate"].ToString().Split(' ').ToArray()[0];
                PlatformUpdateDay.Text = rdate.Split('/')[0];
                PlatformUpdateMonth.Text = rdate.Split('/')[1];
                PlatformUpdateYear.Text = rdate.Split('/')[2];
                reader.Close();

            }
        }

        private void updatePlatform(object sender, EventArgs e)
        {

            

            if (Program.verifySGBDConnection())
            {
                if(PlatformUpdateName.Text.Length==0)
                {
                    MessageBox.Show("Select a Platform");
                    return;
                }


                if (PlatformUpdateProducer.Text.Length > 30)
                {
                    MessageBox.Show("Producer Name is too long");
                    return;
                }

                string date = PlatformUpdateYear.Text + "-" + PlatformUpdateMonth.Text + "-" + PlatformUpdateDay.Text;
                if(date.Length!=2 && !ValidateDate(date))
                {
                    MessageBox.Show("Date is not valid");
                }

                SqlCommand cmd = new SqlCommand("Project.pd_updatePlatform",Program.cn);
                cmd.CommandType = CommandType.StoredProcedure;

                if (PlatformUpdateProducer.Text.Length == 0)
                {
                    cmd.Parameters.AddWithValue("@Producer", DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@Producer", PlatformUpdateProducer.Text);
                }
                
                if (date.Length==2)
                {
                    cmd.Parameters.AddWithValue("@ReleaseDate", DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@ReleaseDate", DateTime.Parse(date));
                }
                cmd.Parameters.AddWithValue("@PlatformName", PlatformUpdateName.Text);
                cmd.Parameters.Add(new SqlParameter("@res", SqlDbType.VarChar, 255));
                cmd.Parameters["@res"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                MessageBox.Show(cmd.Parameters["@res"].Value.ToString());
                
            }

        }


        private void addPlatform(object sender, EventArgs e)
        {
            if (Program.verifySGBDConnection())
            {
                string name = PlatformAddName.Text;
                string producer = PlatformAddProducer.Text;
                string date = PlatformAddYear.Text + '-' + PlatformAddMonth.Text + "-" + PlatformAddDay.Text;

                if(name.Length==0 || name.Length > 30)
                {
                    MessageBox.Show("Name is empty or it's too long.");
                    return;
                }
                if(producer.Length==0 || producer.Length > 30)
                {
                    MessageBox.Show("Producer is empty or it's too long.");
                    return;
                }

                if (!ValidateDate(date))
                {
                    MessageBox.Show("Date is not valid");
                    return;
                }

                SqlCommand cmd = new SqlCommand("Project.pd_insertPlatforms",Program.cn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@PlatformName", name);
                cmd.Parameters.AddWithValue("@Producer", producer);
                cmd.Parameters.AddWithValue("@ReleaseDate",DateTime.Parse(date));
                cmd.Parameters.Add(new SqlParameter("@res", SqlDbType.VarChar, 255));
                cmd.Parameters["@res"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();

                MessageBox.Show(cmd.Parameters["@res"].Value.ToString());
                LoadPlatform();

                PlatformAddDay.Text = "";
                PlatformAddMonth.Text = "";
                PlatformAddName.Text = "";
                PlatformAddProducer.Text = "";
                PlatformAddProducer.Text = "";

            }
        }

        private void LoadFranchise()
        {
            if (Program.verifySGBDConnection())
            {
                SqlCommand cmd = new SqlCommand("Select IDFranchise,Name From Project.Franchise",Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();
                listBox3.Items.Clear();
                while (reader.Read())
                {
                    listBox3.Items.Add(reader["IDFranchise"].ToString()+" - "+reader["Name"].ToString());
                }
                reader.Close();
            }
        }

        private void selectFranchise(object sender, EventArgs e)
        {
            if (Program.verifySGBDConnection())
            {

                SqlCommand cmd = new SqlCommand("Select CompanyName From Project.Company",Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();
                FranchiseUpdateCompany.Items.Clear();
                while (reader.Read())
                {
                    FranchiseUpdateCompany.Items.Add(reader["CompanyName"].ToString());
                }
                reader.Close();

                int val= int.Parse(listBox3.SelectedItem.ToString().Split(' ').ToArray()[0]);
                cmd = new SqlCommand("Select * From Project.Franchise where IDFranchise="+val, Program.cn);
                reader = cmd.ExecuteReader();
                reader.Read();
                FranchiseUpdateID.Text = val.ToString();
                FranchiseUpdateLogo.Text = reader["Logo"].ToString();
                FranchiseUpdateName.Text = reader["Name"].ToString();
                int company = int.Parse(reader["IDCompany"].ToString());
                FranchiseUpdateCompany.SelectedIndex = company;
                reader.Close();
            }
        }

        private void updateFranchise(object sender, EventArgs e)
        {
            if (Program.verifySGBDConnection())
            {




            }
        }
    }
}
