using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace App
{
    public class Review
    {


        private string _username;
        private string _title;
        private string _rating;
        private string _text;
        private string _game;
        private string _dateReview;


        public Review()
        {

        }


        public string username
        {
            get { return _username; }
            set { _username = value; }
        }
        public string title
        {
            get { return _title; }
            set { _title = value; }
        }
        public string rating
        {
            get { return _rating; }
            set { _rating = value; }
        }
        public string text
        {
            get { return _text; }
            set { _text = value; }
        }

        public string game
        {
            get { return _game; }
            set { _game = value; }
        }

        public string dateReview
        {
            get { return _dateReview; }
            set { _dateReview = value; }
        }

        override public string ToString()
        {
            return "Rating"+_rating + "\t" +_title ;
        }





    }
}
