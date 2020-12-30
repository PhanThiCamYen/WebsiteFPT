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

        public ActionResult QL_HangSanPham(string mahang)
        {
            List<SanPham> list_sp = fpt.SanPhams.ToList();
            List<SanPham> list_sp1 = list_sp.Where(sp => sp.MaHang == mahang).ToList();
            return View(list_sp1);
        }

        public ActionResult Lay_TenHangSP(string masp)
        {
            List<Hang> lst_hsp = fpt.Hangs.Where(hang => hang.MaNhomSP == masp).ToList();
            return PartialView(lst_hsp);
        }

        /*Lấy Giá Sản phẩm điện thoại*/
        public ActionResult MucGiaDT(int gia1, int gia2)
        {
            var gia_dt = fpt.SanPhams.Where(sp => sp.GiaBan >= gia1 && sp.GiaBan < gia2 && sp.MaNhomSP == "DT").ToList();
            return View(gia_dt);
        }
        /*Lấy Gía Sản phẩm laptop*/
        public ActionResult MucGiaLT(int gia1, int gia2)
        {
            var gia_lt = fpt.SanPhams.Where(sp => sp.GiaBan >= gia1 && sp.GiaBan < gia2 && sp.MaNhomSP == "LT").ToList();
            return View(gia_lt);
        }
        /*Lấy Gía Sản phẩm đồng hồ*/
        public ActionResult MucGiaDH(int gia1, int gia2)
        {
            var gia_dh = fpt.SanPhams.Where(sp => sp.GiaBan >= gia1 && sp.GiaBan < gia2 && sp.MaNhomSP == "DH").ToList();
            return View(gia_dh);
        }
        /*Lấy Sản phẩm Tablet*/
        private List<SanPham> laySanPhamTabLet()
        {
            return fpt.SanPhams.Where(a => a.MaNhomSP == "TL").ToList();
        }
        public ActionResult MucGiaTL(int gia1, int gia2)
        {
            var gia_tl = fpt.SanPhams.Where(sp => sp.GiaBan >= gia1 && sp.GiaBan < gia2 && sp.MaNhomSP == "TL").ToList();
            return View(gia_tl);
        }
        /*Lấy Sản phẩm Phụ Kiện*/
        //private List<SanPham> laySanPhamPhuKien()
        //{
        //    return fpt.SanPhams.Where(a => a.MaNhomSP == "PK").ToList();
        //}
        public ActionResult MucGiaPK(int gia1, int gia2)
        {
            var gia_pk = fpt.SanPhams.Where(sp => sp.GiaBan >= gia1 && sp.GiaBan < gia2 && sp.MaNhomSP == "PK").ToList();
            return View(gia_pk);
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