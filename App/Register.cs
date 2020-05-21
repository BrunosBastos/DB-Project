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
using System.Text.RegularExpressions;
using System.Globalization;

namespace App
{
    public partial class Register : Form
    {

        
        public Register()
        {
            InitializeComponent();
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
        private static bool IsValidEmail(string email)
        {
            string pattern = @"^(?!\.)(""([^""\r\\]|\\[""\r\\])*""|" + @"([-a-z0-9!#$%&'*+/=?^_`{|}~]|(?<!\.)\.)*)(?<!\.)" + @"@[a-z0-9][\w\.-]*[a-z0-9]\.[a-z][a-z\.]*[a-z]$";
            var regex = new Regex(pattern, RegexOptions.IgnoreCase);
            return regex.IsMatch(email);
        }

        private void register(object sender, EventArgs e)
        {
            String email = RegisterEmail.Text;
            String pass = RegisterPassword.Text;
            String cpass = RegisterCPassword.Text;
            String fullname = RegisterFullName.Text;
            String registerDate = DateTime.Now.Year.ToString()+ "-" + DateTime.Now.Month.ToString() + "-"  + DateTime.Now.Day.ToString() ;
            String username = RegisterUsername.Text;
            String byear = RegisterBYear.Text;
            String bmonth = RegisterBMonth.Text;
            String bday = RegisterBDay.Text;
            String sex = "";
            String birth = byear + "-" + bmonth + "-" + bday;
            if (RegisterSMale.Checked)
                sex = "M";
            else if(RegisterSFemale.Checked)
            {
                sex = "F";
            }
            if(email.Length==0 || username.Length==0 || pass.Length==0 || cpass.Length==0 )
            {
                MessageBox.Show("Please fill all the necessary information.");
                return;
            }
            else if (!pass.Equals(cpass))
            {
                MessageBox.Show("Passwords do not match.");
                return;
            }
            else if (!IsValidEmail(email))
            {
                MessageBox.Show("Your email is not valid!");
                return;
            }
            else if (!ValidateDate(birth) || Int32.Parse(byear)<1900)
            {
                MessageBox.Show("Not a valid birth date.");
                return;
            }
            if (Program.verifySGBDConnection()) 
            { 

                SqlCommand ve = new SqlCommand("select Project.udf_check_email('" + email + "')", Program.cn);
                int value = (int)ve.ExecuteScalar();
                if(value == 0)
                {
                    MessageBox.Show("Email is already in use");
                    return;
                }

                SqlCommand vu = new SqlCommand("select Project.udf_check_username('" + username + "')", Program.cn);
                value = (int)vu.ExecuteScalar();
                if (value == 0)
                {
                    MessageBox.Show("UserName is already in use");
                    return;
                }

           
                SqlCommand cm = new SqlCommand("Project.pd_sign_up");
                cm.CommandType = CommandType.StoredProcedure;
                cm.Parameters.AddWithValue("@email", SqlDbType.VarChar).Value= email.Trim();
                cm.Parameters.AddWithValue("@password", SqlDbType.VarChar).Value = pass.Trim();
                cm.Parameters.AddWithValue("@registerDate", SqlDbType.Date).Value=DateTime.Parse(registerDate);
                cm.Parameters.AddWithValue("@userName", SqlDbType.VarChar).Value=username.Trim();
                cm.Parameters.AddWithValue("@fullName", SqlDbType.VarChar).Value=fullname.Trim();
                cm.Parameters.AddWithValue("@sex", SqlDbType.Char).Value=Char.Parse(sex);
                cm.Parameters.AddWithValue("@birth", SqlDbType.Date).Value = DateTime.Parse(birth);
                cm.Parameters.Add(new SqlParameter("@response", SqlDbType.Int, 10));
                cm.Parameters["@response"].Direction = ParameterDirection.Output;
                cm.Connection = Program.cn;
                cm.ExecuteNonQuery();

                Console.WriteLine(cm.Parameters["@response"].Value);
                
                
                if ((int)cm.Parameters["@response"].Value == 1)
                {
                    MessageBox.Show("You have been registered!");
                }
                else
                {
                    MessageBox.Show("Could not create user. Try again...");
                }

            }
            else
            {
                MessageBox.Show("Could not access database. Verify internet connection");
            }
        }
    }
}
