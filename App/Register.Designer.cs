namespace App
{
    partial class Register
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.RegisterBDay = new System.Windows.Forms.TextBox();
            this.RegisterBMonth = new System.Windows.Forms.TextBox();
            this.RegisterBYear = new System.Windows.Forms.TextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.RegisterSFemale = new System.Windows.Forms.RadioButton();
            this.RegisterSMale = new System.Windows.Forms.RadioButton();
            this.RegisterFullName = new System.Windows.Forms.TextBox();
            this.RegisterUsername = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.RegisterButton = new System.Windows.Forms.Button();
            this.RegisterCPassword = new System.Windows.Forms.TextBox();
            this.RegisterPassword = new System.Windows.Forms.TextBox();
            this.RegisterEmail = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // RegisterBDay
            // 
            this.RegisterBDay.Location = new System.Drawing.Point(535, 84);
            this.RegisterBDay.Name = "RegisterBDay";
            this.RegisterBDay.Size = new System.Drawing.Size(51, 20);
            this.RegisterBDay.TabIndex = 36;
            this.RegisterBDay.Text = "dd";
            // 
            // RegisterBMonth
            // 
            this.RegisterBMonth.Location = new System.Drawing.Point(479, 85);
            this.RegisterBMonth.Name = "RegisterBMonth";
            this.RegisterBMonth.Size = new System.Drawing.Size(49, 20);
            this.RegisterBMonth.TabIndex = 35;
            this.RegisterBMonth.Text = "mm";
            // 
            // RegisterBYear
            // 
            this.RegisterBYear.Location = new System.Drawing.Point(403, 85);
            this.RegisterBYear.Name = "RegisterBYear";
            this.RegisterBYear.Size = new System.Drawing.Size(70, 20);
            this.RegisterBYear.TabIndex = 34;
            this.RegisterBYear.Text = "yyyy";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(45, 228);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(25, 13);
            this.label7.TabIndex = 33;
            this.label7.Text = "Sex";
            // 
            // RegisterSFemale
            // 
            this.RegisterSFemale.AutoSize = true;
            this.RegisterSFemale.Location = new System.Drawing.Point(135, 262);
            this.RegisterSFemale.Name = "RegisterSFemale";
            this.RegisterSFemale.Size = new System.Drawing.Size(59, 17);
            this.RegisterSFemale.TabIndex = 32;
            this.RegisterSFemale.TabStop = true;
            this.RegisterSFemale.Text = "Female";
            this.RegisterSFemale.UseVisualStyleBackColor = true;
            // 
            // RegisterSMale
            // 
            this.RegisterSMale.AutoSize = true;
            this.RegisterSMale.Location = new System.Drawing.Point(135, 228);
            this.RegisterSMale.Name = "RegisterSMale";
            this.RegisterSMale.Size = new System.Drawing.Size(48, 17);
            this.RegisterSMale.TabIndex = 31;
            this.RegisterSMale.TabStop = true;
            this.RegisterSMale.Text = "Male";
            this.RegisterSMale.UseVisualStyleBackColor = true;
            // 
            // RegisterFullName
            // 
            this.RegisterFullName.Location = new System.Drawing.Point(403, 32);
            this.RegisterFullName.MaxLength = 50;
            this.RegisterFullName.Name = "RegisterFullName";
            this.RegisterFullName.Size = new System.Drawing.Size(227, 20);
            this.RegisterFullName.TabIndex = 30;
            // 
            // RegisterUsername
            // 
            this.RegisterUsername.Location = new System.Drawing.Point(135, 160);
            this.RegisterUsername.MaxLength = 50;
            this.RegisterUsername.Name = "RegisterUsername";
            this.RegisterUsername.Size = new System.Drawing.Size(179, 20);
            this.RegisterUsername.TabIndex = 29;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(343, 83);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(28, 13);
            this.label6.TabIndex = 28;
            this.label6.Text = "Birth";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(343, 35);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(54, 13);
            this.label5.TabIndex = 27;
            this.label5.Text = "Full Name";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(41, 167);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(55, 13);
            this.label4.TabIndex = 26;
            this.label4.Text = "Username";
            // 
            // RegisterButton
            // 
            this.RegisterButton.Location = new System.Drawing.Point(286, 308);
            this.RegisterButton.Name = "RegisterButton";
            this.RegisterButton.Size = new System.Drawing.Size(75, 23);
            this.RegisterButton.TabIndex = 25;
            this.RegisterButton.Text = "Register";
            this.RegisterButton.UseVisualStyleBackColor = true;
            this.RegisterButton.Click += new System.EventHandler(this.register);
            // 
            // RegisterCPassword
            // 
            this.RegisterCPassword.Location = new System.Drawing.Point(135, 121);
            this.RegisterCPassword.Name = "RegisterCPassword";
            this.RegisterCPassword.PasswordChar = '*';
            this.RegisterCPassword.Size = new System.Drawing.Size(100, 20);
            this.RegisterCPassword.TabIndex = 24;
            // 
            // RegisterPassword
            // 
            this.RegisterPassword.Location = new System.Drawing.Point(135, 78);
            this.RegisterPassword.Name = "RegisterPassword";
            this.RegisterPassword.PasswordChar = '*';
            this.RegisterPassword.Size = new System.Drawing.Size(100, 20);
            this.RegisterPassword.TabIndex = 23;
            // 
            // RegisterEmail
            // 
            this.RegisterEmail.Location = new System.Drawing.Point(135, 32);
            this.RegisterEmail.MaxLength = 50;
            this.RegisterEmail.Name = "RegisterEmail";
            this.RegisterEmail.Size = new System.Drawing.Size(179, 20);
            this.RegisterEmail.TabIndex = 22;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(38, 128);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(91, 13);
            this.label3.TabIndex = 21;
            this.label3.Text = "Confirm Password";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(38, 85);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(53, 13);
            this.label2.TabIndex = 20;
            this.label2.Text = "Password";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(38, 39);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(32, 13);
            this.label1.TabIndex = 19;
            this.label1.Text = "Email";
            // 
            // Register
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(651, 353);
            this.Controls.Add(this.RegisterBDay);
            this.Controls.Add(this.RegisterBMonth);
            this.Controls.Add(this.RegisterBYear);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.RegisterSFemale);
            this.Controls.Add(this.RegisterSMale);
            this.Controls.Add(this.RegisterFullName);
            this.Controls.Add(this.RegisterUsername);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.RegisterButton);
            this.Controls.Add(this.RegisterCPassword);
            this.Controls.Add(this.RegisterPassword);
            this.Controls.Add(this.RegisterEmail);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Name = "Register";
            this.Text = "Form1";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox RegisterBDay;
        private System.Windows.Forms.TextBox RegisterBMonth;
        private System.Windows.Forms.TextBox RegisterBYear;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.RadioButton RegisterSFemale;
        private System.Windows.Forms.RadioButton RegisterSMale;
        private System.Windows.Forms.TextBox RegisterFullName;
        private System.Windows.Forms.TextBox RegisterUsername;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Button RegisterButton;
        private System.Windows.Forms.TextBox RegisterCPassword;
        private System.Windows.Forms.TextBox RegisterPassword;
        private System.Windows.Forms.TextBox RegisterEmail;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
    }
}

