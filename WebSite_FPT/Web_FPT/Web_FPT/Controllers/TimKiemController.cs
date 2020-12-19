using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_FPT.Models;
using System.Data.Linq.SqlClient;

namespace Web_FPT.Controllers
{
    public class TimKiemController : Controller
    {
        // GET: TimKiem
        FPTDBContextDataContext fpt = new FPTDBContextDataContext();
        public ActionResult TimKiem()
        {
            return View();
        }
        [HttpGet]
        public ActionResult TimKiem(string id)
        {

            var sp = laySanPhamTimKiem(id);

            return View(sp);



            //var SanPhams = from sp in db.SANPHAMs where sp.TENSP.Contains(@"/" + id + "/") select sp;

        }

        private List<SanPham> laySanPhamTimKiem(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return fpt.SanPhams.Where(a => a.TenSP.ToLower().Contains("@(*&@*($&@*&$*(@$&(*@$&(@&$(*!&$*(&$")).ToList();
            }
            return fpt.SanPhams.Where(a => a.TenSP.Contains(id)).ToList();
        }

    }
}