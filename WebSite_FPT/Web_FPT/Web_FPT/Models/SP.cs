using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web_FPT.Models
{
    public class SP
    {
        public string masp { get; set; }
        public string tensp { get; set; }
        public int soluong { get; set; }
        public int giaban { get; set; }
        public string hinhanh { get; set; }
        public string mota { get; set; }
        public string thoigianbh { get; set; }
        public double laisuat { get; set; }

        public SP(string masp, string tensp, int soluong, int giaban, string hinhanh, string thoigianbh, double laisuat)
        {
            this.masp = masp;
            this.tensp = tensp;
            this.soluong = soluong;
            this.giaban = giaban;
            this.hinhanh = hinhanh;
            this.thoigianbh = thoigianbh;
            this.laisuat = laisuat;
        }

        public SP()
        {

        }
    }
}