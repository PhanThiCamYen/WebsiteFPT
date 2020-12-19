using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Web_FPT.Models;

namespace Web_FPT.Models
{
    public class GioHang
    {
        FPTDBContextDataContext fpt = new FPTDBContextDataContext();
        public string masp { set; get; }
        public string tensp { set; get; }
        public string hinhanh { set; get; }
        public decimal? giabanSP { set; get; }
        public int soluongSP { set; get; }
        public Double ThanhTien
        {
            get { return soluongSP * (double)giabanSP; }
        }
        public GioHang(string MaSanPham)
        {
            this.masp = MaSanPham;
            SanPham item = fpt.SanPhams.Single(n => n.MaSP == masp);
            this.tensp = item.TenSP;
            this.hinhanh = item.HinhAnh;
            this.giabanSP = item.GiaBan;
            this.soluongSP = 1;
        }
    }
}