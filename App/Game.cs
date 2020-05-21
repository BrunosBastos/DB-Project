using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace App
{
    class Game
    {
        private string _IDGame;
        private string _Name;
        private string _Description;
        private string _ReleaseDate;
        private string _AgeRestriction;
        private string _CoverImg;
        private string _Price;
        private string _IDCompany;
        private string _IDFranchise;

        public Game()
        {

        }



        public override string ToString()
        {
            return this._Name;
        }

        public string IDGame
        {
            get { return _IDGame; }
            set { _IDGame = value; }
        }
        public string Name
        {
            get { return _Name ; }
            set { _Name = value; }
        }
        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }

        public string ReleaseDate
        {
            get { return _ReleaseDate; }
            set { _ReleaseDate = value; }
        }
        public string AgeRestriction
        {
            get { return _AgeRestriction; }
            set { _AgeRestriction = value; }
        }

        public string CoverImg
        {
            get { return _CoverImg; }
            set { _CoverImg = value; }
        }
        public string Price
        {
            get { return _Price; }
            set { _Price = value; }
        }
        public string IDCompany
        {
            get { return _IDCompany; }
            set { _IDCompany = value; }
        }

        public string IDFranchise
        {
            get { return _IDFranchise; }
            set { _IDFranchise = value; }
        }

    }

}
