using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace App
{
    class Game
    {
        private int IDGame;
        private string Name;
        private string Description;
        private string ReleaseDate;
        private int AgeRestriction;
        private string CoverImg;
        private double Price;
        private int IDCompany;
        private int IDFranchise;


        public Game() { 
        }
        


        public string GetName()
        {
            return Name;
        }
        public void SetName(string name)
        {
            this.Name = name;
        }


        public override string ToString()
        {
            return this.Name;
        }



    }

}
