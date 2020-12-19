using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_FPT.Models;

namespace Web_FPT.Controllers
{
    public class AdminController : Controller
    {
        FPTDBContextDataContext fpt = new FPTDBContextDataContext();
        // GET: Admin
        public ActionResult DangNhap()
        {
            return View();
        }

        [HttpPost]
        public ActionResult DangNhap(FormCollection collection)
        {
            var email = collection["userName"];
            var matKhau = collection["password"];
            NhanVien nhanVien = fpt.NhanViens.FirstOrDefault(nv => nv.EmailNV == email && nv.MatKhauNV == matKhau);
            if (string.IsNullOrEmpty(email))
            {
                ViewData["Loi1"] = "Tên đăng nhập không được để trống!";
            }
            else if (string.IsNullOrEmpty(matKhau))
            {
                ViewData["Loi2"] = "Mật khẩu không được để trống!";
            }
            else if (nhanVien != null && nhanVien.MaPQ == "QL")
            {

                Session["ten"] = nhanVien.TenNV;
                Session["AdminIsLogin"] = true;
                ViewBag.Thongbao = "Chúc mừng đăng nhập thành công";
                return RedirectToAction("Admin", "Admin");
            }
            else
            {
                ViewData["Loi"] = "Tên đăng nhập hoặc mật khẩu không chính xác!";
            }
            return View();
        }

        public ActionResult Admin()
        {
            if (Session["AdminIsLogin"] != null)
            {
                var sp = fpt.SanPhams.ToList();
                return View(sp);
            }
            else
            {
                return RedirectToAction("DangNhap", "Admin");
            }
        }
    }
}