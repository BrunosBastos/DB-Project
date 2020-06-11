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
            LoadGame();
        }

        private void changeTabs(object sender, EventArgs e)
        {
            if (tabControl1.SelectedIndex == 0)
            {
                Console.WriteLine("Inside DataBase");
            }
            else if(tabControl1.SelectedIndex==1)
            {
                LoadStatistics();
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

                LoadGame();
                Console.WriteLine("Inside Game");
            }else if (tabControl2.SelectedIndex == 1)
            {
                LoadDiscount();
                Console.WriteLine("Inside Discount");
            }else if (tabControl2.SelectedIndex == 2)
            {
                LoadGenre();
                Console.WriteLine("Inside Genre");
            }else if (tabControl2.SelectedIndex == 3)
            {
                LoadCompany();
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

        //Franchise


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

                cmd = new SqlCommand("Select CompanyName From Project.Company",Program.cn);
                reader = cmd.ExecuteReader();
                FranchiseAddCompany.Items.Clear();
                while (reader.Read())
                {
                    FranchiseAddCompany.Items.Add(reader["CompanyName"].ToString());
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
                FranchiseUpdateCompany.SelectedIndex = company-1;
                reader.Close();
            }
        }

        private void updateFranchise(object sender, EventArgs e)
        {
            if (Program.verifySGBDConnection())
            {
                if (FranchiseUpdateName.Text.Length > 30)
                {
                    MessageBox.Show("Franchise name is too long.");
                    return;
                }
                string logo = FranchiseUpdateLogo.Text;
                if (logo.Length>8 && logo.Substring(0, 8).Equals("https://")){
                    logo = logo.Substring(8, logo.Length - 8);
                }
                Console.WriteLine(logo);

                SqlCommand cmd = new SqlCommand("Select IDCompany From Project.Company where CompanyName='" + FranchiseUpdateCompany.SelectedItem.ToString() + "'", Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();
                reader.Read();

                int val = int.Parse(reader["IDCompany"].ToString());

                reader.Close();
                
                cmd = new SqlCommand("Project.pd_updateFranchise ",Program.cn);
                cmd.CommandType = CommandType.StoredProcedure;

                int idfranchise = int.Parse(listBox3.SelectedItem.ToString().Split(' ').ToArray()[0]);

                cmd.Parameters.AddWithValue("@IDFranchise",idfranchise);
                if (FranchiseUpdateName.Text.Length==0)
                {
                    cmd.Parameters.AddWithValue("@Name",DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@Name", FranchiseUpdateName.Text);
                }

                cmd.Parameters.AddWithValue("@Logo", logo);
                cmd.Parameters.AddWithValue("@IDCompany",val);
                cmd.Parameters.Add(new SqlParameter("@res", SqlDbType.VarChar, 255));
                cmd.Parameters["@res"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();

                MessageBox.Show(cmd.Parameters["@res"].Value.ToString());

            }
        }

        private void addFranchise(object sender, EventArgs e)
        {

            if (Program.verifySGBDConnection())
            {

                string name = FranchiseAddName.Text;
                if(name.Length>30 || name.Length == 0)
                {
                    MessageBox.Show("Name must be between 0 and 30 chars long.");
                    return;
                }
                if(FranchiseAddCompany.SelectedIndex<0 || FranchiseAddCompany.SelectedIndex>FranchiseAddCompany.Items.Count)
                {
                    MessageBox.Show("Select a Company.");
                    return;
                }
                string company = FranchiseAddCompany.SelectedItem.ToString();
                if(company.Length == 0)
                {
                    MessageBox.Show("Select a company");
                    return;
                }

                SqlCommand cmd = new SqlCommand("Select IDCompany From Project.Company where CompanyName='" + FranchiseAddCompany.Text + "'", Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();
                reader.Read();
                int comp = int.Parse(reader["IDCompany"].ToString());
                reader.Close();

                cmd = new SqlCommand("Project.pd_insertFranchise");
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Name",name);
                cmd.Parameters.AddWithValue("@IDCompany", comp);
                if (FranchiseAddLogo.Text.Length == 0)
                {
                    cmd.Parameters.AddWithValue("@Logo", DBNull.Value);
                }
                else
                {
                    string logo = FranchiseAddLogo.Text;
                    if(logo.Length>8 && logo.Substring(0, 8).Equals("https://"))
                    {
                        logo = logo.Substring(8, logo.Length - 8);
                    }
                    cmd.Parameters.AddWithValue("@Logo", logo);
                }

                cmd.Parameters.Add(new SqlParameter("@res", SqlDbType.VarChar, 255));
                cmd.Parameters["@res"].Direction = ParameterDirection.Output;
                cmd.Connection = Program.cn;
                cmd.ExecuteNonQuery();
                MessageBox.Show(cmd.Parameters["@res"].Value.ToString());
                LoadFranchise();


            }


        }


        // Genre

        private void LoadGenre()
        {

            if (Program.verifySGBDConnection())
            {

                SqlCommand cmd = new SqlCommand("Select GenName From Project.Genre",Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();
                listBox5.Items.Clear();
                while (reader.Read())
                { 
                    listBox5.Items.Add(reader["GenName"].ToString());
                }
                reader.Close();
            }
        }
        private void selectGenre(object sender, EventArgs e)
        {
            if (Program.verifySGBDConnection())
            {

                string name = listBox5.SelectedItem.ToString();

                SqlCommand cmd = new SqlCommand("Select Description from Project.Genre Where GenName='" + name + "'", Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();

                reader.Read();

                GenreUpdateName.Text = name;
                GenreUpdateDescription.Text = reader["Description"].ToString();

                reader.Close();

            }
        }

        private void addGenre(object sender, EventArgs e)
        {

            if (Program.verifySGBDConnection())
            {
                if(GenreAddName.Text.Length==0 || GenreAddName.Text.Length > 50)
                {
                    MessageBox.Show("Genre Name has to be between 0 and 50 chars long.");
                    return;
                }

                


                SqlCommand cmd = new SqlCommand("Project.pd_insertGenres",Program.cn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@GenName", GenreAddName.Text);
                cmd.Parameters.AddWithValue("@Description", GenreAddDescription.Text);
                cmd.Parameters.Add(new SqlParameter("@res", SqlDbType.VarChar, 35));
                cmd.Parameters["@res"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();

                MessageBox.Show(cmd.Parameters["@res"].Value.ToString());
                LoadGenre();
                GenreAddDescription.Text = "";
                GenreAddName.Text = "";
            }
        }

        private void updateGenre(object sender, EventArgs e)
        {

            if (Program.verifySGBDConnection())
            {
                SqlCommand cmd = new SqlCommand("Project.pd_updateGenre", Program.cn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@GenName", GenreUpdateName.Text);
                cmd.Parameters.AddWithValue("@Description", GenreUpdateDescription.Text);
                cmd.Parameters.Add(new SqlParameter("@res", SqlDbType.VarChar, 255));
                cmd.Parameters["@res"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();

                MessageBox.Show(cmd.Parameters["@res"].Value.ToString());
            }
        }


        //Discount
        private void LoadDiscount()
        {
            if (Program.verifySGBDConnection())
            {
                //SqlCommand cmd = new SqlCommand("Select * From Project.Discount");
                SqlDataAdapter adapter = new SqlDataAdapter("Select * From Project.Discount",Program.cn);

                DataTable dt = new DataTable();
                adapter.Fill(dt);
                dataGridView7.DataSource = dt;
                dataGridView7.ReadOnly = true;

                SqlCommand cmd = new SqlCommand("Select IDGame,Name From Project.Game", Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();

                DiscountGameList.Items.Clear();
                while (reader.Read())
                {
                    DiscountGameList.Items.Add(reader["IDGame"].ToString() + " " + reader["Name"].ToString());
                }

                reader.Close();
            }
        }

        private void selectDiscount(object sender, EventArgs e)
        {
            int selectedrow = dataGridView7.CurrentCell.RowIndex;
            string promocode = dataGridView7.Rows[selectedrow].Cells[0].Value.ToString();
            //Console.WriteLine(promocode);

            DiscountUpdateCode.Text = promocode;
            DiscountUpdatePercentage.Text = dataGridView7.Rows[selectedrow].Cells[1].Value.ToString();
            string begin = dataGridView7.Rows[selectedrow].Cells[2].Value.ToString();
            Console.WriteLine(begin);
            DiscountUpdateBeginDay.Text = begin.Split('/').ToArray()[0].ToString();
            DiscountUpdateBeginMonth.Text = begin.Split('/').ToArray()[1].ToString();
            DiscountUpdateBeginYear.Text = begin.Split('/').ToArray()[2].ToString().Split(' ').ToArray()[0].ToString();

            string end = dataGridView7.Rows[selectedrow].Cells[3].Value.ToString();
            DiscountUpdateEndDay.Text = end.Split('/').ToArray()[0].ToString();
            DiscountUpdateEndMonth.Text = end.Split('/').ToArray()[1].ToString();
            DiscountUpdateEndYear.Text = end.Split('/').ToArray()[2].ToString().Split(' ').ToArray()[0].ToString();

            DiscountGamePromo.Text = promocode;

        }

        private void updateDiscount(object sender, EventArgs e)
        {

            if (Program.verifySGBDConnection())
            {
                string percentage = DiscountUpdatePercentage.Text;

                if(!int.TryParse(percentage,out int n) || percentage.Length == 0)
                {
                    MessageBox.Show("Percentage is a number between 0 and 100");
                    return;
                }

                if(n>100 || n < 0)
                {
                    MessageBox.Show("Percentage is between 0 and 100");
                    return;
                }

                string begin = DiscountUpdateBeginYear.Text + "-" + DiscountUpdateBeginMonth.Text + "-" + DiscountUpdateBeginDay.Text;
                string end = DiscountUpdateEndYear.Text + "-" + DiscountUpdateEndMonth.Text + "-" + DiscountUpdateEndDay.Text;

                if (!ValidateDate(begin))
                {
                    MessageBox.Show("Begin Date is not valid");
                    return;
                }

                if (!ValidateDate(end))
                {
                    MessageBox.Show("Ending Date is not valid");
                    return;
                }

                int comp = DateTime.Compare(DateTime.Parse(begin), DateTime.Parse(end));
                if (comp > 0)
                {
                    MessageBox.Show("Starting Date cannot be after Ending Date");
                    return;
                }

                SqlCommand cmd = new SqlCommand("Project.pd_updateDiscount",Program.cn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@PromoCode", int.Parse(DiscountUpdateCode.Text));
                cmd.Parameters.AddWithValue("@Percentage", n);
                cmd.Parameters.AddWithValue("@Begin", DateTime.Parse(begin));
                cmd.Parameters.AddWithValue("@End", DateTime.Parse(end));
                cmd.Parameters.Add(new SqlParameter("@res",SqlDbType.VarChar,255));
                cmd.Parameters["@res"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();

                MessageBox.Show(cmd.Parameters["@res"].Value.ToString());
                LoadDiscount();


                
            }
        }

        private void addDiscount(object sender, EventArgs e)
        {
            if (Program.verifySGBDConnection())
            {

                string percentage = DiscountAddPercentage.Text;
                string code = DiscountAddPromo.Text;
                string begin = DiscountAddBeginYear.Text + "-" + DiscountAddBeginMonth.Text + "-" + DiscountAddBeginDay.Text;
                string end = DiscountAddEndYear.Text + "-" + DiscountAddEndMonth.Text + "-" + DiscountAddEndDay.Text;

                if (!int.TryParse(percentage, out int n))
                {
                    MessageBox.Show("Percentage is a number between 0 and 100.");
                    return;
                }

                if (n > 100 || n < 0)
                {
                    MessageBox.Show("Percentage is a number between 0 and 100.");
                    return;
                }

                if(!int.TryParse(code,out int c))
                {
                    MessageBox.Show("PromoCode must be a number.");
                    return;
                }

                if (!ValidateDate(begin))
                {
                    MessageBox.Show("Begin Date is not valid.");
                    return;
                }

                if (!ValidateDate(end))
                {
                    MessageBox.Show("End Date is not valid.");
                    return;
                }

                SqlCommand cmd = new SqlCommand("Project.pd_insertDiscount", Program.cn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@PromoCode",c);
                cmd.Parameters.AddWithValue("@Percentage", n);
                cmd.Parameters.AddWithValue("@DateBegin", DateTime.Parse(begin));
                cmd.Parameters.AddWithValue("@DateEnd", DateTime.Parse(end));
                cmd.Parameters.Add(new SqlParameter("@res", SqlDbType.VarChar, 255));
                cmd.Parameters["@res"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();

                MessageBox.Show(cmd.Parameters["@res"].Value.ToString());
                LoadDiscount();
            }
        }

        private void addDiscountGame(object sender, EventArgs e)
        {

            if (Program.verifySGBDConnection())
            {

                SqlCommand cmd = new SqlCommand("Project.pd_insertDiscountGame",Program.cn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@PromoCode",int.Parse(DiscountGamePromo.Text));
                cmd.Parameters.AddWithValue("@IDGame", int.Parse(DiscountGameList.SelectedItem.ToString().Split(' ').ToArray()[0]));
                cmd.Parameters.Add(new SqlParameter("@res", SqlDbType.VarChar, 255));
                cmd.Parameters["@res"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();

                MessageBox.Show(cmd.Parameters["@res"].Value.ToString());
            }
        }

        private void removeDiscountGame(object sender, EventArgs e)
        {
            if (Program.verifySGBDConnection())
            {
                int idgame = int.Parse(DiscountGameList.SelectedItem.ToString().Split(' ').ToArray()[0]);
                int promo = int.Parse(DiscountGamePromo.Text);
                SqlCommand cmd = new SqlCommand("Project.pd_removeGameDiscount",Program.cn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IDGame",idgame);
                cmd.Parameters.AddWithValue("@PromoCode", promo);
                cmd.Parameters.Add(new SqlParameter("@res",SqlDbType.VarChar,255));

                cmd.Parameters["@res"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                MessageBox.Show(cmd.Parameters["@res"].Value.ToString());
            }
        }


        // Company
        private void LoadCompany()
        {

            if (Program.verifySGBDConnection())
            {

                SqlCommand cmd = new SqlCommand("Select IDCompany,CompanyName From Project.Company",Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();

                listBox4.Items.Clear();
                while (reader.Read())
                {
                    listBox4.Items.Add(reader["IDCompany"].ToString()+" "+reader["CompanyName"].ToString());
                }

                reader.Close();


            }
        }

        private void selectCompany(object sender, EventArgs e)
        {
            if (Program.verifySGBDConnection())
            {
                int idCompany = int.Parse(listBox4.SelectedItem.ToString().Split(' ').ToArray()[0]);
                SqlCommand cmd = new SqlCommand("Select * From Project.Company where IDCompany="+idCompany,Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();
                reader.Read();
                CompanyUpdateID.Text = reader["IDCompany"].ToString();
                CompanyUpdateName.Text = reader["CompanyName"].ToString();
                CompanyUpdateCity.Text = reader["City"].ToString();
                CompanyUpdateContact.Text = reader["Contact"].ToString();
                CompanyUpdateCountry.Text = reader["Country"].ToString();
                CompanyUpdateLogo.Text = reader["Logo"].ToString();
                CompanyUpdateWebsite.Text = reader["Website"].ToString();
                string date = reader["FoundationDate"].ToString().Split(' ').ToArray()[0];
                if (date.Length > 0)
                { 
                    CompanyUpdateYear.Text = date.Split('/').ToArray()[2];
                    CompanyUpdateMonth.Text = date.Split('/').ToArray()[1];
                    CompanyUpdateDay.Text = date.Split('/').ToArray()[0];
                }
                reader.Close();
            }
        }

        private void updateCompany(object sender, EventArgs e)
        {

            if (Program.verifySGBDConnection())
            {

                string name = CompanyUpdateName.Text;
                string contact = CompanyUpdateContact.Text;
                string logo = CompanyUpdateLogo.Text;
                string city = CompanyUpdateCity.Text;
                string country = CompanyUpdateCountry.Text;
                string date = CompanyUpdateYear.Text + "-" + CompanyUpdateMonth.Text + "-" + CompanyUpdateDay.Text;
                string site = CompanyUpdateWebsite.Text;


                if (name.Length>50 || name.Length==0)
                {
                    MessageBox.Show("Name is between 0 and 50 chars long.");
                    return;
                }

                if(contact.Length>50)
                {
                    MessageBox.Show("Contact cannot be more than 50 chars long.");
                    return;
                }

                if(logo.Length>8 && logo.Substring(0, 8).Equals("https://"))
                {
                    logo = logo.Substring(8, logo.Length - 8);
                }
                
                if(site.Length==0 || site.Length > 50)
                {
                    MessageBox.Show("Website must be between 0 and 50 chars long.");
                    return;
                }


                if (city.Length > 50)
                {
                    MessageBox.Show("City cannot be more than 50 chars long.");
                    return;
                }
                if (country.Length > 50)
                {
                    MessageBox.Show("Country cannot be more then 50 chars long.");
                    return;
                }

                if (!ValidateDate(date) && date.Length!=2)
                {
                    MessageBox.Show("Date is not valid.");
                    return;
                }


                SqlCommand cmd = new SqlCommand("Project.pd_updateCompany", Program.cn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IDCompany", CompanyUpdateID.Text);
                if (contact.Length == 0)
                {
                    cmd.Parameters.AddWithValue("@Contact", DBNull.Value);
                }
                else { 
                    cmd.Parameters.AddWithValue("@Contact", contact);
                }

                if (name.Length==0)
                {
                    cmd.Parameters.AddWithValue("@CompanyName",DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@CompanyName", name);
                }
                cmd.Parameters.AddWithValue("@Website", site);



                if (logo.Length == 0)
                {
                    cmd.Parameters.AddWithValue("@Logo", DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@Logo", logo);
                }

                if (date.Length == 2)
                {
                    cmd.Parameters.AddWithValue("@FoundationDate", DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@FoundationDate", DateTime.Parse(date));
                }

                if (city.Length == 0)
                {
                    cmd.Parameters.AddWithValue("@City", DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@City", city);
                }

                if (country.Length == 0)
                {
                    cmd.Parameters.AddWithValue("@Country", DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@Country", country);
                }

                cmd.Parameters.Add(new SqlParameter("@res", SqlDbType.VarChar, 255));
                cmd.Parameters["@res"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();

                MessageBox.Show(cmd.Parameters["@res"].Value.ToString());

            }
        }

        private void addCompany(object sender, EventArgs e)
        {


            string name = CompanyAddName.Text;
            string contact = CompanyAddContact.Text;
            string logo = CompanyAddLogo.Text;
            string city = CompanyAddCity.Text;
            string country = CompanyAddCountry.Text;
            string date = CompanyAddYear.Text + "-" + CompanyAddMonth.Text + "-" + CompanyAddDay.Text;
            string site = CompanyAddWebsite.Text;


            if (name.Length > 50 || name.Length == 0)
            {
                MessageBox.Show("Name is between 0 and 50 chars long.");
                return;
            }

            if (contact.Length > 50)
            {
                MessageBox.Show("Contact cannot be more than 50 chars long.");
                return;
            }

            if (logo.Length > 8 && logo.Substring(0, 8).Equals("https://"))
            {
                logo = logo.Substring(8, logo.Length - 8);
            }

            if (site.Length == 0 || site.Length > 50)
            {
                MessageBox.Show("Website must be between 0 and 50 chars long.");
                return;
            }


            if (city.Length > 50)
            {
                MessageBox.Show("City cannot be more than 50 chars long.");
                return;
            }
            if (country.Length > 50)
            {
                MessageBox.Show("Country cannot be more then 50 chars long.");
                return;
            }

            if (!ValidateDate(date) && date.Length != 2)
            {
                MessageBox.Show("Date is not valid.");
                return;
            }

            SqlCommand cmd = new SqlCommand("Project.pd_insertCompany",Program.cn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@CompanyName", name);
            cmd.Parameters.AddWithValue("@Website", site);
            cmd.Parameters.Add(new SqlParameter("@res", SqlDbType.VarChar, 255));
            cmd.Parameters["@res"].Direction = ParameterDirection.Output;
            if (contact.Length == 0)
            {
                cmd.Parameters.AddWithValue("@Contact", DBNull.Value);
            }
            else
            {
                cmd.Parameters.AddWithValue("@Contact", contact);
            }
            if (logo.Length == 0)
            {
                cmd.Parameters.AddWithValue("@Logo", DBNull.Value);
            }
            else
            {
                cmd.Parameters.AddWithValue("@Logo", logo);
            }
            if (date.Length == 2)
            {
                cmd.Parameters.AddWithValue("@FoundationDate", DBNull.Value);
            }
            else
            {
                cmd.Parameters.AddWithValue("@FoundationDate", DateTime.Parse(date));
            }
            if (city.Length == 0)
            {
                cmd.Parameters.AddWithValue("@City", DBNull.Value);
            }
            else
            {
                cmd.Parameters.AddWithValue("@City", city);
            }
            if (country.Length == 0)
            {
                cmd.Parameters.AddWithValue("@Country",DBNull.Value);
            }
            else { 
                cmd.Parameters.AddWithValue("@Country",country);
            }

            cmd.ExecuteNonQuery();

            MessageBox.Show(cmd.Parameters["@res"].Value.ToString());
            LoadCompany();

        }

        // Game


        private void LoadGame()
        {
            if (Program.verifySGBDConnection())
            {
                SqlCommand cmd = new SqlCommand("Select IDGame, Name from Project.Game",Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();
                listBox6.Items.Clear();
                while (reader.Read())
                {
                    listBox6.Items.Add(reader["IDGame"].ToString() + " " + reader["Name"].ToString());
                }
                reader.Close();
                setGame();
            }
        }

        private void setGame()
        {
            if (Program.verifySGBDConnection())
            {

                SqlCommand cmd = new SqlCommand("Select GenName from Project.Genre",Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();

                GameAddAllGenre.Items.Clear();
                GameUpdateAllGenre.Items.Clear();
                while (reader.Read())
                {
                    GameAddAllGenre.Items.Add(reader["GenName"].ToString());
                    GameUpdateAllGenre.Items.Add(reader["GenName"].ToString());
                }
                reader.Close();
                cmd = new SqlCommand("Select PlatformName from Project.Platform",Program.cn);
                reader = cmd.ExecuteReader();
                GameAddAllPlatforms.Items.Clear();
                GameUpdateAllPlatforms.Items.Clear();
                while (reader.Read())
                {
                    GameAddAllPlatforms.Items.Add(reader["PlatformName"].ToString());
                    GameUpdateAllPlatforms.Items.Add(reader["PlatformName"].ToString());
                }
                reader.Close();

                cmd = new SqlCommand("Select IDCompany,CompanyName from Project.Company",Program.cn);
                reader = cmd.ExecuteReader();
                GameUpdateCompany.Items.Clear();
                GameAddCompany.Items.Clear();

                while (reader.Read())
                {
                    GameUpdateCompany.Items.Add(reader["IDCompany"].ToString() + " " + reader["CompanyName"].ToString());
                    GameAddCompany.Items.Add(reader["IDCompany"].ToString() + " " + reader["CompanyName"].ToString());
                }

                reader.Close();

                cmd = new SqlCommand("Select IDFranchise,Name From Project.Franchise",Program.cn);
                reader = cmd.ExecuteReader();
                GameUpdateFranchise.Items.Clear();
                GameAddFranchise.Items.Clear();
                while (reader.Read())
                {
                    GameUpdateFranchise.Items.Add(reader["IDFranchise"].ToString() + " " + reader["Name"].ToString());
                    GameAddFranchise.Items.Add(reader["IDFranchise"].ToString() + " " + reader["Name"].ToString());
                }
                reader.Close();
            }
        }

        private void selectGame(object sender, EventArgs e)
        {
            if (Program.verifySGBDConnection())
            {
                if(listBox6.SelectedIndex<0 || listBox6.SelectedIndex > listBox6.Items.Count)
                {
                    return;
                }
                int id =int.Parse( listBox6.SelectedItem.ToString().Split(' ').ToArray()[0]);
                setGame();

                SqlCommand cmd = new SqlCommand("Select * From Project.udf_getGameDetails("+id+")",Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();
                reader.Read();
                GameUpdateID.Text = reader["IDGame"].ToString();
                GameUpdateName.Text = reader["Name"].ToString();
                GameUpdateAge.Text = reader["AgeRestriction"].ToString();
                GameUpdateDescription.Text = reader["Description"].ToString();
                string date = reader["ReleaseDate"].ToString().Split(' ').ToArray()[0];
                if (date.Length != 0)
                {
                    GameUpdateDay.Text = date.Split('/').ToArray()[0];
                    GameUpdateMonth.Text = date.Split('/').ToArray()[1];
                    GameUpdateYear.Text = date.Split('/').ToArray()[2];
                }
                GameUpdatePrice.Text = reader["Price"].ToString();
                GameUpdateImage.Text = reader["CoverImg"].ToString();
                GameUpdateCompany.SelectedIndex = int.Parse(reader["IDCompany"].ToString())-1;
                if (reader["IDFranchise"].ToString().Length != 0)
                {
                    GameUpdateFranchise.SelectedIndex = int.Parse(reader["IDFranchise"].ToString())-1; 
                }
                reader.Close();
                cmd = new SqlCommand("Select GenName from Project.GameGenre where IDGame="+id,Program.cn);
                reader = cmd.ExecuteReader();
                GameUpdateGenre.Items.Clear();
                while (reader.Read())
                {
                    GameUpdateGenre.Items.Add(reader["GenName"].ToString());
                    GameUpdateAllGenre.Items.Remove(reader["GenName"].ToString());

                }
                reader.Close();

                cmd = new SqlCommand("Select PlatformName From Project.PlatformReleasesGame where IDGame="+id,Program.cn);
                reader = cmd.ExecuteReader();
                GameUpdatePlatform.Items.Clear();
                while (reader.Read())
                {
                    GameUpdatePlatform.Items.Add(reader["PlatformName"].ToString());
                    GameUpdateAllPlatforms.Items.Remove(reader["PlatformName"].ToString());
                }

                reader.Close();


            }
        }

        private void updateAddGenre(object sender, EventArgs e)
        {
            int index = GameUpdateAllGenre.SelectedIndex;
            if(index<0 || index > GameUpdateAllGenre.Items.Count)
            {
                MessageBox.Show("Select a genre");
                return;
            }
            string genre = GameUpdateAllGenre.SelectedItem.ToString();
            GameUpdateGenre.Items.Add(genre);
            GameUpdateAllGenre.Items.Remove(genre);
        }

        private void removeUpdateGenre(object sender, EventArgs e)
        {
            int index = GameUpdateGenre.SelectedIndex;
            if (index < 0 || index > GameUpdateGenre.Items.Count)
            {
                MessageBox.Show("Select a genre");
                return;
            }

            string genre = GameUpdateGenre.SelectedItem.ToString();
            GameUpdateGenre.Items.Remove(genre);
            GameUpdateAllGenre.Items.Add(genre);
            GameUpdateAllGenre.Sorted = true;
        }

        private void updateAddPlatform(object sender, EventArgs e)
        {
            int index = GameUpdateAllPlatforms.SelectedIndex;
            if (index < 0 || index > GameUpdateAllPlatforms.Items.Count)
            {
                MessageBox.Show("Select a genre");
                return;
            }
            string genre = GameUpdateAllPlatforms.SelectedItem.ToString();
            GameUpdatePlatform.Items.Add(genre);
            GameUpdateAllPlatforms.Items.Remove(genre);
        }

        private void updateGame(object sender, EventArgs e)
        {

            if (Program.verifySGBDConnection())
            {
                int id = int.Parse(GameUpdateID.Text);
                string name = GameUpdateName.Text;
                string description = GameUpdateDescription.Text;
                string price = GameUpdatePrice.Text;
                string age = GameUpdateAge.Text;
                string date = GameUpdateYear.Text + "-" + GameUpdateMonth.Text + "-" + GameUpdateDay.Text;
                string company = GameUpdateCompany.Text.Split(' ').ToArray()[0];
                string franchise = GameUpdateFranchise.Text.Split(' ').ToArray()[0];
                string image = GameUpdateImage.Text;

                if (name.Length > 50 || name.Length == 0)
                {
                    MessageBox.Show("Name must be between 0 and 50 chars long");
                    return;
                }
                if (!decimal.TryParse(price, out decimal p))
                {
                    MessageBox.Show("Price must be a decimal");
                    return;
                }
                if (!int.TryParse(age, out int n) || n > 18 || n < 0)
                {
                    MessageBox.Show("Age Restriction must be a number between 0 and 18");
                    return;
                }
                if (!ValidateDate(date))
                {
                    MessageBox.Show("Date is not valid.");
                    return;
                }
                if (image.Length > 8 && image.Substring(0, 8).Equals("https://"))
                {
                    image = image.Substring(8, image.Length - 8);
                }
                SqlCommand cmd = new SqlCommand("Project.pd_updateGame", Program.cn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Price", p);
                cmd.Parameters.AddWithValue("@AgeRestriction", n);
                cmd.Parameters.AddWithValue("@ReleaseDate", DateTime.Parse(date));
                cmd.Parameters.AddWithValue("@IDCompany", int.Parse(company));
                if (franchise.Length != 0)
                {
                    cmd.Parameters.AddWithValue("@IDFranchise", int.Parse(franchise));
                }
                else
                {
                    cmd.Parameters.AddWithValue("@IDFranchise", DBNull.Value);
                }
                if (image.Length == 0)
                {
                    cmd.Parameters.AddWithValue("@CoverImg", DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@CoverImg", image);
                }
                if (description.Length == 0)
                {
                    cmd.Parameters.AddWithValue("@Description", DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@Description", description);
                }
                cmd.Parameters.AddWithValue("@IDGame",id);
                cmd.Parameters.Add(new SqlParameter("@res", SqlDbType.VarChar, 255));
                cmd.Parameters["@res"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();

                if (!cmd.Parameters["@res"].Value.ToString().Equals("Success updating Game Info!"))
                {
                    MessageBox.Show(cmd.Parameters["@res"].Value.ToString());
                    return;
                }
                LinkedList<string> genres = new LinkedList<string>();
                cmd = new SqlCommand("Select GenName From Project.GameGenre where IDGame=" + id, Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    genres.AddLast(reader["GenName"].ToString());
                }
                reader.Close();
                for (int i = 0; i < GameUpdateGenre.Items.Count; i++)
                {
                    if (!genres.Contains(GameUpdateGenre.Items[i].ToString()))
                    {
                        //Procedure para adicionar genero na tabela
                        cmd = new SqlCommand("Project.pd_addGameGenre", Program.cn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@IDGame", id);
                        cmd.Parameters.AddWithValue("@GenName", GameUpdateGenre.Items[i].ToString());
                        cmd.Parameters.Add(new SqlParameter("@res", SqlDbType.VarChar, 255));
                        cmd.Parameters["@res"].Direction = ParameterDirection.Output;

                        cmd.ExecuteNonQuery();
                        if (!cmd.Parameters["@res"].Value.ToString().Equals("Success adding genre"))
                        {
                            MessageBox.Show("Error updating the genres");
                            return;
                        }
                    }
                }

                for (int j = 0; j < genres.Count; j++)
                {
                    if (!GameUpdateGenre.Items.Contains(genres.ElementAt(j)))
                    {
                        //Procedure para remover genero da tabela
                        cmd = new SqlCommand("Project.pd_removeGameGenre",Program.cn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@IDGame",id);
                        cmd.Parameters.AddWithValue("@GenName",genres.ElementAt(j));
                        cmd.Parameters.Add(new SqlParameter("@res", SqlDbType.VarChar, 255));
                        cmd.Parameters["@res"].Direction = ParameterDirection.Output;

                        cmd.ExecuteNonQuery();
                        if (!cmd.Parameters["@res"].Value.ToString().Equals("Success"))
                        {
                            MessageBox.Show("Error updating the genres");
                            return;
                        }
                    }
                }

                LinkedList<string> platforms = new LinkedList<string>();
                cmd = new SqlCommand("Select PlatformName From Project.PlatformReleasesGame where IDGame=" + id, Program.cn);
                reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    platforms.AddLast(reader["PlatformName"].ToString());
                }
                reader.Close();
                for (int i = 0; i < GameUpdatePlatform.Items.Count; i++)
                {
                    if (!platforms.Contains(GameUpdatePlatform.Items[i].ToString()))
                    {
                        //Procedure para adicionar Platform na tabela
                        cmd = new SqlCommand("Project.pd_addPlatformToGame", Program.cn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@IDGame", id);
                        cmd.Parameters.AddWithValue("@PlatformName", GameUpdatePlatform.Items[i].ToString());
                        cmd.Parameters.Add(new SqlParameter("@res", SqlDbType.VarChar, 255));
                        cmd.Parameters["@res"].Direction = ParameterDirection.Output;

                        cmd.ExecuteNonQuery();
                        if (!cmd.Parameters["@res"].Value.ToString().Equals("Success adding Platform"))
                        {
                            MessageBox.Show("Error updating the genres");
                            return;
                        }

                    }
                }
                MessageBox.Show("Success updating the game");
            }





        }

        private void addGame(object sender, EventArgs e)
        {
            if (Program.verifySGBDConnection())
            {
                string name = GameAddName.Text;
                string description = GameAddDescription.Text;
                string price = GameAddPrice.Text;
                string age = GameAddAge.Text;
                string date = GameAddYear.Text + "-" + GameAddMonth.Text + "-" + GameAddDay.Text;
                string company = GameAddCompany.Text.Split(' ').ToArray()[0];
                string franchise = GameAddFranchise.Text.Split(' ').ToArray()[0];
                string image = GameAddImage.Text;

                if (name.Length > 50 || name.Length == 0)
                {
                    MessageBox.Show("Name must be between 0 and 50 chars long");
                    return;
                }
                if (!decimal.TryParse(price, out decimal p))
                {
                    MessageBox.Show("Price must be a decimal");
                    return;
                }
                if (!int.TryParse(age, out int n) || n > 18 || n < 0)
                {
                    MessageBox.Show("Age Restriction must be a number between 0 and 18");
                    return;
                }
                if (!ValidateDate(date))
                {
                    MessageBox.Show("Date is not valid.");
                    return;
                }
                if (image.Length > 8 && image.Substring(0, 8).Equals("https://"))
                {
                    image = image.Substring(8, image.Length - 8);
                }

                SqlCommand cmd = new SqlCommand("Project.pd_insert_Games",Program.cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Price", p);
                cmd.Parameters.AddWithValue("@AgeRestriction", n);
                cmd.Parameters.AddWithValue("@ReleaseDate", DateTime.Parse(date));
                cmd.Parameters.AddWithValue("@IDCompany", int.Parse(company));

                if (franchise.Length != 0)
                {
                    cmd.Parameters.AddWithValue("@IDFranchise", int.Parse(franchise));
                }
                else
                {
                    cmd.Parameters.AddWithValue("@IDFranchise", DBNull.Value);
                }
                if (image.Length == 0)
                {
                    cmd.Parameters.AddWithValue("@CoverImg", DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@CoverImg", image);
                }
                if (description.Length == 0)
                {
                    cmd.Parameters.AddWithValue("@Description", DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@Description", description);
                }

                cmd.Parameters.Add(new SqlParameter("@res", SqlDbType.VarChar, 255));
                cmd.Parameters["@res"].Direction = ParameterDirection.Output;
                cmd.Parameters.Add(new SqlParameter("@addedGameID", SqlDbType.Int));
                cmd.Parameters["@addedGameID"].Direction = ParameterDirection.Output;

                string genres = "";
                string platforms = "";

                for(int i = 0; i < GameAddGenre.Items.Count; i++)
                {
                    genres +=GameAddGenre.Items[i].ToString() +",";
                }

                for (int i = 0; i < GameAddPlatform.Items.Count; i++)
                {
                    platforms += GameAddPlatform.Items[i].ToString() + ",";
                }
                cmd.Parameters.AddWithValue("@platforms",platforms);
                cmd.Parameters.AddWithValue("@genres", genres);


                cmd.ExecuteNonQuery();
                MessageBox.Show(cmd.Parameters["@res"].Value.ToString());
            }

        }

        private void addAddGenre(object sender, EventArgs e)
        {
            int index = GameAddAllGenre.SelectedIndex;
            if (index < 0 || index > GameAddAllGenre.Items.Count)
            {
                MessageBox.Show("Select a genre");
                return;
            }
            string genre = GameAddAllGenre.SelectedItem.ToString();
            GameAddGenre.Items.Add(genre);
            GameAddAllGenre.Items.Remove(genre);
        }

        private void addAddPlatform(object sender, EventArgs e)
        {
            int index = GameAddAllPlatforms.SelectedIndex;
            if (index < 0 || index > GameAddAllPlatforms.Items.Count)
            {
                MessageBox.Show("Select a genre");
                return;
            }
            string genre = GameAddAllPlatforms.SelectedItem.ToString();
            GameAddPlatform.Items.Add(genre);
            GameAddAllPlatforms.Items.Remove(genre);
        }


        //Statistics
        private void LoadStatistics()
        {

            if (Program.verifySGBDConnection())
            {
                //most sold Platforms
                SqlDataAdapter adapter = new SqlDataAdapter("Select * from Project.udf_most_Sold_Platforms()", Program.cn);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                dataGridView1.DataSource = dt;
                dataGridView1.Columns[0].Width = 180;
                dataGridView1.Columns[1].Width = 50;
                dataGridView1.Columns[0].Name = "Platform";
                dataGridView1.Columns[1].Name = "Count";



                //Project.udf_most_Sold_Genres()
                adapter = new SqlDataAdapter("Select * from Project.udf_most_Sold_Genres()", Program.cn);
                DataTable dt2 = new DataTable();
                adapter.Fill(dt2);
                dataGridView2.DataSource = dt2;

                // udf_mostMoneySpent()
                adapter = new SqlDataAdapter("Select * from Project.udf_mostMoneySpent()", Program.cn);
                DataTable dt3 = new DataTable();
                adapter.Fill(dt3);
                dataGridView3.DataSource = dt3;

                //[udf_leastSoldGames]()
                adapter = new SqlDataAdapter("Select * from Project.[udf_leastSoldGames]()", Program.cn);
                DataTable dt4 = new DataTable();
                adapter.Fill(dt4);
                dataGridView4.DataSource = dt4;

               
                //[udf_mostSoldGames]()
                adapter = new SqlDataAdapter("Select * from Project.[udf_mostSoldGames]()", Program.cn);
                DataTable dt5 = new DataTable();
                adapter.Fill(dt5);
                dataGridView5.DataSource = dt5;

                SqlCommand cmd = new SqlCommand("Select * From Project.udf_getTotalMoney()", Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();
                reader.Read();
                TotalMoney.Text = reader["totMoney"].ToString();
                reader.Close();
            }
        }


    }
}
