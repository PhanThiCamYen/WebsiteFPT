using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Web_FPT.Models;

namespace Web_FPT.Models
{
    public class PhanQuyen
    {
        FPTDBContextDataContext db = new FPTDBContextDataContext();

        public string MaPQ { get; set; }

        public string TenChucVu { get; set; }

        public PhanQuyen()
        {

        }
    }
}