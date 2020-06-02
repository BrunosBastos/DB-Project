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
using System.Web;
using System.Net;
using System.Globalization;


namespace App
{
    public partial class ClientMain : Form
    {
        private int current_game = 0;
        public ClientMain()
        {
            InitializeComponent();
            LoadGames();
        }


        // ClientMain

        private void LogOut(object sender, EventArgs e)
        {
            Program.currentUser = 0;
            this.Hide();
            Login l = new Login();
            l.ShowDialog();
            this.Close();
        }

        private void Change_tabs(object sender, EventArgs e)
        {

            Console.WriteLine("selected index" + tabControl1.SelectedIndex);
            if (tabControl1.SelectedIndex == 0)
            {
                Console.WriteLine("Inside tab Your games");
                LoadGames();
            }
            else if (tabControl1.SelectedIndex == 1)
            {
                LoadStore();
                Console.WriteLine("Inside tab Store");

            }
            else if (tabControl1.SelectedIndex == 2)
            {
                Console.WriteLine("Inside tab Profile");

            }
            else if (tabControl1.SelectedIndex == 3)
            {
                Console.WriteLine("Inside tab Follows");
            }
            else if (tabControl1.SelectedIndex == 4)
            {
                LoadAddCredit();
                Console.WriteLine("Inside tab Transactions");
            }

        }




        // Your Games
        private void LoadGames()
        {

            Console.WriteLine("Load Games");
            if (!Program.verifySGBDConnection())
                return;


            SqlCommand cmd = new SqlCommand("SELECT * FROM Project.[udf_checkusersgames](" + Program.currentUser + ")", Program.cn);
            SqlDataReader reader = cmd.ExecuteReader();
            listBox1.Items.Clear();

            while (reader.Read())
            {
                Game g = new Game();
                g.IDGame = reader["IDGame"].ToString();
                g.Name=reader["Name"].ToString();
                g.Description = reader["Description"].ToString();
                g.ReleaseDate = reader["ReleaseDate"].ToString();
                g.Price = reader["Price"].ToString();
                g.IDCompany = reader["IDCompany"].ToString();
                g.IDFranchise = reader["IDFranchise"].ToString();
                g.AgeRestriction = reader["AgeRestriction"].ToString();

                g.CoverImg = "https://" + reader["CoverImg"].ToString();
                listBox1.Items.Add(g);
                
            }

            current_game = 0;
            reader.Close();
            ShowGame();

        }
 


