using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_FPT.Models;

namespace Web_FPT.Controllers
{
    public class TraGopController : Controller
    {
        FPTDBContextDataContext fpt = new FPTDBContextDataContext();
        // GET: TraGop
        public ActionResult TraGop()
        {
            var tgdt = laySPTraGop();
            return View(tgdt);
        }
        private List<SanPham> laySPTraGop()
        {
            return fpt.SanPhams.ToList(); 
        }
    }
}