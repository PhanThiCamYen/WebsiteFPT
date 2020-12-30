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
    public class AdminController : Controller
    {
        FPTDBContextDataContext fpt = new FPTDBContextDataContext();

        // GET: Admin
        //Đăng nhập
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
            //&& nhanVien.MaPQ == "QL"
            else if (nhanVien != null )
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
        public ActionResult DangXuat()
        {
            Session["AdminIsLogin"] = null;
            return RedirectToAction("DangNhap", "Admin");
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

        public ActionResult Them()
        {
            var l_sp = from lsp in fpt.SanPhams select lsp;
            ViewData["LoaiSanPham"] = new SelectList(fpt.SanPhams, "MaSP", "TenSP");
            ViewData["SoLuongSanPham"] = fpt.SanPhams.Count();
            int flag = fpt.SanPhams.Count();
            return View();
        }

        [HttpPost]
        public ActionResult Them(FormCollection collection, SanPham sp)
        {
            var maSP = collection["MaSP"];
            var tenSP = collection["TenSP"];
            var soLuong = int.Parse(collection["SoLuong"]);
            var giaBan = int.Parse(collection["GiaBan"]);
            var hinhAnh = collection["HinhAnh"];
            //var moTa = collection["MoTa"];
            //var thoiGianBH = collection["ThoiGianBH"];
            var maNhomSP = collection["MaNhomSP"];
            var maHang = Request.Form["MaHang"];
            if (string.IsNullOrEmpty(maSP))
            {
                ViewData["Loi"] = "Tên sản phẩm không được để trống!";
            }
            else if (string.IsNullOrEmpty(tenSP))
            {
                ViewData["Loi1"] = "Mã sản phẩm không được nhỏ hơn 0 !";
            }
            else if (soLuong <= 0)
            {
                ViewData["Loi2"] = "Mã sản phẩm không được nhỏ hơn 0 !";
            }
            else if (giaBan <= 0)
            {
                ViewData["Loi3"] = "Mã sản phẩm không được nhỏ hơn 0 !";
            }
            else if (string.IsNullOrEmpty(hinhAnh))
            {
                ViewData["Loi4"] = "Mã sản phẩm không được nhỏ hơn 0 !";
            }
            //else if (string.IsNullOrEmpty(moTa))
            //{
            //    ViewData["Loi5"] = "Mã sản phẩm không được nhỏ hơn 0 !";
            //}
            //else if (string.IsNullOrEmpty(thoiGianBH))
            //{
            //    ViewData["Loi5"] = "Mã sản phẩm không được nhỏ hơn 0 !";
            //}
            else if (string.IsNullOrEmpty(maNhomSP))
            {
                ViewData["Loi6"] = "Mã sản phẩm không được nhỏ hơn 0 !";
            }
            else if (string.IsNullOrEmpty(maHang))
            {
                ViewData["Loi7"] = "Mã sản phẩm không được nhỏ hơn 0 !";
            }
            else
            {
                SanPham sanPham = fpt.SanPhams.FirstOrDefault(_sp => sp.MaSP == maSP);
                if (sanPham != null)
                {
                    ViewData["Loi8"] = "Mã sản phẩm không được nhỏ hơn 0!";
                }
                else
                {
                    sp.MaSP = maSP;
                    sp.TenSP = tenSP;
                    sp.SoLuong = soLuong;
                    sp.GiaBan = giaBan;
                    sp.HinhAnh = hinhAnh;
                    sp.MaNhomSP = maNhomSP;
                    sp.MaHang = maHang;
                    fpt.SubmitChanges();
                    return RedirectToAction("QuanLy", "Admin");
                }
                ViewData["Loi8"] = "Mã sản phẩm không được trùng!";
                return RedirectToAction("DanhSachSanPham", "Admin");
            }
            return this.Them();
        }

        //Xóa sản phẩm
        [HttpGet]
        public ActionResult Delete(string masp)
        {
            var xoa_sp = fpt.SanPhams.First(sp => sp.MaSP == masp);
            return View(xoa_sp);
        }

        [HttpPost]
        public ActionResult Delete(string masp, FormCollection collection)
        {
            var xoa_sp = fpt.SanPhams.Where(sp => sp.MaSP == masp).First();
            fpt.SanPhams.DeleteOnSubmit(xoa_sp);
            fpt.SubmitChanges();
            return RedirectToAction("Admin", "Admin");
        }

        public ActionResult Sua(string masp)
        {
            var sua_sp = fpt.SanPhams.First(sp => sp.MaSP == masp);
            var l_sp = from lsp in fpt.NhomSanPhams select lsp;
            ViewData["NhomSanPham"] = new SelectList(fpt.SanPhams, "MaSP", "MaSP");
            return View(sua_sp);
        }
        [HttpPost]
        public ActionResult Sua(string masp, FormCollection collection)
        {
            var s_masp = fpt.SanPhams.First(sp => sp.MaSP == masp);
            var s_tensanpham = collection["tensanpham"];
            //var e_maloai = int.Parse(collection["LoaiSanPham"]);
            //var e_masp = int.Parse(collection["masanpham"]);
            var s_soluong = int.Parse(collection["soluong"]);
            var s_giaban = int.Parse(collection["giaban"]);
            var s_hinhanh = collection["hinhanh"];
            var s_mota = collection["mota"];
            var s_thoigian = collection["thoigian"];


            s_masp.MaSP = masp;
            if (string.IsNullOrEmpty(s_tensanpham))
            {
                ViewData["Loi1"] = "Tên Sản Phẩm Không Được Để Trống";
            }
            else if (string.IsNullOrEmpty(s_hinhanh))
            {
                ViewData["Loi6"] = "Hình Ảnh Sản Phẩm Không Được Để Trống";
            }
            else if (string.IsNullOrEmpty(s_mota))
            {
                ViewData["Loi7"] = "Mô Tả Sản Phẩm Không Được Để Trống";
            }
            else if (string.IsNullOrEmpty(s_thoigian))
            {
                ViewData["Loi8"] = "Thời Gian Bảo Hành Sản Phẩm Không Được Để Trống";
            }
            else if (s_masp != null)
            {

                s_masp.TenSP = s_tensanpham;
                //masp.MALOAI = e_maloai;
                //masp.MASP = e_masp;
                s_masp.SoLuong = s_soluong;
                s_masp.GiaBan = s_giaban;
                s_masp.HinhAnh = s_hinhanh;
               

                UpdateModel(masp);
                fpt.SubmitChanges();
                return RedirectToAction("Admin", "Admin");

            }
            return this.Sua(masp);
        }

        public ActionResult NhanVien()
        {
            var nv = fpt.NhanViens.ToList();
            return View(nv);
        }

        public ActionResult Kho()
        {
            var kho = fpt.Khos.ToList();
            return View(kho);
        }
        //public ActionResult SuaKho()
        //{
        //    var suakho = fpt.Khos.ToList();
        //    return View(suakho);
        //}
        public ActionResult SuaKho(string masp)
        {
            var suakho_sp = fpt.Khos.First(sp => sp.MaSP == masp);
            var l_sp = from lsp in fpt.SanPhams select lsp;
            ViewData["SanPham"] = new SelectList(fpt.SanPhams, "MaSP", "MaSP");
            return View(suakho_sp);
        }
        [HttpPost]
        public ActionResult SuaKho(string masp, FormCollection collection)
        {
            var sk_masp = fpt.Khos.First(sp => sp.MaSP == masp);
            var sk_soluongton = int.Parse(collection["soluongton"]);
            var sk_loaike = collection["loaike"];


            sk_masp.MaSP = masp;
            if (string.IsNullOrEmpty(sk_loaike))
            {
                ViewData["Loi7"] = "Loại Kệ Sản Phẩm Không Được Để Trống";
            }
            else if (sk_masp != null)
            {
                sk_masp.SoLuongTon = sk_soluongton;
                sk_masp.LoaiKe = sk_loaike;

                UpdateModel(masp);
                fpt.SubmitChanges();
                return RedirectToAction("Kho", "Admin");

            }
            return this.SuaKho(masp);
        }
        //Thêm kho
        //public ActionResult ThemKho()
        //{
        //    var l_sp = from lsp in fpt.Khos select lsp;
        //    ViewData["MaSanPham"] = new SelectList(fpt.Khos, "MaSP", "TenSP");
        //    ViewData["SoLuongSanPham"] = fpt.SanPhams.Count();
        //    int flag = fpt.Khos.Count();
        //    return View();
        //}

        //[HttpPost]
        //public ActionResult ThemKho(FormCollection collection, Kho tk)
        //{
        //    var maSP = collection["MaSP"];

        //    var soLuongTon = int.Parse(collection["SoLuongTon"]);
        //    var loaiKe = collection["LoaiKe"];        
        //    if (string.IsNullOrEmpty(maSP))
        //    {
        //        ViewData["Loi"] = "Mã sản phẩm không được để trống!";
        //    }
        //    else if (soLuongTon < 0)
        //    {
        //        ViewData["Loi2"] = "Số lượng tồn sản phẩm không được nhỏ hơn 0 ";
        //    }
        //    else if (string.IsNullOrEmpty(loaiKe))
        //    {
        //        ViewData["Loi3"] = "Loại kệ sản phẩm không  được để trống!";
        //    }
        //    else
        //    {
        //        Kho themkho = fpt.Khos.FirstOrDefault(_tk => tk.MaSP == maSP);
        //        if (themkho != null)
        //        {
        //            ViewData["Loi4"] = "Mã sản phẩm không được nhỏ hơn 0!";
        //        }
        //        else
        //        {
        //            tk.MaSP = maSP;
        //            tk.SoLuongTon = soLuongTon;
        //            tk.LoaiKe = loaiKe;
        //            fpt.SubmitChanges();
        //            return RedirectToAction("Kho", "Admin");
        //        }
        //        ViewData["Loi4"] = "Mã sản phẩm không được trùng!";
        //        return RedirectToAction("DanhSachSanPham", "Admin");
        //    }
        //    return this.Them();
        //}
        //Xóa sản phẩm

        [HttpGet]
        public ActionResult DeleteKho(string masp)
        {
            var xoa_kho = fpt.Khos.First(xk => xk.MaSP == masp);
            return View(xoa_kho);
        }

        [HttpPost]
        public ActionResult DeleteKho(string masp, FormCollection collection)
        {
            var xoa_kho = fpt.Khos.Where(xk => xk.MaSP == masp).First();
            fpt.Khos.DeleteOnSubmit(xoa_kho);
            fpt.SubmitChanges();
            return RedirectToAction("Kho", "Admin");
        }
        public ActionResult Sua_NV(string manv)
        {
            if (manv != null)
            {
                var sua_nv = fpt.NhanViens.First(nv => nv.MaNV == manv);
                var l_sp = from lsp in fpt.ChucVus select lsp;
                ViewData["ChucVu"] = new SelectList(fpt.NhanViens, "MaNV", "MaNV");
                return View(sua_nv);
            }
            return RedirectToAction("NhanVien", "Admin");
        }
        [HttpPost]
        public ActionResult Sua_NV(string manv, FormCollection collection)
        {
            var s_manv = fpt.NhanViens.First(nv => nv.MaNV == manv);
            var s_tenNV = collection["tenNV"];
            var s_gioitinhNV = collection["gioitinhNV"];
            var s_ngaysinhNV = collection["ngaysinhNV"];
            var s_emailNV = collection["emailNV"];
            var s_sodienthoaiNV = collection["sdtNV"];
            var s_diachiNV = collection["diaChiNV"];
            var s_matkhauNV = collection["matkhauNV"];
            //var s_maPQ = collection["maPQ"];
            s_manv.MaNV = manv;
            String gioiTinh = "";
            if (string.IsNullOrEmpty(s_tenNV))
            {
                ViewData["Loi1"] = "Tên Nhân Viên Không Được Để Trống";
            }
            else if (string.IsNullOrEmpty(s_diachiNV))
            {
                ViewData["Loi2"] = "Địa Chỉ Nhân Viên Không Được Để Trống";
            }
            else
            {
                s_manv.TenNV = s_tenNV;
                if (s_gioitinhNV == "True")
                {
                    gioiTinh = "Nam";
                }
                else
                {
                    gioiTinh = "Nữ";
                }
                s_manv.GioiTinhNV = (gioiTinh == "Nam" ? true : false);
                DateTime ngaySinhNV = DateTime.Parse(s_ngaysinhNV);
                s_manv.EmailNV = s_emailNV;
                if (ngaySinhNV != null)
                {
                    s_manv.NgaySinhNV = ngaySinhNV;
                }
                s_manv.SDTNV = int.Parse
                    (s_sodienthoaiNV);
                s_manv.DiaChiNV = s_diachiNV;
                s_manv.MatKhauNV = s_matkhauNV;
                //s_manv.MaPQ = s_maPQ;
                UpdateModel(manv);
                fpt.SubmitChanges();
                return RedirectToAction("NhanVien", "Admin");
            }
            return this.Sua_NV(manv);
        }
        //Xóa nhân viên
        [HttpGet]
        public ActionResult DeleteNV(string manv)
        {
            var xoa_nv = fpt.NhanViens.First(nv => nv.MaNV == manv);
            return View(xoa_nv);
        }

        [HttpPost]
        public ActionResult DeleteNV(string manv, FormCollection collection)
        {
            var xoa_nv = fpt.NhanViens.Where(nv => nv.MaNV == manv).First();
            fpt.NhanViens.DeleteOnSubmit(xoa_nv);
            fpt.SubmitChanges();
            return RedirectToAction("NhanVien", "Admin");
        }

        public ActionResult QL_SanPham(string mansp)
        {
            List<SanPham> list_sp = fpt.SanPhams.ToList();
            List<SanPham> list_sp1 = list_sp.Where(sp => sp.MaNhomSP == mansp).ToList();
            return View(list_sp1);
        }

        public ActionResult Lay_TenNhomSP()
        {
            List<NhomSanPham> lst_sp = fpt.NhomSanPhams.ToList();
            return PartialView(lst_sp);
        }

        public ActionResult SuaNhomSP(string mansp)
        {
            var sua_nsp = fpt.NhomSanPhams.First(nsp => nsp.MaNhomSP == mansp);
            var l_nsp = from lnsp in fpt.SanPhams select lnsp;
            ViewData["NhomSanPham"] = new SelectList(fpt.SanPhams, "MaNhomSP", "MaNhomSP");
            return View(sua_nsp);
        }
        [HttpPost]
        public ActionResult SuaNhomSP(string mansp, FormCollection collection)
        {
            var sn_mansp = fpt.NhomSanPhams.First(nsp => nsp.MaNhomSP == mansp);
            var sn_tennhomsanpham = collection["tennsp"];
            


            sn_mansp.MaNhomSP = mansp;
            if (string.IsNullOrEmpty(sn_tennhomsanpham))
            {
                ViewData["Loi1"] = "Tên Nhóm Sản Phẩm Không Được Để Trống";
            }
            else
            {

                sn_mansp.TenNSP = sn_tennhomsanpham;
                UpdateModel(mansp);
                fpt.SubmitChanges();
                return RedirectToAction("NhomSP", "Admin");

            }
            return this.SuaNhomSP(mansp);
        }

        [HttpGet]
        public ActionResult DeleteNhomSP(string mansp)
        {
            var xoa_nsp = fpt.NhomSanPhams.First(xnsp => xnsp.MaNhomSP == mansp);
            return View(xoa_nsp);
        }

        [HttpPost]
        public ActionResult DeleteNhomSP(string mansp, FormCollection collection)
        {
            var xoa_nsp = fpt.NhomSanPhams.Where(xnsp => xnsp.MaNhomSP == mansp).First();
            fpt.NhomSanPhams.DeleteOnSubmit(xoa_nsp);
            fpt.SubmitChanges();
            return RedirectToAction("NhomSP", "Admin");
        }
        public ActionResult TimKiemAD()
        {
            return View();
        }
        [HttpGet]
        public ActionResult TimKiemAD(string id)
        {

            var sp = laySanPhamTimKiemAD(id);

            return View(sp);

        }

        private List<SanPham> laySanPhamTimKiemAD(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return fpt.SanPhams.Where(a => a.TenSP.ToLower().Contains("@(*&@*($&@*&$*(@$&(*@$&(@&$(*!&$*(&$")).ToList();
            }
            return fpt.SanPhams.Where(a => a.TenSP.Contains(id)).ToList();
        }
    }

}