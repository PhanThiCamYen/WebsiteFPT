using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_FPT.Models;

namespace Web_FPT.Controllers
{
    public class SanPhamController : Controller
    {
        FPTDBContextDataContext fpt = new FPTDBContextDataContext();
        // GET: SanPham
        public ActionResult AllSanPham()
        {
            var all_sp = from sp in fpt.SanPhams select sp;
            return View(all_sp);
        }
        /*Lấy Sản phẩm điện thoại*/
        private List<SanPham> laySanPhamDienThoai()
        {
            return fpt.SanPhams.Where(a => a.MaNhomSP =="DT").ToList();
        }
        public ActionResult SanPhamDienThoai()
        {
            var dt = laySanPhamDienThoai();
            return View(dt);
        }
        /*Lấy Sản phẩm laptop*/
        private List<SanPham> laySanPhamLapTop()
        {
            return fpt.SanPhams.Where(a => a.MaNhomSP == "LT").ToList();
        }
        public ActionResult SanPhamLapTop()
        {
            var lt = laySanPhamLapTop();
            return View(lt);
        }
        /*Lấy Sản phẩm đồng hồ*/
        private List<SanPham> laySanPhamDongHo()
        {
            return fpt.SanPhams.Where(a => a.MaNhomSP == "DH").ToList();
        }
        public ActionResult SanPhamDongHo()
        {
            var dh = laySanPhamDongHo();
            return View(dh);
        }
        /*Lấy Sản phẩm Tablet*/
        private List<SanPham> laySanPhamTabLet()
        {
            return fpt.SanPhams.Where(a => a.MaNhomSP == "TL").ToList();
        }
        public ActionResult SanPhamTabLet()
        {
            var tl = laySanPhamTabLet();
            return View(tl);
        }
        /*Lấy Sản phẩm Phụ Kiện*/
        private List<SanPham> laySanPhamPhuKien()
        {
            return fpt.SanPhams.Where(a => a.MaNhomSP == "PK").ToList();
        }
        public ActionResult SanPhamPhuKien()
        {
            var pk = laySanPhamPhuKien();
            return View(pk);
        }
        /*Lấy Sản phẩm sim the*/
        private List<SanPham> laySanPhamSimThe()
        {
            return fpt.SanPhams.Where(a => a.MaNhomSP == "S").ToList();
        }
        public ActionResult SanPhamSimThe()
        {
            var s = laySanPhamSimThe();
            return View(s);
        }
        public ActionResult Details(string id)
        {
            if( id!= null)
            {
                var ctsp = fpt.SanPhams.First(a => a.MaSP == id);
                return View(ctsp);
            }
            return RedirectToAction("Index", "Home");
        }
    }
}