using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_FPT.Controllers;
using Web_FPT.Models;

namespace Web_FPT.Controllers
{
    public class HomeController : Controller
    {
        FPTDBContextDataContext fpt = new FPTDBContextDataContext();

        private List<SanPham>LaySanPhamHot()
        {
            return fpt.SanPhams.Where(a => a.SoLuong >= 5 ).ToList();

        }
        public PartialViewResult
            SanPhamHot()
        {
            var sanpham = LaySanPhamHot();
            return PartialView(sanpham);
        }
        public ActionResult Index()
        {
            var sanpham = LaySanPhamHot();
            return View(sanpham);
        }
        public ActionResult GioiThieu()
        {
            return View();
        }
        
    }
}
