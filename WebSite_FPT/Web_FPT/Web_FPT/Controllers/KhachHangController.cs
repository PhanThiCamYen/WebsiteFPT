using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_FPT.Models;


namespace Web_FPT.Controllers
{
    public class KhachHangController : Controller
    {
        FPTDBContextDataContext fpt = new FPTDBContextDataContext();
        // GET: KhachHang
        public ActionResult KhachHang()
        {
            var kh = fpt.KhachHangs.ToList();
            return View(kh);
        }
        public ActionResult Sua_KH(string makh)
        {
            if (makh != null)
            {
                var sua_kh = fpt.KhachHangs.First(kh => kh.MaKH == makh);
                return View(sua_kh);
            }
            return RedirectToAction("KhachHang", "KhachHang");
        }
        [HttpPost]
        public ActionResult Sua_KH(string makh, FormCollection collection)
        {
            var s_makh = fpt.KhachHangs.First(kh => kh.MaKH == makh);
            var s_tenkh = collection["tenKH"];
            var s_gioitinhkh = collection["gioitinhKH"];
            var s_ngaysinhkh = collection["ngaysinhKH"];
            var s_emailkh = collection["emailKH"];
            var s_sodienthoaikh = collection["sdtKH"];
            var s_diachikh = collection["diaChiKH"];
           
            s_makh.MaKH = makh;
            String gioiTinh = "";
            if (string.IsNullOrEmpty(s_tenkh))
            {
                ViewData["Loi1"] = "Tên Khách Hàng Không Được Để Trống";
            }
            else if (string.IsNullOrEmpty(s_diachikh))
            {
                ViewData["Loi2"] = "Địa Chỉ Khách Hàng Không Được Để Trống";
            }
            else if(s_makh != null)
            {
                s_makh.TenKH = s_tenkh;
                if (s_gioitinhkh == "True")
                {
                    gioiTinh = "Nam";
                }
                else
                {
                    gioiTinh = "Nữ";
                }
                s_makh.GioiTinhKH = (gioiTinh == "Nam" ? true : false);
                DateTime ngaySinhKH = DateTime.Parse(s_ngaysinhkh);
                s_makh.EmailKH = s_emailkh;
                if (ngaySinhKH!= null)
                {
                    s_makh.NgaySinhKH = ngaySinhKH;
                }
                s_makh.SDTKH = int.Parse
                    (s_sodienthoaikh);
                s_makh.DiaChiKH = s_diachikh;
            
                UpdateModel(makh);
                fpt.SubmitChanges();
                return RedirectToAction("KhachHang", "KhachHang");
            }
            return this.Sua_KH(makh);
        }
        //Xóa khách hàng
        [HttpGet]
        public ActionResult DeleteKH(string makh)
        {
            var xoa_kh = fpt.KhachHangs.First(kh => kh.MaKH == makh);
            return View(xoa_kh);
        }

        [HttpPost]
        public ActionResult DeleteKH(string makh, FormCollection collection)
        {
            var xoa_kh = fpt.KhachHangs.Where(kh => kh.MaKH == makh).First();
            fpt.KhachHangs.DeleteOnSubmit(xoa_kh);
            fpt.SubmitChanges();
            return RedirectToAction("KhachHang", "KhachHang");
        }
    }
}