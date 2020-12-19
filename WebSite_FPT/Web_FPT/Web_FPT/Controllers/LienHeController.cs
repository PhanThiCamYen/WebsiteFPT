//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Web;
//using System.Web.Mvc;
//using Web_FPT.Models;

//namespace Web_FPT.Controllers
//{
//    public class LienHeController : Controller
//    {
//        FPTDBContextDataContext fpt = new FPTDBContextDataContext();
//       // GET: LienHe
//        public ActionResult Index()
//        {
//            return View();
//        }
//        [HttpPost]
//        public ActionResult LienHe(FormCollection collection, LIENHE lh)
//        {
//            var hotenkh = collection["HOTENKH"];
//            var email = collection["EMAIL"];
//            var noidung = collection["NOIDUNG"];
//            if (String.IsNullOrEmpty(hotenkh))
//            {
//                ViewData["Loi1"] = "Vui lòng nhập rõ họ tên.";
//            }
//            else if (String.IsNullOrEmpty(email))
//            {
//                ViewData["Loi2"] = "Vui lòng nhập Email.";
//            }
//            else if (String.IsNullOrEmpty(noidung))
//            {
//                ViewData["Loi3"] = "Vui lòng nhập nội dung liên hệ.";
//            }
//            else
//            {
//                lh.HOTENKH = hotenkh;
//                lh.EMAIL = email;
//                lh.NOIDUNG = noidung;
//                fpt.LIENHEs.InsertOnSubmit(lh);
//                fpt.SubmitChanges();

//            }

//            return this.LienHe();
//        }
//        private List<LIENHE> laytt(int id)
//        {
//            return fpt.LIENHEs.Where(a => a.MALH == id).ToList();
//        }
//        public ActionResult ttlienhe(int id)
//        {
//            var details_lienhe = fpt.LIENHEs.Where(a => a.MALH == id).FirstOrDefault();
//            return View(details_lienhe);
//        }
//    }
//}