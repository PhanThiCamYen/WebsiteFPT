//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Web;
//using System.Web.Mvc;
//using Web_FPT.Models;

//namespace Web_FPT.Controllers
//{
//    public class KhuyenMaiController : Controller
//    {
//        FPTDBContextDataContext fpt = new FPTDBContextDataContext();
        
//        // GET: KhuyenMai
//        public ActionResult KhuyenMai()
//        {
//            return View();
//        }
//        public ActionResult KhuyenMai(string id)
//        {
//            return View();
//        }
//        private int TongtienKM()
//        {
//            float TTKM = 0;
//            if (fpt.SanPhams.Where(a => a. >= 5) != null)
//            {
//                iTongSoLuong = lstGioHang.Sum(n => n.soluongSP);
//            }
//            return iTongSoLuong;
//        }

//    }
//}