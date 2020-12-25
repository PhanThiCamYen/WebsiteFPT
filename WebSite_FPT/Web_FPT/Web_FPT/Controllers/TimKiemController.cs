using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_FPT.Models;
using System.Data.Linq.SqlClient;
using System.Text.RegularExpressions;

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

        public ActionResult GetDataSearch(string value)
        {
            var sp = GetTopDataProduct(value);
            var list = new List<SanPham>();
            foreach (var item in sp)
            {
                list.Add(new SanPham
                {
                    TenSP = item.TenSP,
                    MaSP = item.MaSP
                });
            }
            return Json(list, JsonRequestBehavior.AllowGet);
        }

        private List<SanPham> laySanPhamTimKiem(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return fpt.SanPhams.Where(a => a.TenSP.ToLower().Contains("@(*&@*($&@*&$*(@$&(*@$&(@&$(*!&$*(&$")).ToList();
            }
            return fpt.SanPhams.Where(a => a.TenSP.Contains(id)).ToList();
        }

        private List<SanPham> GetTopDataProduct(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return fpt.SanPhams.Where(a => a.TenSP.ToLower().Contains("@(*&@*($&@*&$*(@$&(*@$&(@&$(*!&$*(&$") && a.TenSP.ToLower().Contains(convertToUnSign3(id))).ToList<SanPham>();
            }
            
            return fpt.SanPhams.Where(a => a.TenSP.Contains(id)).Take(10).ToList<SanPham>();
        }
        public static string convertToUnSign3(string s)
        {
            Regex regex = new Regex("\\p{IsCombiningDiacriticalMarks}+");
            string temp = s.Normalize(System.Text.NormalizationForm.FormD);
            return regex.Replace(temp, String.Empty).Replace('\u0111', 'd').Replace('\u0110', 'D');
        }


    }
}