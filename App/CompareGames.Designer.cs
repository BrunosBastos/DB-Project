namespace App
{
    partial class CompareGames
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
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.label1 = new System.Windows.Forms.Label();
            this.listBox1 = new System.Windows.Forms.ListBox();
            this.GamesInCommon = new System.Windows.Forms.TextBox();
            this.button1 = new System.Windows.Forms.Button();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.YouGenre = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.YouCompany = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.YouPlatform = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.YouFranchise = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.YouGames = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.UserGenre = new System.Windows.Forms.TextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.UserCompany = new System.Windows.Forms.TextBox();
            this.label8 = new System.Windows.Forms.Label();
            this.UserPlatform = new System.Windows.Forms.TextBox();
            this.label9 = new System.Windows.Forms.Label();
            this.UserFranchise = new System.Windows.Forms.TextBox();
            this.label10 = new System.Windows.Forms.Label();
            this.UserGames = new System.Windows.Forms.TextBox();
            this.label11 = new System.Windows.Forms.Label();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.groupBox3.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Controls.Add(this.listBox1);
            this.groupBox1.Controls.Add(this.GamesInCommon);
            this.groupBox1.Location = new System.Drawing.Point(12, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(403, 395);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Games in Common";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(273, 39);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(122, 13);
            this.label1.TabIndex = 4;
            this.label1.Text = "Nº of Games in Common";
            // 
            // listBox1
            // 
            this.listBox1.FormattingEnabled = true;
            this.listBox1.Location = new System.Drawing.Point(7, 20);
            this.listBox1.Name = "listBox1";
            this.listBox1.Size = new System.Drawing.Size(260, 368);
            this.listBox1.TabIndex = 0;
            // 
            // GamesInCommon
            // 
            this.GamesInCommon.Location = new System.Drawing.Point(273, 58);
            this.GamesInCommon.Name = "GamesInCommon";
            this.GamesInCommon.ReadOnly = true;
            this.GamesInCommon.Size = new System.Drawing.Size(122, 20);
            this.GamesInCommon.TabIndex = 3;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(390, 415);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(75, 23);
            this.button1.TabIndex = 2;
            this.button1.Text = "Close";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.close);
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.YouGenre);
            this.groupBox2.Controls.Add(this.label6);
            this.groupBox2.Controls.Add(this.YouCompany);
            this.groupBox2.Controls.Add(this.label5);
            this.groupBox2.Controls.Add(this.YouPlatform);
            this.groupBox2.Controls.Add(this.label4);
            this.groupBox2.Controls.Add(this.YouFranchise);
            this.groupBox2.Controls.Add(this.label3);
            this.groupBox2.Controls.Add(this.YouGames);
            this.groupBox2.Controls.Add(this.label2);
            this.groupBox2.Location = new System.Drawing.Point(443, 12);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(247, 395);
            this.groupBox2.TabIndex = 3;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Your Stats";
            // 
            // YouGenre
            // 
            this.YouGenre.Location = new System.Drawing.Point(25, 296);
            this.YouGenre.Name = "YouGenre";
            this.YouGenre.ReadOnly = true;
            this.YouGenre.Size = new System.Drawing.Size(194, 20);
            this.YouGenre.TabIndex = 9;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(25, 279);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(83, 13);
            this.label6.TabIndex = 8;
            this.label6.Text = "Favourite Genre";
            // 
            // YouCompany
            // 
            this.YouCompany.Location = new System.Drawing.Point(25, 242);
            this.YouCompany.Name = "YouCompany";
            this.YouCompany.ReadOnly = true;
            this.YouCompany.Size = new System.Drawing.Size(194, 20);
            this.YouCompany.TabIndex = 7;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(25, 226);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(98, 13);
            this.label5.TabIndex = 6;
            this.label5.Text = "Favourite Company";
            // 
            // YouPlatform
            // 
            this.YouPlatform.Location = new System.Drawing.Point(25, 190);
            this.YouPlatform.Name = "YouPlatform";
            this.YouPlatform.ReadOnly = true;
            this.YouPlatform.Size = new System.Drawing.Size(194, 20);
            this.YouPlatform.TabIndex = 5;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(25, 173);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(92, 13);
            this.label4.TabIndex = 4;
            this.label4.Text = "Favourite Platform";
            // 
            // YouFranchise
            // 
            this.YouFranchise.Location = new System.Drawing.Point(25, 125);
            this.YouFranchise.Name = "YouFranchise";
            this.YouFranchise.ReadOnly = true;
            this.YouFranchise.Size = new System.Drawing.Size(194, 20);
            this.YouFranchise.TabIndex = 3;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(25, 108);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(100, 13);
            this.label3.TabIndex = 2;
            this.label3.Text = "Favourite Franchise";
            // 
            // YouGames
            // 
            this.YouGames.Location = new System.Drawing.Point(25, 58);
            this.YouGames.Name = "YouGames";
            this.YouGames.ReadOnly = true;
            this.YouGames.Size = new System.Drawing.Size(100, 20);
            this.YouGames.TabIndex = 1;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(22, 38);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(94, 13);
            this.label2.TabIndex = 0;
            this.label2.Text = "Number Of Games";
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.UserGenre);
            this.groupBox3.Controls.Add(this.label7);
            this.groupBox3.Controls.Add(this.UserCompany);
            this.groupBox3.Controls.Add(this.label8);
            this.groupBox3.Controls.Add(this.UserPlatform);
            this.groupBox3.Controls.Add(this.label9);
            this.groupBox3.Controls.Add(this.UserFranchise);
            this.groupBox3.Controls.Add(this.label10);
            this.groupBox3.Controls.Add(this.UserGames);
            this.groupBox3.Controls.Add(this.label11);
            this.groupBox3.Location = new System.Drawing.Point(713, 12);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(271, 395);
            this.groupBox3.TabIndex = 4;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "User\'s Stats";
            // 
            // UserGenre
            // 
            this.UserGenre.Location = new System.Drawing.Point(34, 296);
            this.UserGenre.Name = "UserGenre";
            this.UserGenre.ReadOnly = true;
            this.UserGenre.Size = new System.Drawing.Size(210, 20);
            this.UserGenre.TabIndex = 19;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(34, 279);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(83, 13);
            this.label7.TabIndex = 18;
            this.label7.Text = "Favourite Genre";
            // 
            // UserCompany
            // 
            this.UserCompany.Location = new System.Drawing.Point(34, 242);
            this.UserCompany.Name = "UserCompany";
            this.UserCompany.ReadOnly = true;
            this.UserCompany.Size = new System.Drawing.Size(210, 20);
            this.UserCompany.TabIndex = 17;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(34, 226);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(98, 13);
            this.label8.TabIndex = 16;
            this.label8.Text = "Favourite Company";
            // 
            // UserPlatform
            // 
            this.UserPlatform.Location = new System.Drawing.Point(34, 190);
            this.UserPlatform.Name = "UserPlatform";
            this.UserPlatform.ReadOnly = true;
            this.UserPlatform.Size = new System.Drawing.Size(210, 20);
            this.UserPlatform.TabIndex = 15;
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(34, 173);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(92, 13);
            this.label9.TabIndex = 14;
            this.label9.Text = "Favourite Platform";
            // 
            // UserFranchise
            // 
            this.UserFranchise.Location = new System.Drawing.Point(34, 125);
            this.UserFranchise.Name = "UserFranchise";
            this.UserFranchise.ReadOnly = true;
            this.UserFranchise.Size = new System.Drawing.Size(210, 20);
            this.UserFranchise.TabIndex = 13;
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Location = new System.Drawing.Point(34, 108);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(100, 13);
            this.label10.TabIndex = 12;
            this.label10.Text = "Favourite Franchise";
            // 
            // UserGames
            // 
            this.UserGames.Location = new System.Drawing.Point(34, 58);
            this.UserGames.Name = "UserGames";
            this.UserGames.ReadOnly = true;
            this.UserGames.Size = new System.Drawing.Size(100, 20);
            this.UserGames.TabIndex = 11;
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Location = new System.Drawing.Point(31, 38);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(94, 13);
            this.label11.TabIndex = 10;
            this.label11.Text = "Number Of Games";
            // 
            // CompareGames
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1009, 450);
            this.Controls.Add(this.groupBox3);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.groupBox1);
            this.Name = "CompareGames";
            this.Text = "CompareGames";
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.ListBox listBox1;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox GamesInCommon;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.TextBox YouGenre;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox YouCompany;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox YouPlatform;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox YouFranchise;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox YouGames;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.TextBox UserGenre;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox UserCompany;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.TextBox UserPlatform;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.TextBox UserFranchise;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.TextBox UserGames;
        private System.Windows.Forms.Label label11;
    }
}