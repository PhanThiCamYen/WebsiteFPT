using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_FPT.Models;

namespace Web_FPT.Controllers
{
    public class KhuyenMaiController : Controller
    {
        FPTDBContextDataContext fpt = new FPTDBContextDataContext();

        // GET: KhuyenMai
        public ActionResult KhuyenMai()
        {
            var lspkm = laySPKM();
            //var lay_giamgia = from sp in fpt.SanPhams join km in fpt.KhuyenMais on sp.MaSP equals km.MaSP select sp.GiaBan * km.MucGiamGia;            
            //Session["giamGia"] =lay_giamgia;
            return View(lspkm);
        }

        private List<SanPham> laySPKM()
        {
            return fpt.SanPhams.ToList();
        }



    }
}