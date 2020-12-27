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
            return View(lspkm);
        }

        private List<SanPham> laySPKM()
        {
            return fpt.SanPhams.ToList();
        }

    }
}