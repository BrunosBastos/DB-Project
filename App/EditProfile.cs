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
    public partial class EditProfile : Form
    {
        ClientMain cm;
        public EditProfile(ClientMain cm)
        {
            this.cm = cm;
            InitializeComponent();
        }

        public void confirm(object sender, EventArgs e)
        {
            if (Program.verifySGBDConnection())
            {
                
                SqlCommand cmd = new SqlCommand("Select  CONVERT(varchar(20), DECRYPTBYPASSPHRASE('**********',[Password])) as Password from Project.[User] where UserID=" + Program.currentUser,Program.cn);
                SqlDataReader reader = cmd.ExecuteReader();
                reader.Read();
                if (textBox1.Text.Equals(reader["Password"].ToString()))
                {
                    reader.Close();
                    cm.editProfile();
                    this.Close();
                }
                else
                {
                    MessageBox.Show("Wrong Password");

         
                }
                reader.Close();

            }
        }
    }
}