        private void ShowGame()
        {
            if (listBox1.Items.Count == 0 | current_game < 0)
                return;
            Game g = new Game();
            g = (Game)listBox1.Items[current_game];

            // Change Review Button
            updateInterface(Program.currentUser,Int32.Parse(g.IDGame));

            MGDName.Text = g.Name;
            MGDDescription.Text = g.Description;
            MGDAgeRestriction.Text = g.AgeRestriction;
            MGDReleaseDate.Text = g.ReleaseDate.ToString().Split(' ').ToArray()[0];
            Console.WriteLine(g.CoverImg);
            if (g.CoverImg != "https://")
            {
                MGDImage.LoadAsync(g.CoverImg);
            }


            // Franchise and Company name
            if (Program.verifySGBDConnection())
            {
                SqlCommand cmd = new SqlCommand("Select Company.CompanyName From Project.Company where IDCompany=" + g.IDCompany, Program.cn);
                string name = (string)cmd.ExecuteScalar();
                MGDCompany.Text = name;
                cmd = new SqlCommand("Select Franchise.Name From Project.Franchise where IDFranchise=" + g.IDFranchise, Program.cn);
                string franchise = (string)cmd.ExecuteScalar();

                MGDFranchise.Text = franchise;

                cmd = new SqlCommand("Select PlatformName,PurchaseDate from Project.[udf_getPurchaseInfo](" + g.IDGame + "," +Program.currentUser  + ")",Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();
                reader.Read();
                MGDPlatform.Text = reader["PlatformName"].ToString();
                MGDAcquireDate.Text= reader["PurchaseDate"].ToString().Split(' ').ToArray()[0];
                reader.Close();
                cmd = new SqlCommand("Select * From Project.[udf_getGameGenres](" + g.IDGame + ")", Program.cn);
                reader = cmd.ExecuteReader();
                MGDGenre.Items.Clear();
                while (reader.Read())
                {
                    MGDGenre.Items.Add(reader["GenName"].ToString());
                }
                reader.Close();
            }
            
            
            
            
        }

        private void updateInterface(int UserID, int IDGame)
        { 
            if (!Program.verifySGBDConnection())
            {
                return;
            }
            Console.WriteLine("Dentro do updateInterface");
            Console.WriteLine(""+UserID + IDGame);
            SqlCommand comand = new SqlCommand("select Project.udf_checkReview (" + UserID + ","+IDGame+")", Program.cn);
            int value = (int)comand.ExecuteScalar();
            Console.WriteLine("return value:"+value);
            if (value > 0)
            {
                MCAddReview.Text = "Edit Review";
            }
            else
            {
                MCAddReview.Text = "Add Review";
            }
            Program.cn.Close();

        }

        private void UpdateCurrentGame(object sender, EventArgs e)
        {   
            current_game = listBox1.SelectedIndex;
            ShowGame();
        }

        private void AddReview(object sender, EventArgs e)
        {
            Game g = (Game)listBox1.Items[current_game];
            CreateReview cr = new CreateReview(Int32.Parse(g.IDGame));
            cr.ShowDialog();
        }

        private void goToCompanyDetails(object sender, EventArgs e)
        {
            Game g = (Game)listBox1.Items[current_game];
            CompanyDetails cd = new CompanyDetails(Int32.Parse(g.IDCompany));
            cd.ShowDialog();

        }

        private void goToFranchiseDetails(object sender, EventArgs e)
        {
            Game g = (Game)listBox1.Items[current_game];
            FranchiseDetails cd = new FranchiseDetails(Int32.Parse(g.IDFranchise));
            cd.ShowDialog();
        }

        private void goToGenreDetails(object sender, EventArgs e)
        {
            if (MGDGenre.Items.Count == 0)
            {
                MessageBox.Show("There are no Genres for this game.");
                return;
            }
            if (MGDGenre.SelectedIndex == -1)
            {
                MessageBox.Show("Please Select a Genre from the list.");
                return;
            }

            string genre = MGDGenre.Items[MGDGenre.SelectedIndex].ToString();
            // Create Genre Details;
            GenreDetails gd = new GenreDetails(genre);
            Console.WriteLine(genre);
            gd.ShowDialog();


        }

        private void goToPlatformDetails(object sender, EventArgs e)
        {
            string platform = MGDPlatform.Text;
            // Create PlatformDetails

            PlatformDetails gd = new PlatformDetails(platform);
            Console.WriteLine(platform);
            gd.ShowDialog();

        }

        private void goToViewReviews(object sender, EventArgs e)
        {
            Game g = (Game)listBox1.Items[current_game];
            ViewReviews vr = new ViewReviews(Int32.Parse(g.IDGame));
            vr.ShowDialog();
        }

        private void goToListGameOwner(object sender, EventArgs e)
        {
            if (listBox1.Items.Count==0)
            {
                return;
            }
            Game g = (Game)listBox1.Items[current_game];
            ListGameOwners lg = new ListGameOwners(int.Parse(g.IDGame));
            lg.ShowDialog();

        }





        // Store
        private void StoreViewReviews(object sender, EventArgs e)
        {
            Game g = (Game)listBox2.Items[current_game];
            ViewReviews vr = new ViewReviews(int.Parse(g.IDGame));
            vr.ShowDialog();
        }

        private void StoreViewCompanyDetails(object sender, EventArgs e)
        {
            Game g = (Game)listBox2.Items[current_game];
            CompanyDetails cd = new CompanyDetails(int.Parse(g.IDCompany));
            cd.ShowDialog();
        }

        private void StoreFranchiseDetails(object sender, EventArgs e)
        {
            Game g = (Game)listBox2.Items[current_game];
            FranchiseDetails cd = new FranchiseDetails(int.Parse(g.IDFranchise));
            cd.ShowDialog();
        }





        private void LoadStore()
        {

            if (Program.verifySGBDConnection())
            {
                SqlCommand cmd = new SqlCommand("Project.pd_filter_Games",Program.cn);
                cmd.CommandType = CommandType.StoredProcedure;
                if (StoreSearchGame.Text.Length==0)
                {
                    cmd.Parameters.AddWithValue("@GameName", DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@GameName", StoreSearchGame.Text);
                }

                // acabar isto






            }




        }












        // Transactions


        private void Change_transaction_tabs(object sender, EventArgs e)
        {

            if (tabControl2.SelectedIndex == 0) { 
               Console.WriteLine("Add credit");
               LoadAddCredit();
            }else if(tabControl2.SelectedIndex == 1)
            {
                ResetFilterCH(null, null);
                LoadCreditHistory();
                Console.WriteLine("Credit History");
            }else if(tabControl2.SelectedIndex == 2)
            {
                ResetFilterPH(null,null);
                LoadPurchaseHistory();
                Console.WriteLine("Purchase History");
            }

        }
        // Credit

        private void LoadAddCredit()
        {
            if (Program.verifySGBDConnection())
            {
                SqlCommand cmd = new SqlCommand("Select Balance From Project.Client where UserID="+Program.currentUser,Program.cn);
                decimal balance = (decimal)cmd.ExecuteScalar();
                AddCreditBalance.Text = balance.ToString();
            }


        }
        private void AddCredit(object sender, EventArgs e)
        {
            // DateCredit , MetCredit, ValueCredit, IDClient
            // Project.pd_inserCredit
            var checkedButton = groupBox15.Controls.OfType<RadioButton>()
                                      .FirstOrDefault(r => r.Checked);
            string RadioCheck = "";
            if (checkedButton != null)
            {
                RadioCheck = checkedButton.Text;
            }
            else
            {
                MessageBox.Show("Please choose a payment method.");
                return;
            }

            if (CreditAddAmount.TextLength == 0 || !Decimal.TryParse(CreditAddAmount.Text.Replace(".", ","), out decimal n) || CreditAddAmount.TextLength > 7)
            {
                MessageBox.Show("Please insert a valid amount");
                return;
            }

            if (Program.verifySGBDConnection())
            {
                SqlCommand cmd = new SqlCommand("Project.pd_insertCredit");
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@MetCredit", RadioCheck);
                cmd.Parameters.AddWithValue("@DateCredit", DateTime.Now);
                cmd.Parameters.AddWithValue("@ValueCredit", n);
                cmd.Parameters.AddWithValue("@IDClient", Program.currentUser);
                cmd.Connection = Program.cn;
                cmd.ExecuteNonQuery();
                MessageBox.Show("Your Credit has been added to your account.");
            }

            CreditAddAmount.Text = "";
            checkedButton.Checked = false;
        }

        // Purchase History

        private void LoadPurchaseHistory()
        {

            if (Program.verifySGBDConnection())
            {
                Console.WriteLine("Load Purchase History");
                DataTable dt = new DataTable();
                SqlCommand cmd = new SqlCommand("Project.pd_filter_PurchaseHistory",Program.cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IDClient",Program.currentUser);
                Console.WriteLine(PHGameName);
                Console.WriteLine(PHMinPrice);
                Console.WriteLine(PHMaxPrice);
                
                if (PHGameName.TextLength>0)
                {
                    cmd.Parameters.AddWithValue("@GameName", PHGameName.Text);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@GameName", DBNull.Value);
                }

                if (Decimal.TryParse(PHMaxPrice.Text,out decimal n1))
                {
                    cmd.Parameters.AddWithValue("@MaxValue",n1);
                }
                else if (PHMaxPrice.Text.Length==0)
                {
                    cmd.Parameters.AddWithValue("@MaxValue",null);
                }
                else
                {
                    MessageBox.Show("Insert a number in the Max Price");
                    return;
                }
                
                if (Decimal.TryParse(PHMinPrice.Text,out decimal n2))
                {
                    cmd.Parameters.AddWithValue("@MinValue", n2);
                }
                else if(PHMinPrice.Text.Length==0)
                {
                    cmd.Parameters.AddWithValue("@MinValue",DBNull.Value);
                }
                else
                {
                    MessageBox.Show("Insert a number in the Min Price");
                    return;
                }

                if(PHMaxPrice.Text.Length!=0 && PHMinPrice.Text.Length!=0 && n1 < n2)
                {
                    MessageBox.Show("Min Price cannot be higher than Max Price");
                    return;
                }


                // PHStartDay
                string startdate =PHStartYear.Text+ "-" +PHStartMonth.Text + "-" + PHStartDay.Text;
                if(ValidateDate(startdate)){
                    cmd.Parameters.AddWithValue("@MinDate", DateTime.Parse(startdate));
                }
                else if(startdate.Length==2)
                {
                    cmd.Parameters.AddWithValue("@MinDate", DBNull.Value);
                }
                else
                {
                    MessageBox.Show("That is not a valid date");
                    return;
                }


                Console.WriteLine(startdate);
                string enddate = PHEndYear.Text + "-" + PHEndMonth.Text + "-" + PHEndYear.Text;
                if (ValidateDate(enddate)){
                    cmd.Parameters.AddWithValue("@MaxDate", DateTime.Parse(enddate));
                }
                else if(enddate.Length==2)
                {
                    cmd.Parameters.AddWithValue("@MaxDate", DBNull.Value);
                }
                else
                {
                    MessageBox.Show("That is not a valid date");
                    return;
                }
                Console.WriteLine(enddate);

                if (startdate.Length > 2 && enddate.Length > 2)
                {
                    int comp = DateTime.Compare(DateTime.Parse(startdate), DateTime.Parse(enddate));
                    if (comp > 0)
                    {
                        MessageBox.Show("Starting Date cannot be after Ending Date");
                        return;
                    }
                }


                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                dataGridView2.ReadOnly = true;
                dataGridView2.DataSource = dt;

                
            }
        }

        private void ApplyFilterPurchase(object sender, EventArgs e)
        {
            LoadPurchaseHistory();
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

        private void PHGameName_change(object sender, EventArgs e)
        {
            LoadPurchaseHistory();
        }

        private void ResetFilterPH(object sender, EventArgs e)
        {
            PHGameName.Text = "";
            PHMaxPrice.Text = "";
            PHMinPrice.Text = "";
            PHStartDay.Text = "";
            PHStartMonth.Text = "";
            PHStartYear.Text = "";
            PHEndDay.Text = "";
            PHEndMonth.Text = "";
            PHEndYear.Text = "";

        }


        // Credit History

        private void ApplyFilterCredit(object sender, EventArgs e)
        {
            LoadCreditHistory();
        }


        private void LoadCreditHistory()
        {

            if (Program.verifySGBDConnection())
            {
                DataTable dt = new DataTable();
                SqlCommand cmd = new SqlCommand("Project.pd_filter_CreditHistory", Program.cn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IDClient", Program.currentUser);
                //cmd.Parameters.AddWithValue("@MinValue", min);
                //cmd.Parameters.AddWithValue("@MaxValue", max);
                //cmd.Parameters.AddWithValue("@MinDate", DateTime.Parse(startdate));
                //cmd.Parameters.AddWithValue("@MaxDate", DateTime.Parse(enddate));
                //cmd.Parameters.AddWithValue("@selectedMets", methods);

                string minprice = CreditMinPrice.Text;
                string maxprice = CreditMaxPrice.Text;
                string startday = CreditStartDay.Text;
                string startmonth = CreditStartMonth.Text;
                string startyear = CreditStartYear.Text;
                string endday = CreditEndDay.Text;
                string endmonth = CreditEndMonth.Text;
                string endyear = CreditEndYear.Text;
                string methods = "";
                for (int i = 0; i < CreditMethodList.CheckedItems.Count; i++)
                {
                    methods += CreditMethodList.CheckedItems[i].ToString() + ",";
                }
                Console.WriteLine(methods);
                if (!decimal.TryParse(minprice, out decimal min) && minprice.Length != 0)
                {
                    MessageBox.Show("Insert a number for the min price");
                    return;
                } 
                else if (minprice.Length == 0)
                {
                    cmd.Parameters.AddWithValue("@MinValue", DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@MinValue", min);
                }


                if (!decimal.TryParse(maxprice, out decimal max) && maxprice.Length != 0)
                {
                    MessageBox.Show("Insert a number for the max price");
                    return;
                }else if (maxprice.Length == 0)
                {
                    cmd.Parameters.AddWithValue("@MaxValue", DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@MaxValue", max);
                }


                if (max < min && minprice.Length!=0 && maxprice.Length!=0)
                {
                    MessageBox.Show("Max price cannot be lower than Min price");
                    return;
                }
                string startdate = startyear + "-" + startmonth + "-" + startday;
                string enddate = endyear + "-" + endmonth + "-" + endday;

                if (ValidateDate(startdate))
                {
                    cmd.Parameters.AddWithValue("@MinDate", DateTime.Parse(startdate));
                }
                else if (startdate.Length==2)
                {
                    cmd.Parameters.AddWithValue("@MinDate", DBNull.Value);
                }
                else
                {
                    MessageBox.Show("Starting date is not valid");
                    return;
                }


                if (ValidateDate(enddate))
                {
                    cmd.Parameters.AddWithValue("@MaxDate", DateTime.Parse(enddate));
                }
                else if (enddate.Length == 2)
                {
                    cmd.Parameters.AddWithValue("@MaxDate", DBNull.Value);
                }
                else
                {
                    MessageBox.Show("Ending date is not valid");
                    return;
                }
                if (startdate.Length > 2 && enddate.Length > 2)
                {
                    int comp = DateTime.Compare(DateTime.Parse(startdate), DateTime.Parse(enddate));
                    if (comp > 0)
                    {
                        MessageBox.Show("Starting Date cannot be after Ending Date");
                        return;
                    }
                }
                cmd.Parameters.AddWithValue("@selectedMets", methods);
                cmd.Connection = Program.cn;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                dataGridView1.ReadOnly = true;
                dataGridView1.DataSource = dt;

                
            }
        }

        private void ResetFilterCH(object sender, EventArgs e)
        {
            CreditMinPrice.Text = "";
            CreditMaxPrice.Text = "";
            CreditStartDay.Text = "";
            CreditStartMonth.Text = "";
            CreditStartYear.Text = "";
            CreditEndDay.Text = "";
            CreditEndMonth.Text = "";
            CreditEndYear.Text = "";
            for (int i = 0; i < CreditMethodList.Items.Count; i++)
            {
                CreditMethodList.SetItemChecked(i, true);
            }
            LoadCreditHistory();

        }

        
    }
}
