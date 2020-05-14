namespace App
{
    partial class Login
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
            this.linkLabel1 = new System.Windows.Forms.LinkLabel();
            this.LoginButton = new System.Windows.Forms.Button();
            this.LoginPasswordBox = new System.Windows.Forms.TextBox();
            this.LoginEmailBox = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // linkLabel1
            // 
            this.linkLabel1.AutoSize = true;
            this.linkLabel1.Location = new System.Drawing.Point(96, 137);
            this.linkLabel1.Name = "linkLabel1";
            this.linkLabel1.Size = new System.Drawing.Size(197, 13);
            this.linkLabel1.TabIndex = 11;
            this.linkLabel1.TabStop = true;
            this.linkLabel1.Text = "Don\'t have an account? Register here...";
            this.linkLabel1.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.goToRegister);
            // 
            // LoginButton
            // 
            this.LoginButton.Location = new System.Drawing.Point(99, 162);
            this.LoginButton.Name = "LoginButton";
            this.LoginButton.Size = new System.Drawing.Size(75, 23);
            this.LoginButton.TabIndex = 10;
            this.LoginButton.Text = "Login";
            this.LoginButton.UseVisualStyleBackColor = true;
            this.LoginButton.Click += new System.EventHandler(this.login);
            // 
            // LoginPasswordBox
            // 
            this.LoginPasswordBox.Location = new System.Drawing.Point(164, 87);
            this.LoginPasswordBox.Name = "LoginPasswordBox";
            this.LoginPasswordBox.PasswordChar = '*';
            this.LoginPasswordBox.Size = new System.Drawing.Size(100, 20);
            this.LoginPasswordBox.TabIndex = 9;
            // 
            // LoginEmailBox
            // 
            this.LoginEmailBox.Location = new System.Drawing.Point(164, 33);
            this.LoginEmailBox.Name = "LoginEmailBox";
            this.LoginEmailBox.Size = new System.Drawing.Size(100, 20);
            this.LoginEmailBox.TabIndex = 8;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(96, 94);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(53, 13);
            this.label2.TabIndex = 7;
            this.label2.Text = "Password";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(96, 40);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(32, 13);
            this.label1.TabIndex = 6;
            this.label1.Text = "Email";
            // 
            // Login
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(368, 225);
            this.Controls.Add(this.linkLabel1);
            this.Controls.Add(this.LoginButton);
            this.Controls.Add(this.LoginPasswordBox);
            this.Controls.Add(this.LoginEmailBox);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Name = "Login";
            this.Text = "Login";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.LinkLabel linkLabel1;
        private System.Windows.Forms.Button LoginButton;
        private System.Windows.Forms.TextBox LoginPasswordBox;
        private System.Windows.Forms.TextBox LoginEmailBox;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
    }
}