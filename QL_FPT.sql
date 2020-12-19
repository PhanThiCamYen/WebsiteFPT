CREATE DATABASE  QL_FPT
GO

USE QL_FPT
GO
--Drop table ChucVu

Create table ChucVu
(
	MaPQ Char(5),
	TenChucVu Nvarchar(max),
	Constraint PK_MaPQ_ChucVu Primary key(MaPQ)
)
GO

Create table NhanVien
(
	MaNV Char(5),
	TenNV NVarChar(max),
	GioiTinhNV Bit,
	NgaySinhNV Date,
	EmailNV VarChar(40),
	SDTNV Int,
	DiaChiNV NVarChar(max),
	MatKhauNV VarChar(20),
	MaPQ Char(5),
	Constraint PK_MaNV_NhanVien Primary key(MaNV),
	Constraint FK_MaPQ_NhanVien Foreign key(MaPQ) References ChucVu(MaPQ)
)
GO
--drop table KhachHang

Create table KhachHang
(
	MaKH Char(5),
	TenKH NVarChar(max),
	GioiTinhKH Bit,
	NgaySinhKH Date,
	EmailKH VarChar(40),
	SDTKH Int,
	DiaChiKH NVarChar(max),
	Constraint PK_MaKH_KhachHang Primary key(MaKH)
)
GO

Create table NhomSanPham
(
	MaNhomSP Char(5),
	TenNSP NVarChar(max),
	Constraint PK_MaNhomSP_NhomSanPham Primary key(MaNhomSP)
)
GO

Create table SanPham
(
	MaSP Char(5),
	TenSP NVarChar(max),
	SoLuong Int,
	GiaBan INT,
	HinhAnh NVarChar(10),
	MoTa NVarChar(max),   
	ThoiGianBH NVarChar(10),
	MaNhomSP Char(5),
	Constraint PK_MaSP_SanPham Primary key(MaSP),
	Constraint FK_MaNhomSP_SanPham Foreign key(MaNhomSP) References NhomSanPham(MaNhomSP)
)
GO

Create table HoaDon
(
	MaHD Char(5),
	MaNV Char(5),
	MaKH Char(5),
	Constraint PK_MaHD_HoaDon Primary key(MaHD),
	Constraint FK_MaNV_HoaDon Foreign key(MaNV) References NhanVien(MaNV),
	Constraint FK_MaKH_HoaDon Foreign key(MaKH) References KhachHang(MaKH)

)
GO
--drop table ChiTietHoaDon
Create table ChiTietHoaDon
(
	MaCTHD Char(10),
	MaHD Char(5),
	MaSP Char(5),
	SoLuong Int,
	ThanhTien Money,
	NgayLap Date,
	Constraint PK_MaCTHDMaHDMaSP_ChiTietHoaDon Primary key(MaCTHD, MaHD, MaSP),
	Constraint FK_MaHD_ChiTietHoaDon Foreign key(MaHD) References HoaDon(MaHD),
	Constraint FK_MaSP_ChiTietHoaDon Foreign key(MaSP) References SanPham(MaSP)
)
GO

Create table NhaCungCap --CHƯA LÀM
(
	MaNCC Char(5),
	TenNCC NVarChar(max),
	DiaChiNCC NVarChar(max),
	SDTNCC Int,
	EmailNCC VarChar(40),
	Constraint PK_MaNCC_NhaCungCap Primary key(MaNCC)
)
GO

Create table KhuyenMai --CHƯA LÀM
(
	MaKM Char(5),
	MaSP Char(5),
	NgayBatDau Date,
	NgayKetThuc Date,
	MucGiamGia float,
	Constraint PK_MaKM_KhuyenMai Primary key(MaKM),
	Constraint FK_MaSP_KhuyenMai Foreign key(MaSP) References SanPham(MaSP)
)
GO

Create table LaiSuat
(
	MaSP Char(5),
	LaiSuat Float,
	GiaTG int,
	TraTruoc int,
	GopMoiThang int,
	LaiSuatMoiThang Float,
	PhiThuHo int,
	GiayToCanCo Nvarchar(max),
	LoaiNganHang Nvarchar(max),
	Constraint PK_MaSP_LaiSuat Primary key(MaSP,LaiSuat),
	Constraint FK_MaSP_Laisuat Foreign key(MaSP) References SanPham(MaSP),

)
GO


Create table TraGop
(
	MaSP Char(5),
	ThoiHanTG NVarChar(10),
	LaiSuatTG Float,
	Constraint PK_MaSP_TraGop Primary key(MaSP,LaiSuatTG),
	Constraint FK_MaSP_TraGop Foreign key(MaSP) References SanPham(MaSP)
)
GO
--drop table TraGop


Create table Kho
(
	MaSP Char(5),
	SoLuongTon Int,
	LoaiKe NChar(5),
	Constraint PK_MaSP_Kho Primary key(MaSP),
	Constraint FK_MaSP_Kho Foreign key(MaSP) References SanPham(MaSP)
)
GO

Create table BaoHanh
(
	MaSP Char(5),
	TinhTrang NVarChar(30),
	MaKH Char(5),
	ThoiGianBH NVarChar(10),
	Constraint PK_MaSP_BaoHanh Primary key(MaSP, MaKH),
	Constraint FK_MaSP_BaoHanh Foreign key(MaSP) References SanPham(MaSP),
	Constraint FK_MaKH_BaoHanh Foreign key(MaKH) References KhachHang(MaKH)
)
GO

Create table ThongKe --CHƯA LÀM
(
	NgayThongKe Date,
	MaHD Char(5),
	MaSP Char(5),
	TongTien Money,
	Constraint PK_NgayThongKe_ThongKe Primary key(NgayThongKe),
	Constraint FK_MaHD_ThongKe Foreign key(MaHD) References HoaDon(MaHD),
	Constraint FK_MaSP_ThongKe Foreign key(MaSP) References SanPham(MaSP)
)
GO

Create table PhieuNhap 
(
	MaPN Char(5),
	MaNV Char(5),
	MaNCC Char(5),
	NgayLap Date,
	TongTien Money,
	GhiChu NVarChar(max),
	Constraint PK_MaPN_PhieuNhap Primary key(MaPN),
	Constraint FK_MaNV_PhieuNhap Foreign Key(MaNV) References NhanVien(MaNV),
	Constraint FK_MaNCC_PhieuNhap Foreign Key(MaNCC) References NhaCungCap(MaNCC)
)
GO
--drop table ChiTietPhieuNhap
Create table ChiTietPhieuNhap 
(
	MaCTPN Char(10),
	MaPN Char(5),
	MaSP Char(5),
	SoLuong Int,
	ThanhTien Money,
	Constraint PK_MaPN_ChiTietPhieuNhap Primary key(MaPN, MaSP, MaCTPN),
	Constraint FK_MaPN_ChiTietPhieuNhap Foreign Key(MaPN) References PhieuNhap(MaPN),
	Constraint FK_MaSP_ChiTietPhieuNhap Foreign Key(MaSP) References SanPham(MaSP)
)
GO

Create table ThanhToan
(
	MaSP Char(5), 
	NgayMua Date,
	Constraint PK_MaSP_ThanhToan Primary key(MaSP, NgayMua),
	Constraint FK_MaSP_ThanhToan Foreign Key(MaSP) References SanPham(MaSP)

)
GO

Insert into ChucVu values ('QL', N'Quản Lý') --nam or nữ
Insert into ChucVu values ('NVBH', N'Nhân viên bán hàng') --nam or nữ
Insert into ChucVu values ('NVK', N'Nhân viên kho') --nam
Insert into ChucVu values ('NVTN', N'Nhân viên thu ngân') --nữ
Insert into ChucVu values ('NVKT', N'Nhân viên kĩ thuật')
Select * from ChucVu

Set DateForMat DMY  -- nam true 1 nữ false 0
Insert into NhanVien values ('NV01', N'Nguyễn Hoàng Huy', 'True','10-10-1995','hoanghuy1011@gmail.com',0795894033, N'Quận Bình Thạnh', 456, 'QL')
Insert into NhanVien values ('NV02', N'Nguyễn Thị Hoa', 'False','01-01-1999','thihoa0101@gmail.com',0792782774, N'Quận Tây Thạnh', 123, 'NVBH')
Insert into NhanVien values ('NV03', N'Ninh Thế Lâm', 'True','12-01-1996','thelam120101@gmail.com',0833123456, N'Quận 1', 789, 'NVBH')
Insert into NhanVien values ('NV04', N'Võ Anh Thư', 'False','23-12-1997','anhthu2312@gmail.com',0914007732, N'Quận 5', 012, 'NVBH')
Insert into NhanVien values ('NV05', N'Đặng Bảo Toàn', 'True','28-02-1997','baotoan3002@gmail.com',0365265311, N'Quận Gò Vấp', 234, 'NVK')
Insert into NhanVien values ('NV06', N'Nguyễn Hồng Quân', 'True','26-10-1990','hongquan2610@gmail.com',0790098765, N'Quận 3', 678, 'NVK')
Insert into NhanVien values ('NV07', N'Đặng Thương', 'False','11-11-1997','thuong1111@gmail.com',0792782774, N'Quận 1', 098, 'NVTN')
Insert into NhanVien values ('NV08', N'Trương Thị Mẫn', 'False','09-10-1987','thiman0910@gmail.com',0889145842, N'Quận 12', 111, 'NVTN')
Insert into NhanVien values ('NV09', N'Văn Thế Trung', 'True','17-12-1998','thetrung1712@gmail.com',0830198543, N'Quận 11', 222, 'NVKT')
Insert into NhanVien values ('NV10', N'Nguyễn Anh Kha', 'True','11-12-1998','anhkha1112@gmail.com',0789094574, N'Quận 9', 333, 'NVKT')
Select * from NhanVien

Set DateForMat DMY
Insert  into KhachHang values ('KH01', N'Phan Thị Cẩm Yên', 'False', '12-12-2000', 'camyen1212@gmail.com', 0792645393, N'Bến Lức')
Insert  into KhachHang values ('KH02', N'Cao Ngọc Thảo Vi', 'False', '11-10-1999', 'tthaovi1110@gmail.com', 0349876145, N'Tân An')
Insert  into KhachHang values ('KH03', N'Danh Cẩm Nhung', 'False', '09-12-1998', 'camnhung0912@gmail.com', 0798765912, N'Đức Hòa')
Insert  into KhachHang values ('KH04', N'Pham Thanh Trúc', 'False', '10-11-1997', 'thanhtruc1011@gmail.com', 0822645393, N'Đức Huệ')
Insert  into KhachHang values ('KH05', N'Nguyễn Hồng Trâm', 'False', '09-09-1996', 'hongtram0909@gmail.com', 0581234878, N'Quận 8')
Insert  into KhachHang values ('KH06', N'Nguyễn Ngọc Dung', 'False', '12-01-2000', 'ngocdung1201@gmail.com', 0992645393, N'Tân Tạo')
Insert  into KhachHang values ('KH07', N'Phan Thị Cẩm Hà', 'False', '08-02-1988', 'camha0802@gmail.com', 0562645393, N'Tân Túc')
Insert  into KhachHang values ('KH08', N'Nguyễn Kim Phụng', 'False', '13-10-1995', 'kimphung1310@gmail.com', 0922645393, N'Tân Bửu')
Insert  into KhachHang values ('KH09', N'Nguyễn Ngọc Hoa', 'False', '09-01-1990', 'ngochoa0901@gmail.com', 0782645393, N'Bình Chánh')
Insert  into KhachHang values ('KH10', N'Nguyễn Văn Kiệt', 'True', '11-02-1995', 'vankiet@gmail.com', 0772645393, N'Nhựt Chánh')
Insert  into KhachHang values ('KH11', N'Nguyễn Kim Ngân', 'False', '12-09-1994', 'kimngan1209@gmail.com', 0702645393, N'Tân Tạo')
Insert  into KhachHang values ('KH12', N'Nguyễn Thanh Tú', 'False', '12-12-1995', 'thanhtu1212@gmail.com', 0942645393, N'Bến Lức')
Insert  into KhachHang values ('KH13', N'Trườg Minh Quang', 'False', '02-01-1998', 'minhquang0201@gmail.com', 0940987632, N'An Thạnh')
Insert  into KhachHang values ('KH14', N'Vũ Minh Hòa', 'True', '01-01-1995', 'minhhoa0101@gmail.com', 0799876543, N'Quận 1')
Insert  into KhachHang values ('KH15', N'Trương Ngọc Ánh ', 'False', '12-10-2001', 'ngocanh1210@gmail.com', 0902645393, N'Quận 2')
Insert  into KhachHang values ('KH16', N'Trương Như Ý', 'False', '11-07-1996', 'nhuy1107@gmail.com', 0914007745, N'Tân An')
Insert  into KhachHang values ('KH17', N'Phan Đức Tài', 'True', '13-10-1994', 'ductai1310@gmail.com', 0729876523, N'Quận 12')
Insert  into KhachHang values ('KH18', N'Lưu Chi Vĩ', 'True', '12-12-1995', 'chivi1212@gmail.com', 0799876541, N'Bến Lức')
Insert  into KhachHang values ('KH19', N'Bùi Công Anh', 'True', '11-02-1989', 'conganh1102@gmail.com', 0701234534, N'Nhựt Chánh')
Insert  into KhachHang values ('KH20', N'Phan Thị Cẩm Giang', 'False', '01-01-1990', 'camgiang0101@gmail.com', 0795678983, N'Cần Giuộc')
Select * from KhachHang

Insert into NhomSanPham values ('DT', N'Điện thoại')
Insert into NhomSanPham values ('LT', N'Laptop')
Insert into NhomSanPham values ('DH', N'Đồng hồ')
Insert into NhomSanPham values ('TL', N'Tablet')
Insert into NhomSanPham values ('PK', N'Phụ kiện')
Insert into NhomSanPham values ('S',N'Sim điện thoại')
Select * from NhomSanPham

Insert into SanPham values ('DT001', N'IPhone 12 Mini 64GB',5, 21990000,'DT01.png',N'Màn hình:6.1, Super Retina XDR,AMOLED; Camera sau:12.0 MP + 12.0 MP; Camera Selfie:12.0 MP; Ram:4 GB; Bộ nhớ trong:64 GB; CPU:A14 Bionic; Dung lượng pin:2227 mAh; Thẻ sim:2,1 eSIM,1 Nano SIMHệ điều hành:iOS 14Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT002', N'IPhone 12 64GB',1, 24990000, 'DT02.png',N'Màn hình:5.4 Super Retina XDR,AMOLED,1080 x 2240 Pixel; Camera sau:12.0 MP + 12.0 MP; Camera Selfie:12.0 MP; Ram:4 GB; Bộ nhớ trong:64 GB; CPU:A14 Bionic; Dung lượng pin:2815 mAh; Thẻ sim:2,1 eSIM,1 Nano SIMHệ điều hành:iOS 14; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT003', N'IPhone 12 Pro 128GB',1, 30990000, 'DT03.png',N'Màn hình:6.1,Super Retina XDR, AMOLED; Camera sau:12.0 MP + 12.0 MP + 12.0 MP; Camera Selfie:12.0 MP; Ram:6 GB; Bộ nhớ trong:128 GB;CPU:A14 Bionic; Dung lượng pin:2815 mAh; Thẻ sim:2,1 eSIM,1 Nano SIMHệ điều hành:iOS 14; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT004', N'IPhone 12 Pro Max 128GB',1, 33990000, 'DT04.png',N'Màn hình:6.7,Super Retina XDR,AMOLED; Camera sau:12.0 MP + 12.0 MP + 12.0 MP; Camera Selfie:12.0 MP; Ram:6 GB; Bộ nhớ trong:128 GB;CPU:A14 Bionic; Dung lượng pin:3687 mAh; Thẻ sim:2,1 eSIM,1 Nano SIM; Hệ điều hành:iOS 14; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT005', N'IPhone 11 64GB',6, 17990000, 'DT05.png',N'Màn hình:6.1,Liquid Retina HD,IPS LCD,828 x 1792 Pixel; Camera sau:12.0 MP + 12.0 MP; Camera Selfie:12.0 MP; Ram:4 GB; Bộ nhớ trong:64 GB;CPU:A13 Bionic; Dung lượng pin:3110 mAh; Thẻ sim:2,1 eSIM,1 Nano SIM; Hệ điều hành:iOS 14; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT006', N'IPhone 11 Pro Max 512GB',7, 34990000, 'DT06.png',N'Màn hình:	6.5,Super Retina XDR,Super AMOLED,1242 x 2688 Pixel; Camera sau:12.0 MP + 12.0 MP + 12.0 MP; Camera Selfie:12.0 MP; Ram:4 GB;Bộ nhớ trong:512 GB; CPU:A13 Bionic; Dung lượng pin:3969 mAh;Thẻ sim:2,1 eSIM,1 Nano SIM; Hệ điều hành:iOS 14; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT007', N'IPhone 11 Pro 64GB',1, 24990000, 'DT07.png',N'Màn hình:5.8", Super Retina XDR, Super AMOLED, 1125 x 2436 Pixel; Camera sau:12.0 MP + 12.0 MP + 12.0 MP; Camera Selfie:12.0 MP; Ram:4 GB;Bộ nhớ trong:64 GB; CPU:A13 Bionic; Dung lượng pin:3046 mAh;Thẻ sim:2,1 eSIM,1 Nano SIM; Hệ điều hành:iOS 14; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT008', N'IPhone XR 64GB',7, 13490000, 'DT08.png',N'Màn hình:6.1", Liquid Retina HD, IPS LCD, 828 x 1792 Pixel; Camera sau: 12.0 MP; Camera Selfie:7.0 MP; Ram:3 GB; Bộ nhớ trong:64 GB; CPU:A12 Bionic; Dung lượng pin:2942 mAh;Thẻ sim:2, 1 eSIM,1 Nano SIM; Hệ điều hành:iOS 14; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT009', N'IPhone SE (2020) 64GB',1, 11990000, 'DT09.png',N'Màn hình:4.7, Retina HD, IPS LCD, 750 x 1334 Pixel; Camera sau: 12.0 MP; Camera Selfie:7.0 MP; Ram:3 GB; Bộ nhớ trong:64 GB; CPU:A13 Bionic; Dung lượng pin:1821 mAh; Thẻ sim:2, 1 eSIM,1 Nano SIM; Hệ điều hành:iOS 14; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT010', N'IPhone 8 Plus 64GB',1, 13490000, 'DT10.png',N'Màn hình:5.5", Retina HD, IPS LCD, 1080 x 1920 Pixel; Camera sau: 12.0 MP + 12.0 MP; Camera Selfie:7.0 MP; Ram:3 GB; Bộ nhớ trong:64 GB; CPU:A11 Bionic; Dung lượng pin:2691 mAh; Thẻ sim:1,Nano SIM; Hệ điều hành:iOS 14; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
 
Insert into SanPham values ('DT011', N'Samsung Galaxy Z Fold2 5G',8, 50000000, 'DT11.png',N'Màn hình:Màn hình trước:6.2, Màn hình chính: 7.6", HD+, Chính: Dynamic AMOLED 2X, phụ: Super AMOLED, 1768 x 2208 Pixel; Camera sau:12.0 MP + 12.0 MP + 12.0 MP;Camera Selfie:10.0 MP;Ram:12 GB;Bộ nhớ trong:256 GB;CPU:	Snapdragon 865+; Dung lượng pin:4500 mAh; Thẻ sim:1,SIM; Hệ điều hành:Android 10.0; Xuất xứ:Việt Nam',N'12 Tháng','DT')
Insert into SanPham values ('DT012', N'Samsung Galaxy Z Flip',1, 29000000, 'DT12.png',N'Màn hình:6.7, FHD+, Chính: Dynamic AMOLED, phụ: Super AMOLED, 1080 x 2636 Pixel; Camera sau:12.0 MP + 12.0 MP; Camera Selfie:10.0 MP; Ram:8 GB; Bộ nhớ trong:256 GB;CPU:Snapdragon 855+;Dung lượng pin:3300 mAh; Thẻ sim:2,1 eSIM,1 Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Việt Nam',N'12 Tháng','DT')
Insert into SanPham values ('DT013', N'Samsung Galaxy S20+',1, 23990000, 'DT13.png',N'Màn hình:6.7, QHD+, Dynamic AMOLED 2X, 1440 x 3200 Pixel; Camera sau:12.0 MP + 12.0 MP + 64.0 MP + 0.5 MP; Camera Selfie:10.0 MP; Ram:8 GB; Bộ nhớ trong:128 GB;CPU:Exynos 990v;Dung lượng pin:4500 mAh; Thẻ sim:2,2 Nano SIM hoặc 1 eSIM,1 Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Việt Nam',N'12 Tháng','DT')
Insert into SanPham values ('DT014', N'Samsung Galaxy S20 Ultra',1, 21990000, 'DT14.png',N'Màn hình:6.9, QHD+, Dynamic AMOLED 2X, 1440 x 3200 Pixel; Camera sau:108.0 MP + 12.0 MP + 48.0 MP + 0.5 MP; Camera Selfie:40.0 MP; Ram:12 GB; Bộ nhớ trong:128 GB;CPU:Exynos 990;Dung lượng pin:5000 mAh;Thẻ sim:2,2 Nano SIM hoặc 1 eSIM, 1 Nano SIM;Hệ điều hành:Android 10.0;Xuất xứ:Việt Nam',N'12 Tháng','DT')
Insert into SanPham values ('DT015', N'Samsung Galaxy S20 FE',1, 12990000, 'DT15.png',N'Màn hình:6.5, FHD+, Super AMOLED, 1080 x 2400 Pixel; Camera sau:12.0 MP + 12.0 MP + 8.0 MP;Camera Selfie:32.0 MP;Ram:8 GB;Bộ nhớ trong:8 GB; CPU:Exynos 990;Dung lượng pin:4500 mAh;Thẻ sim:2,2 Nano SIM hoặc 1 eSIM,1 Nano SIM; Hệ điều hành:Android 10.0;Xuất xứ:Việt Nam',N'12 Tháng','DT')
Insert into SanPham values ('DT016', N'Samsung Galaxy Note 20 Ultra 5G',7, 29990000, 'DT16.png',N'Màn hình:6.9, 2K+, Dynamic AMOLED 2X, 1440 x 3088 Pixel; Camera sau:108.0 MP + 12.0 MP + 12.0 MP; Camera Selfie:10.0 MP; Ram:12 GB; Bộ nhớ trong:256 GB;CPU:Exynos 990; Dung lượng pin:4500 mAh; Thẻ sim:2,2 Nano SIM hoặc 1 eSIM, 1 Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Việt Nam',N'12 Tháng','DT')
Insert into SanPham values ('DT017', N'Samsung Galaxy Note 20',5, 20990000, 'DT17.png',N'Màn hình:6.7, FHD+, Super AMOLED Plus, 1080 x 2400 Pixel; Camera sau:12.0 MP + 12.0 MP + 64.0 MP; Camera Selfie:10.0 MP; Ram:8 GB; Bộ nhớ trong:256 GB; CPU:Exynos 990; Dung lượng pin:4300 mAh; Thẻ sim:2,2 Nano SIM hoặc 1 eSIM, 1 Nano SIM, 1 Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Việt Nam',N'12 Tháng','DT')
Insert into SanPham values ('DT018', N'Samsung Galaxy Note 10 Lite',1, 10990000, 'DT18.png',N'Màn hình:6.7, FHD+, Super AMOLED, 1080 x 2400 Pixel; Camera sau:12.0 MP + 12.0 MP + 12.0 MP; Camera Selfie:32.0 MP; Ram:8 GB; Bộ nhớ trong:128 GB; CPU:Exynos 9810;Dung lượng pin:4500 mAh; Thẻ sim:2,Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Việt Nam',N'12 Tháng','DT')
Insert into SanPham values ('DT019', N'Samsung Galaxy A51',1, 7190000, 'DT19.png',N'Màn hình:6.5, FHD+, Super AMOLED, 1080 x 2400 Pixel; Camera sau:48.0 MP + 12.0 MP + 5.0 MP + 5.0 MP; Camera Selfie:32.0 MP; Ram:6 GB; Bộ nhớ trong:128 GB; CPU:Exynos 9611; Dung lượng pin:4000 mAh; Thẻ sim:2,Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Việt Nam',N'12 Tháng','DT')
Insert into SanPham values ('DT020', N'Samsung Galaxy M31',1, 5490000, 'DT20.png',N'Màn hình:6.4, FHD+, Super AMOLED, 1080 x 2340 Pixel; Camera sau:64.0 MP + 8.0 MP + 5.0 MP + 5.0 MP; Camera Selfie:32.0 MP; Ram:6 GB; Bộ nhớ trong:128 GB; CPU:Exynos 9611; Dung lượng pin:6000 mAh; Thẻ sim:2,Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Việt Nam',N'12 Tháng','DT')
Insert into SanPham values ('DT021', N'Samsung Galaxy A11',1, 3690000, 'DT21.png',N'Màn hình:6.4, HD+, PLS TFT LCD, 720 x 1560 Pixel; Camera sau:13.0 MP + 5.0 MP + 2.0 MP; Camera Selfie:8.0 MP; Ram:3 GB; Bộ nhớ trong:32 GB; CPU:Snapdragon 450; Dung lượng pin:4000 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Việt Nam',N'12 Tháng','DT')
Insert into SanPham values ('DT022', N'Samsung Galaxy A10s',1, 3690000, 'DT22.png',N'Màn hình:6.2, HD+, PLS TFT LCD, 720 x 1520 Pixel; Camera sau:13.0 MP + 2.0 MP; Camera Selfie:8.0 MP;Ram:2 GB; Bộ nhớ trong:32 GB; CPU:Helio P22; Dung lượng pin:4000 mAh; Thẻ sim:2,Nano SIM; Hệ điều hành:Android 9.0; Xuất xứ:Việt Nam',N'12 Tháng','DT')
Insert into SanPham values ('DT023', N'Samsung Galaxy A01 Core',1, 1990000, 'DT23.png',N'Màn hình:5.3, HD+, TFT LCD, 720 × 1480 Pixel; Camera sau:8.0 MP; Camera Selfie:5.0 MP;Ram:1 GB; Bộ nhớ trong:16 GB;CPU:MediaTek MT6739; Dung lượng pin:3000 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:Android Go; Xuất xứ:Việt Nam',N'12 Tháng','DT')
Insert into SanPham values ('DT024', N'Samsung Galaxy A31',1, 6490000, 'DT24.png',N'Màn hình:6.4, FHD+, Super AMOLED, 1080 x 2400 Pixel; Camera sau:48.0 MP + 8.0 MP + 5.0 MP + 5.0 MP; Camera Selfie:20.0 MP; Ram:6 GB; Bộ nhớ trong:128 GB; CPU:Helio P65; Dung lượng pin:5000 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Việt Nam',N'12 Tháng','DT')
 
Insert into SanPham values ('DT025', N'OPPO Reno4',1, 7990000, 'DT25.png',N'Màn hình:6.4, FHD+, AMOLED, 1080 x 2400 Pixel; Camera sau:48.0 MP + 8.0 MP + 2.0 MP + 2.0 MP; Camera Selfie:32.0 MP + Cảm biến thông minh A.I; Ram:8 GB; Bộ nhớ trong:128 GB; CPU:Snapdragon 720G; Dung lượng pin:4015 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:Android 10.0;Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT026', N'OPPO Reno4 Pro',5, 11990000, 'DT26.png',N'Màn hình:6.5, FHD+, AMOLED, 1080 x 2400 Pixel; Camera sau:48.0 MP + 8.0 MP + 2.0 MP + 2.0 MP; Camera Selfie:32.0 MP; Ram:8 GB; Bộ nhớ trong:256 GB; CPU:Snapdragon 720G; Dung lượng pin:4000 mAh;Thẻ sim:2, Nano SIM; Hệ điều hành:Android 10.0;Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT027', N'OPPO A53 4GB-128GB',1, 4990000, 'DT27.png',N'Màn hình:6.5, HD+, IPS LCD, 720 x 1600 Pixel; Camera sau:13.0 MP + 2.0 MP + 2.0 MP; Camera Selfie:16.0 MP; Ram:4 GB; Bộ nhớ trong:128 GB; CPU:Snapdragon 460; Dung lượng pin:5000 mAh;Thẻ sim:2, Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT028', N'OPPO A52 6GB-128GB',1, 5690000, 'DT28.png',N'Màn hình:6.5, FHD+, TFT LCD, 1080 x 2400 Pixel; Camera sau:12.0 MP + 8.0 MP + 2.0 MP + 2.0 MP; Camera Selfie:16.0 MP; Ram:6 GB; Bộ nhớ trong:128 GB;CPU:Snapdragon 665; Dung lượng pin:5000 mAh;Thẻ sim:2, Nano SIM;Hệ điều hành:Android 10.0;Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT029', N'OPPO A92',1, 6190000, 'DT29.png',N'Màn hình:6.5, FHD+, TFT LCD, 1080 x 2400 Pixel; Camera sau:48.0 MP + 8.0 MP + 2.0 MP + 2.0 MP; Camera Selfie:16.0 MP; Ram:8 GB; Bộ nhớ trong:128 GB; CPU:Snapdragon 665; Dung lượng pin:5000 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:Android 10.0;Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT030', N'OPPO A93 8GB-128GB',1, 7490000, 'DT30.png',N'Màn hình:6.43, FHD+, AMOLED, 1080 x 2400 Pixel; Camera sau:48.0 MP + 8.0 MP + 2.0 MP + 2.0 MP; Camera Selfie:16.0 MP + 2.0 MP; Ram:8 GB; Bộ nhớ trong:128 GB; CPU:Mediatek Helio P95; Dung lượng pin:4000 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT031', N'OPPO A12 3GB-32GB',5, 2990000, 'DT31.png',N'Màn hình:6.22, HD+, IPS LCD, 720 x 1560 Pixel; Camera sau:13.0 MP + 2.0 MP; Camera Selfie:5.0 MP; Ram:3 GB;Bộ nhớ trong:32 GB; CPU:Helio P35; Dung lượng pin:4230 mAh;Thẻ sim:2, Nano SIM; Hệ điều hành:Android 9.0; Xuất xứ:Trung Quốc',N'12 Tháng','DT')

Insert into SanPham values ('DT032', N'Vsmart Aris Pro 8GB-128GB',1, 9990000, 'DT32.png',N'Màn hình:6.39, FHD+, AMOLED, 1080 x 2340 Pixel; Camera sau:64.0 MP + 8.0 MP + 8.0 MP + 2.0 MP; Camera Selfie:20.0 MP;Ram:8 GB; Bộ nhớ trong:128 GB; CPU:Snapdragon 730; Dung lượng pin:4000 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Việt Nam',N'18 Tháng','DT')
Insert into SanPham values ('DT033', N'Vsmart Aris 8GB-128GB',1, 7490000, 'DT33.png',N'Màn hình:6.39, FHD+, AMOLED, 1080 x 2340 Pixel; Camera sau:64.0 MP + 8.0 MP + 8.0 MP + 2.0 MP; Camera Selfie:20.0 MP; Ram:8 GB; Bộ nhớ trong:128 GB; GPU:Adreno 618; Dung lượng pin:4000 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Việt Nam','18 Tháng','DT')
Insert into SanPham values ('DT034', N'Vsmart Live4 6GB-64GB',1, 4590000, 'DT34.png',N'Màn hình:6.5, FHD+, IPS LCD, 1080 x 2340 Pixel; Camera sau:48.0 MP + 8.0 MP + 5.0 MP + 2.0 MP; Camera Selfie:13.0 MP; Ram:6 GB; Bộ nhớ trong:64 GB; CPU:Snapdragon 675; Dung lượng pin:5000 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Việt Nam', N'18 Tháng','DT')
Insert into SanPham values ('DT035', N'Vsmart Joy 4 3GB-64GB',1, 3290000, 'DT35.png',N'Màn hình:6.53, FHD+, TFT LCD, 1080 x 2340 Pixel; Camera sau:16.0 MP + 8.0 MP + 2.0 MP + 2.0 MP; Camera Selfie:13.0 MP; Ram:3 GB; Bộ nhớ trong:64 GB; CPU:Snapdragon 665; Dung lượng pin:5000 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Việt Nam',N'18 Tháng','DT')
Insert into SanPham values ('DT036', N'Vsmart Star 4 3GB-32GB',1, 2490000, 'DT36.png',N'Màn hình:6.09, HD+, IPS LCD, 720 x 1560 Pixel; Camera sau:8.0 MP + 5.0 MP; Camera Selfie:8.0 MP; Ram:3 GB; Bộ nhớ trong:32 GB; CPU:Helio P35; Dung lượng pin:3500 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:Android 10.0;Xuất xứ:Việt Nam',N'18 Tháng','DT')
Insert into SanPham values ('DT037', N'Vsmart Bee 3 2GB-16GB',10, 1590000, 'DT37.png',N'Màn hình:6.0, HD+, IPS LCD, 720 x 1440 Pixel; Camera sau:8.0 MP; Camera Selfie:5.0 MP;Ram:2 GB; Bộ nhớ trong:16 GB; CPU:MT6739WW; Dung lượng pin:3000 mAh; Thẻ sim:2,Nano SIM; Hệ điều hành:Android 9.0; Xuất xứ:Việt Nam',N'18 Tháng','DT')

Insert into SanPham values ('DT038', N'Xiaomi Mi 10T Pro 5G 8GB-256GB',1, 12990000, 'DT37.png',N'Màn hình:6.67, FHD+, IPS LCD, 2440 x 1080 Pixel; Camera sau:108.0 MP + 13.0 MP + 5.0 MP; Camera Selfie:20.0 MP;Ram:8 GB; Bộ nhớ trong:256 GB; CPU:Snapdragon 865; Dung lượng pin:5000 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Trung Quốc',N'18 Tháng','DT')
Insert into SanPham values ('DT039', N'Xiaomi Poco X3 NFC 6GB-128GB',1, 6990000, 'DT39.png',N'Màn hình:6.67, FHD+, IPS LCD, 1080 x 2400 Pixel; Camera sau:64.0 MP + 13.0 MP + 2.0 MP + 2.0 MP; Camera Selfie:20.0 MP;Ram:6 GB; Bộ nhớ trong:128 GB; CPU:Snapdragon 732G; Dung lượng pin:5160 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Trung Quốc','N18 Tháng','DT')
Insert into SanPham values ('DT040', N'Xiaomi Redmin Note 9 Pro 6GB-128GB Xanh',1, 6990000, 'DT40.png',N'Màn hình:6.67, FHD+, IPS LCD, 1080 x 2400 Pixel; Camera sau:64.0 MP + 8.0 MP + 5.0 MP + 2.0 MP; Camera Selfie:16.0 MP;Ram:6 GB;Bộ nhớ trong:128 GB; CPU:Snapdragon 720G; Dung lượng pin:5020 mAh;Thẻ sim:2, Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Trung Quốc',N'18 Tháng','DT')
Insert into SanPham values ('DT041', N'Xiaomi Redmin Note 8 4GB-64GB Xanh',1, 4490000, 'DT41.png',N'Màn hình:6.3, FHD+, IPS LCD, 1080 x 2340 Pixel; Camera sau:48.0 MP + 8.0 MP + 2.0 MP + 2.0 MP; Camera Selfie:13.0 MP;Ram:4 GB;Bộ nhớ trong:64 GB; CPU:Snapdragon 665; Dung lượng pin:4000 mAh; Thẻ sim:2, Nano SIM;Hệ điều hành:Android 9.0;Xuất xứ:Trung Quốc',N'18 Tháng','DT')
Insert into SanPham values ('DT042', N'Xiaomi Redmin 9 3GB-32GB',8, 3590000, 'DT42.png',N'Màn hình:6.53, FHD+, IPS LCD, 1080 x 2340 Pixel; Camera sau:13.0 MP + 8.0 MP + 5.0 MP + 2.0 MP; Camera Selfie:8.0 MP; Ram:3 GB;Bộ nhớ trong:32 GB; CPU:Helio G80; Dung lượng pin:5020 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Trung Quốc',N'18 Tháng','DT')
Insert into SanPham values ('DT043', N'Xiaomi Redmin 9C 3GB-64GB',1, 2990000, 'DT43.png',N'Màn hình:6.53, HD+, IPS LCD, 720 x 1600 Pixel; Camera sau:13.0 MP + 2.0 MP + 2.0 MP; Camera Selfie:5.0 MP; Ram:3 GB; Bộ nhớ trong:64 GB; CPU:Mediatek Helio G35; Dung lượng pin:5000 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Trung Quốc',N'18 Tháng','DT')
Insert into SanPham values ('DT044', N'Xiaomi Redmin 9A 2GB-32GB',1, 1990000, 'DT44.png',N'Màn hình:6.53, HD+, IPS LCD, 720 x 1600 Pixel; Camera sau:13.0 MP; Camera Selfie:5.0 MP; Ram:2 GB; Bộ nhớ trong:32 GB; CPU:Mediatek Helio G25; Dung lượng pin:5000 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Trung Quốc',N'18 Tháng','DT')

Insert into SanPham values ('DT045', N'Realme 7i 8GB-128GB',1, 6290000, 'DT45.png',N'Màn hình:6.5, HD+, IPS LCD, 720 x 1600 Pixel; Camera sau:64.0 MP + 8.0 MP + 2.0 MP + 2.0 MP; Camera Selfie:16.0 MP; Ram:8 GB; Bộ nhớ trong:128 GB; CPU:Adreno 610; Dung lượng pin:5000 mAh;Thẻ sim:2, Nano SIM; Hệ điều hành:không; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT046', N'Realme 6 4GB-128GB',1, 5490000, 'DT46.png',N'Màn hình:6.5, FHD+, IPS LCD, 1080 x 2400 Pixel; Camera sau:64.0 MP + 8.0 MP + 2.0 MP + 2.0 MP; Camera Selfie:16.0 MP; Ram:4 GB; Bộ nhớ trong:128 GB; CPU:MediaTek Helio G90T; Dung lượng pin:đang cập nhật; Thẻ sim:2, Nano SIM;Hệ điều hành:Android 10.0; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT047', N'Realme C15 4GB-64GB',1, 4190000, 'DT47.png',N'Màn hình:6.52, HD+, LCD, 720 x 1600 Pixel; Camera sau:13.0 MP + 8.0 MP + 2.0 MP + 2.0 MP;Camera Selfie:8.0 MP; Ram:4 GB; Bộ nhớ trong:64 GB; CPU:Adreno 610; Dung lượng pin:6000 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Trung Quốc','12 Tháng','DT')
Insert into SanPham values ('DT048', N'Realme 5i 4GB-64GB',1, 3690000, 'DT48.png',N'Màn hình:6.52, HD+, IPS LCD, 720 x 1600 Pixel; Camera sau:12.0 MP + 8.0 MP + 2.0 MP + 2.0 MP; Camera Selfie:8.0 MP; Ram:4 GB; Bộ nhớ trong:64 GB; CPU:Snapdragon 665; Dung lượng pin:5000 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:Android 9.0; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT049', N'Realme C3 3GB-32GB',1, 2990000, 'DT49.png',N'Màn hình:6.5, HD+, IPS LCD, 720 x 1600 Pixel; Camera sau:12.0 MP + 2.0 MP + 2.0 MP; Camera Selfie:5.0 MP; Ram:3 GB; Bộ nhớ trong:32 GB; CPU:Helio G70; Dung lượng pin:5000 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:Android 9.0; Xuất xứ:Trung Quốc',N'12 Tháng','DT')

Insert into SanPham values ('DT050', N'Vivo V20 8GB-128GB',1, 8190000, 'DT50.png',N'Màn hình:6.44, FHD+, AMOLED, 1080 x 2400 Pixel; Camera sau:64.0 MP + 8.0 MP + 2.0 MP; Camera Selfie:44.0 MP;Ram:8 GB; Bộ nhớ trong:128 GB; CPU:Snapdragon 720G; Dung lượng pin:4000 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:Đang cập nhật; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT051', N'Vivo V19 8GB-128GB',1, 7990000, 'DT51.png',N'Màn hình:6.44, FHD+, Super AMOLED, 1080 x 2400 Pixel; Camera sau:48.0 MP + 8.0 MP + 2.0 MP + 2.0 MP; Camera Selfie:32.0 MP + 8.0 MP; Ram:8 GB; Bộ nhớ trong:128 GB; CPU:Snapdragon 712;Dung lượng pin:4500 mAh; Thẻ sim:2, Nano SIM;Hệ điều hành:Android 10.0;Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT052', N'Vivo Y50 8GB-128GB',1, 6290000, 'DT52.png',N'Màn hình:6.53, FHD+, LCD, 1080 x 2340 Pixel; Camera sau:13.0 MP + 8.0 MP + 2.0 MP + 2.0 MP; Camera Selfie:16.0 MP; Ram:8 GB; Bộ nhớ trong:128 GB; CPU:Snapdragon 665; Dung lượng pin:5000 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT053', N'Vivo Y20s 6GB-128GB',1, 4990000, 'DT53.png',N'Màn hình:6.51, HD+, IPS LCD, 720 x 1600 Pixel; Camera sau:13.0 MP + 2.0 MP + 2.0 MP; Camera Selfie:8.0 MP; Ram:6 GB; Bộ nhớ trong:128 GB; CPU:Snapdragon 460; Dung lượng pin:5000 mAh;Thẻ sim:2, Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT054', N'Vivo Y19 6GB-128GB',1, 3990000, 'DT54.png',N'Màn hình:6.53, FHD+, IPS LCD, 1080 x 2340 Pixel; Camera sau:16.0 MP + 8.0 MP + 2.0 MP; Camera Selfie:16.0 MP; Ram:6 GB; Bộ nhớ trong:128 GB; CPU:Helio P65; Dung lượng pin:5000 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:Android 9.0; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT055', N'Vivo Y1s 2GB-32GB',10, 2490000, 'DT55.png',N'Màn hình:6.22, HD+, IPS LCD, 720 x 1520 Pixel; Camera sau:13.0 MP; Camera Selfie:5.0 MP; Ram:2 GB; Bộ nhớ trong:32 GB; CPU:MediaTek Helio P35; Dung lượng pin:4030 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Trung Quốc',N'12 Tháng','DT')

Insert into SanPham values ('DT056', N'Nokia 8.3 5G',1, 11990000, 'DT56.png',N'Màn hình:6.8, FHD+, IPS LCD, 1080 x 2400 Pixel; Camera sau:64.0 MP + 12.0 MP + 2.0 MP + 2.0 MP; Camera Selfie:24.0 MP; Ram:8 GB; Bộ nhớ trong:128 GB; GPU:Adreno 620; Dung lượng pin:4500 mAh;Thẻ sim:2, Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT057', N'Nokia 2.4',1, 2490000, 'DT57.png',N'Màn hình:6.5, HD+, IPS LCD, 720 x 1600 Pixel; Camera sau:13.0 MP + 2.0 MP; Camera Selfie:5.0 MP; Ram:2 GB; Bộ nhớ trong:32 GB; GPU:PowerVR;Dung lượng pin:4500 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT058', N'Nokia 2.4',1, 1790000, 'DT58.png',N'Màn hình:2.8, QVGA, TFT, 320 x 240 Pixel; Camera sau:2.0 MP; Ram:512 MB; Bộ nhớ trong:4 GB;GPU:Adreno 304; Dung lượng pin:1500 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:KaiOS; Xuất xứ:Việt Nam',N'12 Tháng','DT')
Insert into SanPham values ('DT059', N'Nokia 230 (Không kèm thẻ nhớ)',1, 1250000, 'DT59.png',N'Màn hình:2.8, QVGA, TFT, 240 x 320 Pixel; Camera sau:2.0 MP; Camera Selfie:2.0 MP; Ram:Đang cập nhật; Bộ nhớ trong:Đang cập nhật; GPU:Đang cập nhật; Dung lượng pin:1200 mAh;Thẻ sim:2,SIM Thường; Hệ điều hành:Không; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT060', N'Nokia 215 DS 4G',1, 749000, 'DT60.png',N'Màn hình:2.8, QVGA, TFT, 240 x 320 Pixel; Ram:64 MB; Bộ nhớ trong:128 MB; GPU:Không; Dung lượng pin:1150 mAh; Thẻ sim:2,Nano SIM; Hệ điều hành:Nokia S30+; Xuất xứ:Việt Nam',N'12 Tháng','DT')
Insert into SanPham values ('DT061', N'Nokia 105 SS (2019)',1, 359000, 'DT61.png',N'Màn hình:1.77, QQVGA, TFT, 120 x 160 Pixel; Ram:4 MB; Bộ nhớ trong:4 MB; GPU:Không; Dung lượng pin:800 mAh; Thẻ sim:1,Nano SIM; Hệ điều hành:Nokia S30+; Xuất xứ:Trung Quốc',N'12 Tháng','DT')

Insert into SanPham values ('DT062', N'Huawei Nova 5T 8GB-128GB',1, 8990000, 'DT62.png',N'Màn hình:6.26, FHD+, IPS LCD, 1080 x 2340 Pixel; Camera sau:48.0 MP + 16.0 MP + 2.0 MP + 2.0 MP; Camera Selfie:32.0 MP;Ram:8 GB;Bộ nhớ trong:128 MB; CPU:Kirin 980;Dung lượng pin:3750 mAh;Thẻ sim:2,Nano SIM; Hệ điều hành:Android 9.0; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT063', N'Huawei Nova 7i',1, 6990000, 'DT63.png',N'Màn hình:6.4, FHD+, LCD, 1080 x 2312 Pixel; Camera sau:48.0 MP + 8.0 MP + 2.0 MP + 2.0 MP; Camera Selfie:16.0 MP; Ram:8 GB;Bộ nhớ trong:128 MB; GPU:Mali-G52; Dung lượng pin:4200 mAh; Thẻ sim:2,Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT064', N'Huawei Y6p',1, 3340000, 'DT64.png',N'Màn hình:6.3, HD+, IPS LCD, 720 x 1600 Pixel; Camera sau:13.0 MP + 5.0 MP + 2.0 MP; Camera Selfie:8.0 MP; Ram:4 GB; Bộ nhớ trong:64 GB; CPU:MediaTek Helio P22 (MT6762R); Dung lượng pin:5000 mAh; Thẻ sim:2,Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Trung Quốc',N'12 Tháng','DT')

Insert into SanPham values ('DT065', N'Masstel Hapi 10 Fami',1, 1190000, 'DT65.png',N'Màn hình:5.0, HD, IPS, 720 x 1280 Pixel; Camera sau:5.0 MP; Camera Selfie:5.0 MP; Ram:2 GB; Bộ nhớ trong:16 GB; GPU:IMG GE8100; Dung lượng pin:2000 mAh;Thẻ sim:2,Nano SIM; Hệ điều hành:Android 9.0;Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT066', N'Masstel Fami P20',1, 550000, 'DT66.png',N'Màn hình:2.2, FWVGA, TFT, 176 x 220 Pixel; Camera sau:0.08 MP; Ram:32 GB; Bộ nhớ trong:32 GB; GPU:Không; Dung lượng pin:1400 mAh;Thẻ sim:2,SIM Thường; Hệ điều hành:Không; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT067', N'Masstel Fami 12',1, 450000, 'DT67.png',N'Màn hình:1.77, QVGA, TFT, 128 x 160 Pixel; Camera sau:0.3 MP; Ram:Đang cập nhật; Bộ nhớ trong:Không cập nhật; GPU:Không; Dung lượng pin:1000 mAh;Thẻ sim:2,Micro SIM; Hệ điều hành:Không; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT068', N'Masstel Izi 300',1, 400000, 'DT68.png',N'Màn hình:2.4, QVGA, TFT, 320 x 240 Pixel; Camera sau:0.08 MP; Ram:32 GB; Bộ nhớ trong:32 GB; GPU:Không; Dung lượng pin:2500 mAh; Thẻ sim:2,SIM Thường, 1 Micri SIM; Hệ điều hành:Không; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT069', N'Masstel Izi 230',1, 350000, 'DT69.png',N'Màn hình:2.4, QVGA, TFT, 240 x 320 Pixels; Camera sau:0.08 MP; Ram:32 GB; Bộ nhớ trong:32 GB; GPU:Không; Dung lượng pin:1700 mAh; Thẻ sim:2,SIM Thường; Hệ điều hành:Không; Xuất xứ:Trung Quốc',N'12 Tháng','DT')
Insert into SanPham values ('DT070', N'Masstel Izi 120',1, 119000, 'DT70.png',N'Màn hình:1.77, QQVGA, TFT, 128 x 160 Pixel; Camera sau:0.3 MP; Ram:32 GB; Bộ nhớ trong:32 GB; GPU:Không; Dung lượng pin:800 mAh; Thẻ sim:2,SIM Thường; Hệ điều hành:Không; Xuất xứ:Trung Quốc',N'12 Tháng','DT')

Insert into SanPham values ('LT071', N'MacBook Pro 16" 2019 Touch Bar 2.3GHz core i9 1TB',1, 69990000,'LT71.png','CPU:Intel Core i9-9th-gen; Ram:16 GB, DDR4, 2666 MHz; Màn hình:16.0", 3072 x 1920 Pixel, IPS, IPS LCD LED Backlit, True Tone; Đồ họa:AMD Radeon Pro 5500M 4 GB & Intel UHD Graphics 630; Ổ cứng:SSD 1 TB; Hệ điều hành:Mac OS; Trọng lượng(kg):2.0; Kích thước(mm):357.9 x 24.59 x 16.2; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT072', N'MacBook Pro 13" 2019 Touch Bar 2.4GHz core i5 256GB',1, 41490000,'LT72.png','CPU:Intel Core i5-8th-gen; Ram:8 GB, LPDDR3, 2133 MHz; Màn hình:13.3", 2560 x 1600 Pixel, IPS, IPS LCD LED Backlit, True Tone; Đồ họa:	Intel Iris Plus Graphics 655; Ổ cứng:SSD 256 GB; Hệ điều hành:Mac OS; Trọng lượng(kg):1.37; Kích thước(mm):304.1 x 212.4 x 14.9; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT073', N'MacBook Pro 13" 2020 Touch Bar 1.4GHz core i5 256GB',7, 34990000,'LT73.png','CPU:Intel Core i5-8th-gen; Ram:8 GB, LPDDR3, 2133 MHz, LPDDR3, 2133 MHz; Màn hình:13.3", 2560 x 1600 Pixel, IPS, IPS LCD LED Backlit, True Tone; Đồ họa:Intel Iris Plus Graphics 645; Ổ cứng:SSD 256 GB; Hệ điều hành:Mac OS; Trọng lượng(kg):1.4; Kích thước(mm):304.1 x 212.4 x 15.6; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT074', N'MacBook Pro 13" 2020 1.1GHz core i5 512GB',5, 34990000,'LT74.png','CPU:Intel Core i5-10th-gen; Ram:8 GB, LPDDR4, 3733 MHz; Màn hình:13.3", 2560 x 1600 Pixel, IPS, IPS LCD LED Backlit, True Tone; Đồ họa:Intel Iris Plus Graphics; Ổ cứng:SSD 512 GB; Hệ điều hành:Mac OS; Trọng lượng(kg):1.29; Kích thước(mm):304.1 x 212.4 x 4.1 ~ 16.1; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT075', N'MacBook Air 13" 2020 1.1GHz Core i3 256GB',1, 28990000,'LT75.png','CPU:Intel Core i3-10th-gen; Ram:8 GB, LPDDR4, 3733 MHz; Màn hình:13.3", 2560 x 1600 Pixel, IPS, IPS LCD LED Backlit, True Tone; Đồ họa:Intel Iris Plus Graphics; Ổ cứng:SSD 256 GB; Hệ điều hành:Mac OS; Trọng lượng(kg):1.29; Kích thước(mm):304.1 x 212.4 x 4.1 ~ 16.1; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT076', N'MacBook Air 13" 2017 1.8GHz Core i5 128GB',1, 19990000,'LT76.png','CPU:Intel Core i5-5th-gen; Ram:8 GB, LPDDR3, 1600 MHz; Màn hình:	13.3", 1440 x 900 Pixel, LED-backlit; Đồ họa:Intel HD Graphics 6000; Ổ cứng:SSD 128 GB; Hệ điều hành:Mac OS; Trọng lượng(kg):1.35; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT077', N'MacBook Air 13" 2020 M1 256GB',1, 28990000,'LT77.png','CPU:Apple M1; Ram:8 GB; Màn hình:13.3", 2560 x 1600 Pixel, IPS, IPS LCD LED Backlit, True Tone; Ổ cứng:SSD 256 GB; Hệ điều hành:Mac OS; Trọng lượng(kg):1.29; Kích thước(mm):304.1 x 212.4 x 4.1 ~ 16.1; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT078', N'MacBook Air 13" 2019 1.6GHz Core i5 256GB',7, 31990000,'LT78.png','CPU:Intel Core i5-8th-gen; Ram:8 GB, LPDDR3, 2133 MHz; Màn hình:13.3", 2560 x 1600 Pixel, IPS, IPS LCD LED Backlit, True Tone; Ổ cứng:SSD 256 GB; Hệ điều hành:Mac OS; Trọng lượng(kg):1.25; Kích thước(mm):304.1 x 212.4 x 0.41 ~ 15.6; Xuất xứ:Trung Quốc',N'12 Tháng','LT')

Insert into SanPham values ('LT079', N'Asus Vivobook X509JAEJ247T i3 1005G1/8GB/512GB SSD/Win10',1, 11690000,'LT79.png','CPU:Intel Core i3-1005G1; Ram:8 GB, DDR4, 2666 MHz; Màn hình:15.6", 1920 x 1080 Pixels, TN, 60 Hz, 200 nits, Anti - Glare; Đồ họa:Intel UHD Graphics 620; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.9; Kích thước(mm):360 x 235 x 22.9; Xuất xứ:Trung Quốc',N'24 Tháng','LT')
Insert into SanPham values ('LT080', N'Asus Vivobook A412DA EK347T R3 3200U/4GB/512GB/Win10',1, 11190000,'LT80.png','CPU:AMD Ryzen 3-3200U; Ram:4 GB, DDR4, 2400 MHz; Màn hình:14.0", 1920 x 1080 Pixel, 60 Hz, LED-backlit; Đồ họa:AMD Radeon Graphics Vega 3; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.5; Xuất xứ:Trung Quốc',N'24 Tháng','LT')
Insert into SanPham values ('LT081', N'Asus Vivobook X509MA-BR063 N5000/4GB/256GB SSD/Win10',1, 7990000,'LT81.png','CPU:Intel Pentium N5000; Ram:	4 GB, DDR4, 2400 MHz; Màn hình:15.6", 1366 x 768 Pixel, 60 Hz, Anti-glare LED-backlit; Đồ họa:Intel UHD Graphics 605; Ổ cứng:SSD 256 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.7; Xuất xứ:Trung Quốc',N'24 Tháng','LT')
Insert into SanPham values ('LT082', N'Asus TUF FX506LI HN096T i7 1087H/8GB/256GB SSD/Win10',5, 26490000,'LT82.png','CPU:Intel Core i7-10610U; Ram:8 GB, DDR4, 2933 MHz; Màn hình:15.6", 1920 x 1080 Pixel, IPS, 144 Hz, 250 nits, LED Backlit; Đồ họa:NVIDIA GeForce GTX 1650Ti 4 GB & Intel HD Graphics 630; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):2.3; Kích thước(mm):359 x 24.7; Xuất xứ:Trung Quốc',N'24 Tháng','LT')
Insert into SanPham values ('LT083', N'Asus TUF FX505GT HN11 1T i5 9300H/8GB/512GB SSD/Win10',1, 20490000,'LT83.png','CPU:Intel Core i5-9300H; Ram:8 GB, DDR4, 2666 MHz; Màn hình:15.6", 1920 x 1080 Pixel, IPS, 144 Hz, 250 nits, Anti-glare LED-backlit; Đồ họa:NVIDIA GeForce GTX 1650 4 GB & Intel UHD Graphics 630; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):2.2; Kích thước(mm):360 x 262 x 26.8; Xuất xứ:Trung Quốc',N'24 Tháng','LT')
Insert into SanPham values ('LT084', N'Asus VivoBook M413I EK480T R5 4500/8GB/512GB SSD/Win10',1, 15890000,'LT84.png','CPU:AMD Ryzen 5-4500U; Ram:8 GB, DDR4, 3200 MHz; Màn hình:14.0", 1920 x 1080 Pixels, 60Hz, Anti-Glare with 45% NTSC, TN, 60 Hz, 200 nits, FHD; Đồ họa:AMD Radeon Graphics; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10 Home; Trọng lượng(kg):1.4; Xuất xứ:Trung Quốc',N'24 Tháng','LT')

Insert into SanPham values ('LT085', N'Dell G3 15 3500B i7 10750H/16GB/512GB/15.6"FHD/NV GTX1660Ti 6GB/Win10',6, 31490000,'LT85.png','CPU:Intel Core i7-10750H; Ram:16 GB, DDR4, 2933 MHz; Màn hình:15.6", 1920 x 1080 Pixel, WVA, 120 Hz, 250 nits, WVA Anti-glare LED Backlit Narrow Border; Đồ họa:NVIDIA GeForce GTX 1660Ti 6 GB & Intel UHD Graphics; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):2.58; Kích thước(mm):364.46 x 254 x 21.60 ~ 30.96; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT086', N'Dell XPS 13 9310 i5 1135G7/8GB/256GB/13.4"FHDTouch/Win10',5, 40990000,'LT86.png','CPU:Intel Core i5-1135G7; Ram:8 GB, LPDDR4, 4266 MHz; Màn hình:13.4", 1920 x 1080 Pixel, WVA, 60 Hz, 400 nits, LED-backlit; Đồ họa:Intel Iris Xe Graphics; Ổ cứng:SSD 256 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.32; Kích thước:296.9 x 208 x 14.7; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT087', N'Dell Inspiron N7306 i5 1135G7/8GB/512GB/13.3"FHD Touch/Win10',1, 27190000,'LT87.png','CPU:Intel Core i5-1135G7; Ram:8 GB, LPDDR4, 4266 MHz; Màn hình:13.3", Truelife LED-Backlit; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.4; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT088', N'Dell Vostro V5402 i7 1165G7/16GB/512GB/NVIDIA GF MX330/2GB/14.0"FHD/Win 10',1, 24990000,'LT88.png','CPU:Intel Core i7-1065G7; Ram:16 GB, DDR4, 3200 MHz; Màn hình:14.0", 1920 x 1080 Pixel, WVA, 60 Hz, 300 nits, Anti-glare LED-backlit; Đồ họa:NVIDIA GeForce MX330 2 GB & Intel Iris Plus Graphics; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.41; Kích thước(mm):322 x 216 x 16.4; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT089', N'Dell Inspiron N5584/Core i5-8265U/4GB/N5I5384W',1, 16990000,'LT89.png','CPU:Intel Core i5-8265U; Ram:4 GB, DDR4, 2400 MHz; Màn hình:15.6", 1920 x 1080 Pixel, TN, 60 Hz, LED-backlit; Đồ họa:NVIDIA GeForce MX130 2 GB & Intel UHD Graphics 620; Ổ cứng:HDD 1 TB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.95; Kích thước(mm):365 x 250 x 22; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT090', N'Dell Vostro V3405 R7 3700U/8GB/512GB/14"FHD/Win 10',1, 15990000,'LT90.png','CPU:AMD Ryzen 7-3700U; Ram:8 GB, DDR4, 2400 MHz; Màn hình:14.0", 1920 x 1080 Pixel, WVA, 60 Hz, 220 nits, Anti-glare LED-backlit; Đồ họa:NVIDIA GeForce MX130 2 GB & Intel UHD Graphics 620; Đồ họa:	Intel UHD Graphics; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.7; Kích thước:328 x 230 x 19.9; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT091', N'Dell Vostro V5490 i3 10110U/4GB/128GB/14"FHD/Win 10',1, 13690000,'LT91.png','CPU:Intel Core i3-10110U; Ram:4 GB, DDR4, 2666 MHz; Màn hình:14.0", 1920 x 1080 Pixel, TN, 60 Hz, 220 nits, Anti-glare LED-backlit; Đồ họa:Intel UHD Graphics 620; Đồ họa:	Intel UHD Graphics; Ổ cứng:SSD 128 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.49; Kích thước(mm):328 x 227.7 x 18.3; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT092', N'Dell N3581/Core i3-7020U/4GB/N5I3150W',1, 12290000,'LT92.png','CPU:Intel Core i3-7020U; Ram:4 GB, DDR4, 2133 MHz; Màn hình:15.6", 1920 x 1080 Pixel, LED-backlit; Đồ họa:AMD Radeon 520 2 GB & Intel HD Graphics 620; Ổ cứng:đang cập nhật; Hệ điều hành:Windows 10; Trọng lượng(kg):2.18; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT093', N'Dell Inspiron N3501 i3 1005G1/4GB/256GB/15.6"FHD/Win 10',1, 11890000,'LT93.png','CPU:Intel Core i3-1005G1; Ram:4 GB, DDR4, 2666 MHz; Màn hình:15.6", 1920 x 1080 Pixel, WVA, 60 Hz, 220 nits; Đồ họa:Intel UHD Graphics; Ổ cứng:SSD 256 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.91; Kích thước(mm):363.96 x 249 x 18 ~ 19.90; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT094', N'Dell Inspiron N3593C i3 1005G1/4GB/256GB/15.6"FHD/Win 10',1, 11690000,'LT94.png','CPU:Intel Core i3-1005G1; Ram:4 GB, DDR4, 2666 MHz; Màn hình:15.6", 1920 x 1080 Pixel, WVA, 60 Hz, 220 nits,Anti-glare LED-backlit; Đồ họa:Intel UHD Graphics;Đồ họa:Intel UHD Graphics; Ổ cứng:SSD 256 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):2; Kích thước(mm):380 x 258 x 19.89 ~ 19.90; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT095', N'Dell Inspiron N3593 i3 1005G1/4GB/256GB/14.0"FHD/Win 10',1, 10590000,'LT95.png','CPU:Intel Core i3-1005G1; Ram:4 GB, DDR4, 2666 MHz; Màn hình:14.0", 1920 x 1080 Pixel, LED-backlit; Đồ họa:Intel UHD Graphics; Ổ cứng:SSD 256 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.724; Xuất xứ:Trung Quốc',N'12 Tháng','LT')

Insert into SanPham values ('LT096', N'Acer Nitro 5 AN515-55-55E3 i5 10300H/16GB/512GB SSD/Nvidia RTX2060-6GB/WIN 10',9, 30490000,'LT96.png','CPU:Intel Core i5-10300H; Ram:16 GB, DDR4, 2933 MHz; Màn hình:16 GB, DDR4, 2933 MHz; Đồ họa:NVIDIA GeForce RTX 2060 6 GB; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):2.3; Kích thước(mm):363.4 x 255 x 23.9 Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT097', N'Acer Nitro 5 AN515-55-55E3 i5 10300H/8GB/512GB/15.6FHD/Win 10',1, 22490000,'LT97.png','CPU:Intel Core i5-10300H; Ram:8 GB, DDR4, 2666 MHz; Màn hình:15.6", 1920 x 1080 Pixel, IPS, 60 Hz, LED-backlit; Đồ họa:NVIDIA GeForce GTX 1650Ti 4 GB & Intel UHD Graphics; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):2.3; Kích thước(mm):363.4 x 255 x 23.9; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT098', N'Acer Swift 5 SF514 53T 58PN/Core i5 8265U/NX.H7HSV.001',5, 21590000,'LT98.png','CPU:Intel Core i5-8265U; Ram:8 GB, DDR4, 2400 MHz; Màn hình:8 GB, DDR4, 2400 MHz; Đồ họa:NVIDIA GeForce GTX 1650Ti 4 GB & Intel UHD Graphics	Intel UHD Graphics; Ổ cứng:SSD 256 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):0.97; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT099', N'Acer Aspire Gaming A715 41G R282 R5 3550H/8GD4/512GSSD/Win10',1, 19490000,'LT99.png','CPU:AMD Ryzen 5-3550H; Ram:8 GB, DDR4, 2666 MHz; Màn hình:15.6", 1920 x 1080 Pixel, IPS, 60 Hz, LED-backlit; Đồ họa:NVIDIA GeForce GTX 1650Ti 4 GB & AMD Radeon RX Graphics Vega 10; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):2.1; Kích thước(mm):363.4 x 254.5 x 23.25; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT100', N'Acer Aspire 5 A514 53 50JA i5 1035G1/4GB/256GB/14.0"FHD/Win 10',1, 14690000,'LT100.png','CPU:Intel Core i5-1035G1; Ram:4 GB, DDR4, 2400 MHz; Màn hình:14.0", 1920 x 1080 Pixel, IPS, 60 Hz, LED-backlit; Đồ họa:	Intel UHD Graphics; Ổ cứng:SSD 256 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.5; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT101', N'Acer Swift SF315 41 R0DX/R5-2500U/NX.GV7SV.005',1, 13490000,'LT101.png','CPU:AMD Ryzen 5-2500U; Ram:4 GB, DDR4, 2666 MHz; Màn hình:	15.6", 1920 x 1080 Pixel, IPS, 60 Hz, LED-backlit; Đồ họa:AMD Radeon Graphics Vega 8; Ổ cứng:HDD 1 TB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.7; Kích thước(mm):	359 x 243 x 16.9; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT102', N'Acer Aspire 5 A514 53 346U i3 1005G1/4GB/512GB/14"FHD/Win 10',1, 13190000,'LT102.png','CPU:Intel Core i3-1005G1; Ram:4 GB, DDR4, 2666 MHz; Màn hình:	14.0", 1920 x 1080 Pixel, IPS, 60 Hz, LED-backlit; Đồ họa:Intel UHD Graphics; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.5; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT103', N'Acer Aspire 3 A315-23G-R33Y R5 3500U/8G/512G SSD/15.6 FHD/Win10',1, 12490000,'LT103.png','CPU:AMD Ryzen 5-3500U; Ram:8 GB, DDR4, 2400 MHz; Màn hình:	15.6", 1920 x 1080 Pixel, TN, 60 Hz, Acer ComfyView LED-backlit; Đồ họa;AMD Radeon 625 2 GB & AMD Radeon Graphics Vega 8; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10 Home; Trọng lượng(kg):1.7; Kích thước(mm):363.4 x 250.2 x 19.9; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT104', N'Acer Aspire 3 A315 23 R8BA R3 3250U/4GB/256GB/Win 10',1, 9490000,'LT104.png','CPU:AMD Ryzen 3-3250U; Ram:4 GB, DDR4, 2400 MHz; Màn hình:15.6", 1920 x 1080 Pixel, 60 Hz, LED-backlit; Đồ họa:AMD Radeon Graphics; Ổ cứng:SSD 256 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.7; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT105', N'Acer Aspire 3 A315 34 C38Y CDC N4020/4GB/256GB/15.6"HD/Win 10',1, 6990000,'LT105.png','CPU:Intel Celeron N4020; Ram:4 GB, DDR4, 2666 MHz; Màn hình:15.6", 1280 x 720 Pixel, Acer ComfyView LED-backlit; Đồ họa:Intel UHD Graphics 600; Ổ cứng:SSD 256 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.7; Xuất xứ:Trung Quốc',N'12 Tháng','LT')

Insert into SanPham values ('LT106', N'HP Envy 13 aq1047TU i7 10510U/8G/512GSSD/WIN10',5, 28290000,'LT106.png','CPU:Intel Core i7-10510U; Ram:8 GB, DDR4, 2400 MHz; Màn hình:13.3", 1920 x 1080 Pixel, IPS, BrightView Micro-edge WLED-backlit; Đồ họa:Intel UHD Graphics; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.3; Kích thước(mm):307 x 211.5 x 14.7; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT107', N'HP Envy 13 aq1023TU i7 10510U/8GB/512GB SSD/WIN10',1, 27890000,'LT107.png','CPU:Intel Core i7-10510U; Ram:8 GB, DDR4, 2400 MHz; Màn hình:13.3", 1920 x 1080 Pixel, IPS, BrightView Micro-edge WLED-backlit; Đồ họa:Intel UHD Graphics; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.26; Kích thước(mm):307 x 211.5 x 14.7; Xuất xứ:Trung Quốc',N'12Tháng','LT')
Insert into SanPham values ('LT108', N'HP ENVY 13 ba0046TU i5 1035G4/8GB/512GB SSD/WIN10+Office Home & Student',1, 22690000,'LT108.png','CPU:Intel Core i5-1035G4; Ram:8 GB, DDR4, 3200 MHz; Màn hình:13.3", 1920 x 1080 Pixel, IPS, 60 Hz, 300 nits, Micro-edge WLED-backlit; Đồ họa:Intel Plus Graphics; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.3; Kích thước(mm):306.5 x 194.6 x 16.9; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT109', N'HP Pavilion 15-eg0069TU i5 1135G7/8GB/512GB/Win 10-Office Home& Student',1, 17590000,'LT109.png','CPU:Intel Core i5-1135G7; Ram:8 GB, LPDDR4, 3200 MHz; Màn hình:15.6", 1920 x 1080 Pixel, IPS, 60 Hz, BrightView Micro-edge WLED-backlit, IPS, 60 Hz, 300 nits, Micro-edge WLED-backlit; Đồ họa:Intel UHD Graphics; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.693; Kích thước(mm):361.6 x 245.6 x 17.9; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT110', N'HP Pavilion x360 14 dw0061TU i3 1005G1/4GB/512GB SSD/14.0FHD Touch',6, 14790000,'LT110.png','CPU:Intel Core i3-1005G1; Ram:4 GB, DDR4, 3200 MHz; Màn hình:14.0", 1920 x 1080 Pixel, IPS, 60 Hz, 250 nits, WLED-backlit; Đồ họa:Intel UHD Graphics; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.65; Kích thước(mm):	324 x 19; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT111', N'HP 15s fq1116TU i3 1005G1/8GB/512GB SSD/WIN10',1, 12690000,'LT111.png','CPU:Intel Core i3-1005G1; Ram:8 GB, DDR4, 2666 MHz; Màn hình:15.6", 1366 x 768 Pixel, SVA, 60 Hz, 220 nits, Micro-edge WLED-backlit; Đồ họa:Intel UHD Graphics; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.65; Kích thước(mm):358.8 x 242.2 x 17.9; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT112', N'HP Pavilion 14-ce1014TU/Core i3-8145U/4GB/500GB/WIN10',1, 9490000,'LT112.png','CPU:Intel Core i3-8145U; Ram:4 GB, DDR4, 2400 MHz; Màn hình:14.0", 1920 x 1080 Pixel, 60 Hz, LED-backlit; Đồ họa:Intel UHD Graphics 620; Ổ cứng:HDD 500 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.53; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT113', N'HP 348 G7 i3 8130U/4GB/256GB/14.0"HD/Intel HD/FP/Win 10',1, 10690000,'LT113.png','CPU:Intel Core i3-8130U; Ram:4 GB, DDR4, 2666 MHz; Màn hình:14.0", 1366 x 768 Pixel, 60 Hz, 220 nits, WLED-backlit; Đồ họa:Intel UHD Graphics 620; Ổ cứng:SSD 256 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.42; Kích thước(mm):324 x 225 x 19.9; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT114', N'HP Spectre x360 13 i7 1065G7/16GB/512GB SSD/13.3" UHD/W10',1, 45490000,'LT114.png','CPU:Intel Core i7-1065G7; Ram:16 GB, LPDDR4, 3200 MHz; Màn hình:13.3", 3840 x 2160 Pixel, AMOLED, 60 Hz, 400 nits, BrightView Micro-edge WLED-backlit; Đồ họa:Intel Iris Plus Graphics; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.3; Kích thước(mm):	306 x 194.5 x 16.9; Xuất xứ:Trung Quốc',N'12 Tháng','LT')

Insert into SanPham values ('LT115', N'Lenovo IdeaPad S145 14IIL i3 1005G1/4GB/256GB/14.0"FHD/Win 10',1, 9890000,'LT115.png','CPU:Intel Core i3-1005G1; Ram:4 GB, DDR4, 2667 MHz; Màn hình:14.0", 1920 x 1080 Pixel, TN, 220 nits, LED-backlit; Đồ họa:Intel UHD Graphics 620; Ổ cứng:SSD 256 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.6; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT116', N'Lenovo Ideapad S340-14IIL I3 1005G1/4GB/512GB SSD/WIN10',1, 11990000,'LT116.png','CPU:Intel Core i3-1005G1; Ram:4 GB, DDR4, 2666 Mhz; Màn hình:14.0", 1920 x 1080 Pixel, TN, LED-backlit; Đồ họa:Intel UHD Graphics; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.6;  Kích thước(mm):322.7 x 230.5 x 17.9; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT117', N'Lenovo IdeaPad C340 15IIL i5 1035G1/8GB/512GB SSD/Win10',1, 15790000,'LT117.png','CPU:Intel Core i5-1035G1; Ram:8 GB, DDR4, 2666 MHz; Màn hình:8 GB, DDR4, 2666 MHz; Đồ họa:Intel UHD Graphics; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):2;  Kích thước(mm):364 x 250 x 20.5; Xuất xứ:Trung Quốc',N'12Tháng','LT')
Insert into SanPham values ('LT118', N'Lenovo ThinkPad E14 i5 10210U/8GB/512GB SSD/WIN10',1, 17790000,'LT118.png','CPU:Intel Core i5-10210U; Ram:8 GB, DDR4, 2666 MHz; Màn hình:14.0", 1920 x 1080 Pixel, TN, 60 Hz, 220 nits, LED-backlit; Đồ họa:Intel UHD Graphics; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.77; Kích thước(mm):325 x 232 x 20.5; Xuất xứ:Trung Quốc',N'12Tháng','LT')
Insert into SanPham values ('LT119', N'Lenovo Legion 5 15IMH05 i5 10300H/8GB/512GB/GTX 1650 4GB G6/15.6"FHD/Win 10',5, 23490000,'LT119.png','CPU:Intel Core i5-10300H; Ram:8 GB, DDR4, 2933 MHz; Màn hình:	15.6", 1920 x 1080 Pixel, IPS, 120 Hz, 250 nits, LED-backlit; Đồ họa:NVIDIA GeForce GTX 1650 4 GB & Intel UHD Graphics; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):2.3; Kích thước(mm):363 x 260 x 25.4; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT120', N'Lenovo ThinkPad X1 Carbon 8 i7 10510U/16GB/512GB/14”WQHD/Win 10 Pro',1, 44990000,'LT120.png','CPU:Intel Core i7-10510U; Ram:16 GB, LPDDR3, 2133 MHz; Màn hình:14.0", 2560 x 1440 Pixel, WVA, 60 Hz, 300 nits, WVA Anti-glare LED Backlit Narrow Border; Đồ họa:Intel UHD Graphics; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.1; Kích thước(mm):323 x 216 x 14.9; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT121', N'Lenovo ThinkPad T14s Gen 1 i7 10510U/16GB/512GB/14”FHD/Win 10 Pro',5, 34990000,'LT121.png','CPU:Intel Core i7-10510U; Ram:16 GB, DDR4, 3200 MHz; Màn hình:14.0", 1920 x 1080 Pixel, WVA, 60 Hz, 250 nits, WVA Anti-glare LED Backlit Narrow Border; Đồ họa:Intel UHD Graphics; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.35; Kích thước(mm):328 x 222 x 16.4; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT122', N'Huawei MateBook 13 i5 10210U/16GB/512GB SSD/13"2K/Nvidia MX250_2GB/Win10',1, 29990000,'LT122.png','CPU:Intel Core i5-10210U; Ram:16 GB, LPDDR3, 2133 MHz; Màn hình:13.0", 2160 x 1440 Pixel, IPS, 60 Hz, 300 nits; Đồ họa:NVIDIA GeForce MX250 2 GB; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.32; Kích thước(mm):280.5 x 211.5 x 14.9; Xuất xứ:Trung Quốc',N'12 Tháng','LT')

Insert into SanPham values ('LT123', N'MSI Modern 14 A10M 1053VN i5 10210U/4GB/256GB/14"FHD/Win10',1, 15690000,'LT123.png','CPU:Intel Core i5-10210U; Ram:4 GB, DDR4, 2666 MHz; Màn hình:14.0", 1920 x 1080 Pixel, IPS, 60 Hz, LED-backlit; Đồ họa:Intel UHD Graphics; Ổ cứng:SSD 256 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.19; Kích thước(mm):322 x 222 x 15.9; Xuất xứ:Trung Quốc',N'12Tháng','LT')
Insert into SanPham values ('LT124', N'MSI GF63 9SCXR i5 9300H/8GB/512GB/Intel HM370/15.6"FHD/Win 10',1, 18490000,'LT124.png','CPU:Intel Core i5-9300H; Ram:8 GB, DDR4, 2666 MHz; Màn hình:15.6", 1920 x 1080 Pixel, IPS, 60 Hz, LED-backlit; Đồ họa:NVIDIA GeForce GTX 1650 Max-Q 4 GB & Intel UHD Graphics 630; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.86; Kích thước(mm):359 x 254 x 21.7; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT125', N'MSI Gaming GF63-1218VN i5 10300H/8GB/512GB SSD/Nvidia GTX 1650_4GB/Win10',1, 20690000,'LT125.png','CPU:Intel Core i5-10300H; Ram:8 GB, DDR4, 2666 MHz; Màn hình:15.6", 1920 x 1080 Pixel, IPS, 144 Hz, 300 nits, IPS LCD LED Backlit, True Tone; Đồ họa:NVIDIA GeForce GTX 1650 4 GB & Intel UHD Graphics; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.86; Kích thước(mm):359 x 245 x 21.7; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT126', N'MSI Prestige 14-206VN i5 1135G7/8GB/512GB SSD/Intel Iris Xe/Win10',1, 24990000,'LT126.png','CPU:Intel Core i5-1135G7; Ram:8 GB, LPDDR4; Màn hình:14.0", 1920 x 1080 Pixel, IPS, 144 Hz, 300 nits, IPS LCD LED Backlit, True Tone; Đồ họa:Intel Iris Xe Graphics; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.29; Kích thước(mm):319 x 219 x 15.9; Xuất xứ:Trung Quốc',N'12 Tháng','LT')
Insert into SanPham values ('LT127', N'MSI GF65 10SDR-623VN i5 10300H/8GB/512GB SSD/15.6" FHD 144Hz/Nvidia GTX1660Ti 6GB/Win10',1, 28990000,'LT127.png','CPU:Intel Core i5-10300H; Ram:16 GB, DDR4, 2666 MHz; Màn hình:15.6", 1920 x 1080 Pixel, IPS, 144 Hz, 300 nits, Acer ComfyView Anti-glare LED-backlit; Đồ họa:NVIDIA GeForce GTX 1660Ti 6 GB & Intel UHD Graphics; Ổ cứng:SSD 512 GB; Hệ điều hành:Windows 10; Trọng lượng(kg):1.86; Kích thước(mm):359 x 254 x 21.7; Xuất xứ:Trung Quốc',N'12 Tháng','LT')

Insert into SanPham values ('DH128', N'Đồng hồ Daniel Klein DK.1.12357-1',1, 1000000,'DH128.png',N'Thương hiệu: DANIEL KLEIN; Đối tượng sử dụng: Nữ; Model:DK.1.12357.1; Loại máy đồng hồ:Pin; Màu sắc:Bạc; Màu sắc dây đeo:Demi(trắng & vàng); Chất liệu dây:Kim loại; Hình dáng mặt đồng hồ:Hình tròn; Xuất xứ:Hong Kong; Khả năng chống nước:3 ATM',N'24 Tháng','DH')
Insert into SanPham values ('DH129', N'Đồng hồ Daniel Klein DK.1.12343-4',1, 920000,'DH129.png',N'Thương hiệu: DANIEL KLEIN; Đối tượng sử dụng: Nữ; Model:DK.1.12343.4; Loại máy đồng hồ:Pin; Màu sắc:Vàng hồng; Màu sắc dây đeo:Demi(trắng & vàng); Chất liệu dây:Da; Hình dáng mặt đồng hồ:Hình tròn; Xuất xứ:Hong Kong; Khả năng chống nước:3 ATM',N'24 Tháng','DH')
Insert into SanPham values ('DH130', N'Đồng hồ Daniel Klein DK.1.12292-6',1, 970000,'DH130.png',N'Thương hiệu: DANIEL KLEIN; Đối tượng sử dụng: Nữ; Model:DK.1.12292.6; Loại máy đồng hồ:Pin; Màu sắc:Bạc; Màu sắc dây đeo:Demi(trắng & vàng); Chất liệu dây:Da; Hình dáng mặt đồng hồ:Hình tròn; Xuất xứ:Hong Kong; Khả năng chống nước:3 ATM',N'24 Tháng','DH')
Insert into SanPham values ('DH131', N'Đồng hồ Sinobi - 11S9799L01',1, 790000,'DH131.png',N'Thương hiệu:Sinobi; Đối tượng sử dụng: Nữ; Model:11S9799L01; Loại máy đồng hồ:Pin; Màu sắc:Vàng hồng; Màu sắc dây đeo:Vàng hồng; Chất liệu dây:Thép Không Gỉ; Hình dáng mặt đồng hồ:Hình tròn; Xuất xứ:Trung Quốc; Khả năng chống nước:3ATM - Rửa tay, đi mưa nhỏ',N'12 Tháng','DH')
Insert into SanPham values ('DH132', N'Đồng hồ Ferrari 0830747',1, 2800000,'DH132.png',N'Thương hiệu:Ferrari; Đối tượng sử dụng: Nam; Model:0830747; Loại máy đồng hồ:Pin; Màu sắc:Đen; Màu sắc dây đeo:Đen; Chất liệu dây:Cao su; Hình dáng mặt đồng hồ:Hình tròn; Xuất xứ:Ý; Khả năng chống nước:3ATM - Rửa tay, đi mưa nhỏ',N'24 Tháng','DH')
Insert into SanPham values ('DH133', N'Đồng hồ Daniel Klein DK.1.12364-3',1, 1240000,'DH133.png',N'Thương hiệu:DANIEL KLEIN; Đối tượng sử dụng: Nữ; Model:DK.1.12364.3; Loại máy đồng hồ:Pin; Màu sắc:Vàng; Màu sắc dây đeo:Demi (trắng & vàng); Chất liệu dây:Kim loại; Hình dáng mặt đồng hồ:Hình tròn; Xuất xứ:Hong Kong; Khả năng chống nước:3ATM',N'24 Tháng','DH')
Insert into SanPham values ('DH134', N'Đồng hồ Anne Klein AK/2718RGPK',1, 2900000,'DH134.png',N'Thương hiệu:Anne Klein; Đối tượng sử dụng: Nữ; Model:AK/2718RGPK; Loại máy đồng hồ:Pin; Màu sắc:Hồng nhạt; Màu sắc dây đeo:Hồng nhạt; Chất liệu dây:Da; Hình dáng mặt đồng hồ:Hình tròn; Xuất xứ:Mỹ; Khả năng chống nước:3ATM - Rửa tay, đi mưa nhỏ',N'12 Tháng','DH')
Insert into SanPham values ('DH135', N'Đồng hồ Fossil FS5279',1, 3750000,'DH135.png',N'Thương hiệu:Fossil; Đối tượng sử dụng: Nam; Model:FS5279; Loại máy đồng hồ:Pin; Màu sắc:Xanh dương; Màu sắc dây đeo:Nâu; Chất liệu dây:Da; Hình dáng mặt đồng hồ:Hình tròn; Xuất xứ:Mỹ; Khả năng chống nước:5ATM - Đi tắm',N'24 Tháng','DH')
Insert into SanPham values ('DH136', N'Đồng hồ Lacoste 2011048',1, 5000000,'DH136.png',N'Thương hiệu:Lacoste; Đối tượng sử dụng: Nam; Model:2011048; Loại máy đồng hồ:Pin; Màu sắc:Demi vàng hồng; Màu sắc dây đeo:Demi (trắng & vàng); Chất liệu dây:Thép Không Gỉ; Hình dáng mặt đồng hồ:Hình tròn; Xuất xứ:Pháp; Khả năng chống nước:50M - 5ATM - Đi bơi nhẹ',N'24 Tháng','DH')
Insert into SanPham values ('DH137', N'Đồng hồ Citizen AN8172-53P',1, 5570000,'DH137.png',N'Thương hiệu:Citizen; Đối tượng sử dụng: Nam; Model:AN8172-53P; Loại máy đồng hồ:Pin; Màu sắc:Vàng; Màu sắc dây đeo:Vàng; Chất liệu dây:Thép Không Gỉ; Hình dáng mặt đồng hồ:Hình tròn; Xuất xứ:Nhật Bản; Khả năng chống nước:10ATM - Đi bơi, lặn nhẹ',N'12 Tháng','DH')
Insert into SanPham values ('DH138', N'Đồng hồ Bulova 98P180',1, 9600000,'DH138.png',N'Thương hiệu:Bulova; Đối tượng sử dụng: Nữ; Model:98P180; Loại máy đồng hồ:Pin; Màu sắc:Vàng; Màu sắc dây đeo:Demi (trắng & vàng); Chất liệu dây:Thép Không Gỉ; Hình dáng mặt đồng hồ:Hình tròn; Xuất xứ:Mỹ; Khả năng chống nước:3ATM - Rửa tay, đi mưa nhỏ',N'36 Tháng','DH')
Insert into SanPham values ('DH139', N'Đồng hồ Ferrari 0830712',1, 7600000,'DH139.png',N'Thương hiệu:Ferrari; Đối tượng sử dụng: Nam; Model:0830712; Loại máy đồng hồ:Pin; Màu sắc:Đen; Màu sắc dây đeo:Đen; Chất liệu dây:Da; Hình dáng mặt đồng hồ:Hình tròn; Xuất xứ:Ý; Khả năng chống nước:50M - 5ATM - Đi bơi nhẹ',N'24 Tháng','DH')
Insert into SanPham values ('DH140', N'Đồng Hồ Citizen BX1006-85E',1, 11600000,'DH140.png',N'Thương hiệu:Citizen; Đối tượng sử dụng: Nam; Model:BX1006-85E; Loại máy đồng hồ:Eco-Drive; Màu sắc:Đen; Màu sắc dây đeo:Demi (trắng & vàng); Chất liệu dây:Thép Không Gỉ; Hình dáng mặt đồng hồ:Hình tròn; Xuất xứ:Nhật Bản; Khả năng chống nước:50M - 5ATM - Đi bơi nhẹ',N'12 Tháng','DH')
Insert into SanPham values ('DH141', N'Đồng Hồ Bulova 96A204',1, 12000000,'DH141.png',N'Thương hiệu:Bulova; Đối tượng sử dụng: Nam; Model:96A204; Loại máy đồng hồ:Automatic; Màu sắc:Xanh; Màu sắc dây đeo:Trắng; Chất liệu dây:Thép Không Gỉ; Hình dáng mặt đồng hồ:Hình tròn; Xuất xứ:Mỹ; Khả năng chống nước:3ATM - Rửa tay, đi mưa nhỏ',N'36 Tháng','DH')
Insert into SanPham values ('DH142', N'Đồng Hồ Citizen NP1010-01L',1, 12500000,'DH142.png',N'Thương hiệu:Citizen; Đối tượng sử dụng: Nam; Model:NP1010-01L; Loại máy đồng hồ:Automatic; Màu sắc:Xanh; Màu sắc dây đeo:Đen; Chất liệu dây:Da; Hình dáng mặt đồng hồ:Hình tròn; Xuất xứ:Nhật Bản; Khả năng chống nước:10ATM - Đi bơi, lặn nhẹ',N'12 Tháng','DH')

Insert into SanPham values ('DH143', N'Apple Watch Series 3 GPS 38mm viền nhôm dây cao su',1, 5490000,'DH143.png',N'Công nghệ màn hình:OLED Retina display with Force Touch;Kích thước màn hình:38mm; CPU:Apple S3; Bộ nhớ trong:8GB; Hệ điều hành:watchOS; Kết nối được với hệ điều hành:iOS; Chất liệu mặt:Ion-X strengthened glass; Chất liệu dây:Cao su; Chống nước:Có, độ sâu dưới 50m; Thời gian sử dụng pin:Sử dụng đến 18h; Kết nối:Wi-Fi, Bluetooth; Xuất xứ:Trung Quốc',N'12 Tháng','DH')
Insert into SanPham values ('DH144', N'Apple Watch Series 3 GPS Cellular 42mm viền nhôm dây cao su',1, 6990000,'DH144.png',N'Công nghệ màn hình:OLED Retina display with Force Touch; Kích thước màn hình:42mm; CPU:Apple S3; Bộ nhớ trong:16GB; Hệ điều hành:watchOS; Kết nối được với hệ điều hành:iOS; Chất liệu mặt:Ion-X strengthened glass; Chất liệu dây:Cao su; Chống nước:Có, độ sâu dưới 50m; Thời gian sử dụng pin:Sử dụng đến 18h; Kết nối:Wi-Fi,Cellular,Bluetooth; Xuất xứ:Trung Quốc',N'12 Tháng','DH')
Insert into SanPham values ('DH145', N'Apple Watch Nike Series 5 GPS 40mm viền nhôm dây cao su',1, 9990000,'DH145.png',N'Công nghệ màn hình:LTPO OLED display (1000 nits); Kích thước màn hình:40mm; CPU:Apple S5; Bộ nhớ trong:32GB; Hệ điều hành:watchOS; Kết nối được với hệ điều hành:iOS; Chất liệu mặt:Ion-X strengthened glass; Chất liệu dây:Cao su; Chống nước:Có, độ sâu dưới 50m; Thời gian sử dụng pin:Sử dụng đến 18h; Kết nối:Wi-F,Bluetooth; Xuất xứ:Trung Quốc',N'12 Tháng','DH')
Insert into SanPham values ('DH146', N'Apple Watch Series 5 GPS 44mm viền nhôm dây cao su',1, 10990000,'DH146.png',N'Công nghệ màn hình:LTPO OLED display (1000 nits); Kích thước màn hình:44mm; CPU:Apple S5; Bộ nhớ trong:32GB; Hệ điều hành:watchOS; Kết nối được với hệ điều hành:iOS; Chất liệu mặt:Ion-X strengthened glass; Chất liệu dây:Cao su; Chống nước:Có, độ sâu dưới 50m; Thời gian sử dụng pin:Sử dụng đến 18h; Kết nối:Wi-F,Bluetooth; Xuất xứ:Trung Quốc',N'12 Tháng','DH')
Insert into SanPham values ('DH147', N'Apple Watch Series 5 GPS Cellular 44mm viền nhôm dây cao su',1, 12990000,'DH147.png',N'Công nghệ màn hình:LTPO OLED display (1000 nits); Kích thước màn hình:44mm; CPU:Apple S5; Bộ nhớ trong:32GB; Hệ điều hành:watchOS; Kết nối được với hệ điều hành:iOS; Chất liệu mặt:Ion-X strengthened glass; Chất liệu dây:Cao su; Chống nước:Có, độ sâu dưới 50m; Thời gian sử dụng pin:Sử dụng đến 18h; Kết nối:Wifi, Cellular, Bluetooth; Xuất xứ:Trung Quốc',N'12 Tháng','DH')
Insert into SanPham values ('DH148', N'Apple Watch Series 5 GPS Cellular 40mm viền thép dây milanese',10, 18990000,'DH148.png',N'Công nghệ màn hình:LTPO OLED display (1000 nits); Kích thước màn hình:40mm; CPU:Apple S5; Bộ nhớ trong:32GB; Hệ điều hành:watchOS; Kết nối được với hệ điều hành:iOS; Chất liệu mặt:Sapphire crystal; Chất liệu dây:Milanese Loop; Chống nước:Có, độ sâu dưới 50m; Thời gian sử dụng pin:Sử dụng đến 18h; Kết nối:Wifi, Cellular, Bluetooth; Xuất xứ:Trung Quốc',N'12 Tháng','DH')
Insert into SanPham values ('DH149', N'Apple Watch Series 6 GPS 40mm viền nhôm dây cao su',6, 11990000,'DH149.png',N'Công nghệ màn hình:LTPO OLED display (1000 nits); Kích thước màn hình:40mm; CPU:Apple S6; Bộ nhớ trong:32GB; Hệ điều hành:watchOS; Kết nối được với hệ điều hành:iPhone 6s trở lên dùng iOS mới nhất; Chất liệu mặt:Ion-X strengthened glass; Chất liệu dây:Cao su; Chống nước:Có, độ sâu dưới 50m; Thời gian sử dụng pin:Sử dụng đến 18h; Kết nối:Wifi, Bluetooth; Xuất xứ:Trung Quốc',N'12 Tháng','DH')
Insert into SanPham values ('DH150', N'Apple Watch Series 6 GPS + Cellular 40mm viền nhôm dây cao su',1, 14490000,'DH150.png',N'Công nghệ màn hình:LTPO OLED display (1000 nits); Kích thước màn hình:40mm; CPU:Apple S6; Bộ nhớ trong:32GB; Hệ điều hành:watchOS; Kết nối được với hệ điều hành:iPhone 6s trở lên dùng iOS mới nhất; Chất liệu mặt:Ion-X strengthened glass; Chất liệu dây:Cao su; Chống nước:Có, độ sâu dưới 50m; Thời gian sử dụng pin:Sử dụng đến 18h; Kết nối:Wifi, Cellular,Bluetooth; Xuất xứ:Trung Quốc',N'12 Tháng','DH')
Insert into SanPham values ('DH151', N'Apple Watch Series 6 GPS + Cellular 44mm viền thép dây thép',8, 21490000,'DH151.png',N'Công nghệ màn hình:LTPO OLED display (1000 nits); Kích thước màn hình:44mm; CPU:Apple S6; Bộ nhớ trong:32GB; Hệ điều hành:watchOS; Kết nối được với hệ điều hành:iPhone 6s trở lên dùng iOS mới nhất; Chất liệu mặt:Ion-X strengthened glass; Chất liệu dây:Thép; Chống nước:Có, độ sâu dưới 50m; Thời gian sử dụng pin:Sử dụng đến 18h; Kết nối:Wifi, Cellular,Bluetooth; Xuất xứ:Trung Quốc',N'12 Tháng','DH')

Insert into SanPham values ('TL152', N'Samsung Galaxy Tab S7 ',5, 18990000, 'TL152.png',N'Màn hình:11.0" , WQHD+ , LTPS IPS LCD , 1600 x 2560 Pixel;Camera sau:	5.0 MP + 13.0 MP;Camera Selfie:8.0 MP;Ram:6 GB;Bộ nhớ trong:128 GB;CPU:Snapdragon 865+; Dung lượng pin:8000 mAh; Thẻ sim:1 ,Nano SIM; Hệ điều hành:Android 10.0;Xuất xứ:Việ Nam',N'12 Tháng','TL')
Insert into SanPham values ('TL153', N'Samsung Galaxy Tab S6 Lite ',1, 9990000, 'TL153.png',N'Màn hình:10.4" , FHD , PLS LCD , 1200 x 2000 Pixel; Camera sau:8.0 MP; Camera Selfie:	5.0 MP; Ram:4 GB;Bộ nhớ trong:64 GB; CPU:Exynos 9611; Dung lượng pin:7040 mAh; Thẻ sim:1,Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Việ Nam',N'12 Tháng','TL')
Insert into SanPham values ('TL154', N'Samsung Tab A 10.1 (2019)',1, 7490000, 'TL154.png',N'Màn hình:10.1" , FHD , TFT LCD , 1920 x 1280 Pixel; Camera sau:8.0 MP; Camera Selfie:	5.0 MP; Ram:3 GB;Bộ nhớ trong:32 GB; CPU:Exynos 7904; Dung lượng pin:6150 mAh; Thẻ sim:1,Nano SIM; Hệ điều hành:Android 9.0; Xuất xứ:Việ Nam',N'12 Tháng','TL')
Insert into SanPham values ('TL155', N'Samsung Galaxy Tab A Plus 8.0 (2019)',1, 6990000, 'TL155.png',N'Màn hình:8.0" , WUXGA , TFT , 1920 x 1200 Pixel; Camera sau:8.0 MP; Camera Selfie:	5.0 MP; Ram:3 GB;Bộ nhớ trong:32 GB; CPU:Exynos 7904; Dung lượng pin:4200 mAh; Thẻ sim:1, Nano SIM; Hệ điều hành:Android 9.0; Xuất xứ:Việ Nam',N'12 Tháng','TL')
Insert into SanPham values ('TL156', N'Samsung Galaxy Tab A8 (2019)',1, 3690000, 'TL156.png',N'Màn hình:8.0" , HD+ , TFT LCD , 1280 x 800 Pixel; Camera sau:8.0 MP; Camera Selfie:	2.0 MP; Ram:2 GB;Bộ nhớ trong:32 GB; CPU:Snapdragon 429; Dung lượng pin:5100 mAh; Thẻ sim:1,Nano SIM; Hệ điều hành:Android 9.0; Xuất xứ:Việ Nam',N'12 Tháng','TL')

Insert into SanPham values ('TL157', N'iPad Pro 12.9 2020 WI-FI 4G 128GB',6, 30990000, 'TL157.png',N'Màn hình:12.9" , Liquid Retina HD , IPS LCD , 2732 x 2048 Pixel; Camera sau:8.0 MP10.0 MP + 12.0 MP; Camera Selfie:7.0 MP; Ram:6 GB;Bộ nhớ trong:128 GB; CPU:A12Z Bionic; Dung lượng pin:9720 mAh; Thẻ sim:1, 1 eSIM, 1 Nano SIM; Hệ điều hành:iPadOS; Xuất xứ:Trung Quốc',N'12 Tháng','TL')
Insert into SanPham values ('TL158', N'iPad Pro 11 2020 WI-FI 4G 128GB',8, 25990000, 'TL158.png',N'Màn hình:11.0" , Liquid Retina HD , IPS LCD , 2388 x 1668 Pixel; Camera sau:10.0 MP + 12.0 MP; Camera Selfie:7.0 MP; Ram:6 GB;Bộ nhớ trong:128 GB; CPU:A12Z Bionic; Dung lượng pin:7540 mAh; Thẻ sim:1, 1 eSIM, 1 Nano SIM; Hệ điều hành:iPadOS; Xuất xứ:Trung Quốc',N'12 Tháng','TL')
Insert into SanPham values ('TL159', N'iPad Air 10.9 2020 Wi-Fi + Cellular 64GB',1, 20990000, 'TL159.png',N'Màn hình:10.9" , Liquid Retina HD , IPS LCD , 2360 x 1640 Pixel; Camera sau:12.0 MP; Camera Selfie:7.0 MP; Ram:3 GB;Bộ nhớ trong:64 GB; CPU:A14 Bionic; Dung lượng pin:Đang cập nhật; Thẻ sim:1 , 1 eSIM, 1 Nano SIM; Hệ điều hành:iPadOS; Xuất xứ:Trung Quốc',N'12 Tháng','TL')
Insert into SanPham values ('TL160', N'iPad Mini 5 7.9 Wi-Fi 4G 256GB',1, 18990000, 'TL160.png',N'Màn hình:	7.9" , Retina HD , IPS LCD , 2048 x 1536 Pixel; Camera sau:8.0 MP; Camera Selfie:7.0 MP; Ram:3 GB;Bộ nhớ trong:256 GB; CPU:A12 Bionic; Dung lượng pin:5124 mAh; Thẻ sim:1, 1 eSIM, 1 Nano SIM; Hệ điều hành:iPadOS; Xuất xứ:Trung Quốc',N'12 Tháng','TL')
Insert into SanPham values ('TL161', N'iPad Air 10.9 2020 Wi-Fi 64GB',1, 16990000, 'TL161.png',N'Màn hình:10.9" , Liquid Retina HD , IPS LCD , 2360 x 1640 Pixel; Camera sau:12.0 MP; Camera Selfie:7.0 MP; Ram:3 GB;Bộ nhớ trong:64 GB; CPU:A14 Bionic; Dung lượng pin:5124 mAh; Thẻ sim:1, 1 eSIM, 1 Nano SIM; Hệ điều hành:iPadOS; Xuất xứ:Trung Quốc',N'12 Tháng','TL')
Insert into SanPham values ('TL162', N'iPad 10.2 2020 Wi-Fi + Cellular 32GB',1, 8990000, 'TL162.png',N'Màn hình:10.2" , Retina HD , IPS LCD , 2160 x 1620 Pixel; Camera sau:8.0 MP; Camera Selfie:1.2 MP; Ram:3 GB;Bộ nhớ trong:32 GB; CPU:A12 Bionic; Dung lượng pin:Đang cập nhật;Thẻ sim:0; Hệ điều hành:iPadOS; Xuất xứ:Trung Quốc',N'12 Tháng','TL')
Insert into SanPham values ('TL163', N'iPad 10.2 2020 Wi-Fi + Cellular 32GB',1, 12990000, 'TL163.png',N'Màn hình:10.2", Retina HD , IPS LCD , 2160 x 1620 Pixel; Camera sau:8.0 MP; Camera Selfie:1.2 MP; Ram:3 GB;Bộ nhớ trong:32 GB; CPU:A12 Bionic; Dung lượng pin:Đang cập nhật; Thẻ sim:1; Hệ điều hành:iPadOS; Xuất xứ:Trung Quốc',N'12 Tháng','TL')
Insert into SanPham values ('TL164', N'iPad Mini 5 7.9 Wi-Fi 64GB',1, 9990000, 'TL164.png',N'Màn hình:7.9", Retina HD , IPS LCD , 2048 x 1536 Pixel; Camera sau:8.0 MP; Camera Selfie:7.0 MP; Ram:3 GB;Bộ nhớ trong:32 GB; CPU:A12 Bionic; Dung lượng pin:5124 mAh; Thẻ sim:0; Hệ điều hành:iPadOS; Xuất xứ:Trung Quốc',N'12 Tháng','TL')


Insert into SanPham values ('TL165', N'Masstel Tab 8 Plus',10, 1890000, 'TL165.png',N'Màn hình:8.0", WXGA, IPS, 1280 x 800 Pixel; Camera sau:5.0 MP; Camera Selfie:2.0 MP; Ram:1 GB;Bộ nhớ trong:8 GB; GPU:Mali-T400; Dung lượng pin:4000 mAh; Thẻ sim:2, Micro SIM; Hệ điều hành:Android 8.1; Xuất xứ:Trung Quốc',N'12 Tháng','TL')
Insert into SanPham values ('TL166', N'Masstel Tab 10 Plus',1, 2290000, 'TL166.png',N'Màn hình:10.1", WXGA, IPS TFT, 800 x 1280 Pixel; Camera sau:8.0 MP; Camera Selfie:2.0 MP; Ram:1 GB; Bộ nhớ trong:8 GB; GPU:Mali-T400; Dung lượng pin:5000 mAh; Thẻ sim:2, SIM Thường; Hệ điều hành:Android 8.1; Xuất xứ:Trung Quốc',N'12 Tháng','TL')
Insert into SanPham values ('TL167', N'Masstel Tab 10 Ultra',1, 3490000, 'TL167.png',N'Màn hình:10.1", HD, IPS, 800 x 1280 Pixel; Camera sau:8.0 MP; Camera Selfie:2.0 MP; Ram:3 GB; Bộ nhớ trong:32 GB; GPU:Đang cập nhật; Dung lượng pin:5000 mAh; Thẻ sim:2, Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Trung Quốc',N'12 Tháng','TL')
Insert into SanPham values ('TL168', N'Masstel Tab 10 Pro',1, 2590000, 'TL168.png',N'Màn hình:10.1", WXGA, IPS, 1280 x 800 Pixel; Camera sau:5.0 MP; Camera Selfie:2.0 MP; Ram:2 GB; Bộ nhớ trong:16 GB; GPU:Mali-T400; Dung lượng pin:5000 mAh; Thẻ sim:2,SIM Thường; Hệ điều hành:Android 9.0; Xuất xứ:Trung Quốc',N'12 Tháng','TL')

Insert into SanPham values ('TL169', N'Huawei MediaPad T5 10',1, 4990000, 'TL169.png',N'Màn hình:10.1", FHD, IPS LCD, 1920 x 1200 Pixel; Camera sau:5.0 MP; Camera Selfie:2.0 MP; Ram:2 GB; Bộ nhớ trong:32 GB; GPU:Mali-T830; Dung lượng pin:5100 mAh; Thẻ sim:1,Nano SIM; Hệ điều hành:Android 8.0; Xuất xứ:Trung Quốc',N'12 Tháng','TL')
Insert into SanPham values ('TL170', N'Huawei MatePad T',1, 3190000, 'TL170.png',N'Màn hình:8.0", HD+, IPS LCD, 800 x 1280 Pixel; Camera sau:5.0 MP; Camera Selfie:2.0 MP; Ram:3 GB; Bộ nhớ trong:32 GB; CPU:MediaTek MT8768; Dung lượng pin:5100 mAh; Thẻ sim:1,Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Trung Quốc',N'12 Tháng','TL')
Insert into SanPham values ('TL171', N'Huawei MediaPad M5 Lite 64GB',5, 7990000, 'TL171.png',N'Màn hình:10.1", WUXGA, IPS TFT, 1920 x 1200 Pixel; Camera sau:8.0 MP; Camera Selfie:8.0 MP; Ram:3 GB; Bộ nhớ trong:32 GB; CPU:MediaTek MT8768; Dung lượng pin:5100 mAh; Thẻ sim:1,Nano SIM; Hệ điều hành:Android 10.0; Xuất xứ:Trung Quốc',N'12 Tháng','TL')
Insert into SanPham values ('TL172', N'Huawei MediaPad T3 10.0',1, 3890000, 'TL172.png',N'Màn hình:9.6", HD, IPS, 720 x 1280 Pixel; Camera sau:5.0 MP; Camera Selfie:2.0 MP; Ram:2 GB; Bộ nhớ trong:16 GB; GPU:Adreno 308; Dung lượng pin:4800 mAh; Thẻ sim:1,Nano SIM; Hệ điều hành:Android 7.0; Xuất xứ:Trung Quốc',N'12 Tháng','TL')

Insert into SanPham values ('PK173', N'Chuột có dây Rapoo N200 ',1, 100000, 'PK173.png',N'Độ phân giải: 1000 dpi; Kết nối:USB; Loại chuột:Có dây; Thương hiệu:Rapoo; Xuất xứ:Trung Quốc','12Tháng','PK')
Insert into SanPham values ('PK174', N'Chuột không dây Zadez M390 Đỏ',1, 200000, 'PK174.png',N'Độ phân giải: 1600 dpi; Kết nối:	Wireless; Loại chuột:Không dây; Thương hiệu:Zadez; Xuất xứ:Trung Quốc','12Tháng','PK')
Insert into SanPham values ('PK175', N'Chuột không dây HP X3000',1, 300000, 'PK175.png',N'Các phím chức năng:nút bấm; con cuộn; Độ phân giải: 1600 dpi; Kết nối:Bluetooth; Loại chuột:Không dây; Khoảng cách tối đa: lên đến 10m; Thương hiệu:HP; Xuất xứ:Trung Quốc',N'12 Tháng','PK')
Insert into SanPham values ('PK176', N'Chuột không dây quang Microsoft',1, 350000, 'PK176.png',N'Các phím chức năng:Trái,phải,con lăn; Độ phân giải: 1000 dpi; Kết nối:Wireless; Loại chuột:Không dây:; Khoảng cách tối đa: lên đến 5m; Thương hiệu:Microsoft; Xuất xứ:Trung Quốc',N'12 Tháng','PK')
Insert into SanPham values ('PK177', N'Chuột game Asus CERBERUS',1, 455000, 'PK177.png',N'Kết nối:USB; Loại chuột:Gaming; Thương hiệu:Asus; Xuất xứ:Trung Quốc','12Tháng','PK')
Insert into SanPham values ('PK178', N'Chuột game có dây Zadez GT-613M',1, 350000, 'PK178.png',N'Các phím chức năng:6 phím chức năng (có thể tùy biến bằng phần mềm); Chiều dài dây: 1.5m; Độ phân giải	1000/1750/2500/3500/4000 DPI; Kết nối:USB; Khoảng cách tối đa: 1.5m; Loại chuột:Gaming; Thương hiệu:Zadez; Xuất xứ:Trung Quốc',N'12 Tháng','PK')
Insert into SanPham values ('PK179', N'Chuột game có dây Zadez GT615M',1, 550000, 'PK179.png',N'Chiều dài dây:1,5m; Độ phân giải:1000 dpi; Kết nối:USB; Khoảng cách tối đa: 1.5m; Loại chuột:Gaming; Thương hiệu:Zadez; Xuất xứ:Trung Quốc',N'12 Tháng','PK')
Insert into SanPham values ('PK180', N'Chuột game có dây Zadez GT616M',1, 650000, 'PK180.png',N'Chiều dài dây:1,8m; Độ phân giải:1000 dpi; Kết nối:USB; Khoảng cách tối đa: 1.8m; Loại chuột:Gaming; Thương hiệu:Zadez; Xuất xứ:Trung Quốc',N'12 Tháng','PK')
Insert into SanPham values ('PK181', N'Chuột Game không dây Logitech',1, 890000, 'PK181.png',N'Chiều dài dây:1,8m; Độ phân giải:1200 dpi; Kết nối:USB; Loại chuột:Gaming; Thương hiệu:Logitech; Xuất xứ:Trung Quốc','12Tháng','PK')
Insert into SanPham values ('PK182', N'Chuột Game có dây Logitech G502 HERO High Performance',1, 1759000, 'PK182.png',N'Chiều dài dây:2,1m; Độ phân giải:1600 dpi; Kết nối:USB; Loại chuột:Gaming; Thương hiệu:Logitech; Xuất xứ:Trung Quốc',N'12 Tháng','PK')
Insert into SanPham values ('PK183', N'Chuột không dây Magic Mouse 2 White',1, 2459000, 'PK183.png',N'Kết nối:Bluetooth; Loại chuột:Không dây; Thương hiệu:Apple; Xuất xứ:Trung Quốc',N'12 Tháng','PK')


Insert into SanPham values ('PK184', N'Pin sạc dự phòng Li-ion 7500mAh ivalue MTL75002',1, 399000, 'PK184.png',N'Chất liệu:Nhựa ABS; Đèn LED trạng thái:Có; Độ bền/độ an toàn:Chống cháy nổ;Tích hợp IC bảo vệ nguồn;Lõi pin cao cấp; Dung lượng:7000mAah;Hiệu suất sử dụng:70%; Màu sắc:Đen; Nguồn ra:5V/1A, 5V/2A; Nguồn vào:5V/2A; Số cổng ra:2; Thời gian sạc:5-6 giờ cổng; Thương hiệu:i.value; Tính năng:Quản lý nguồn,Tự động cân bằng thời gian sạc và hiệu chỉnh dòng; Xuất xứ:Trung Quốc',N'12 Tháng','PK')
Insert into SanPham values ('PK185', N'Pin sạc dự phòng Li-ion 10000mAh ivalue MT-L100-015 (T-100CF) Xanh Royal',1, 499000, 'PK185.png',N'Chất liệu:Nhựa ABS; Đèn LED trạng thái:Có;  Độ bền/độ an toàn:chống cháy nổ;Tích hợp IC bảo vệ nguồn;Lõi pin cao cấp; Dung lượng:10000mAah; Hiệu suất sử dụng:70%; Màu sắc:Xanh; Nguồn ra:5V/1A, 5V/2A; Nguồn vào:5V/2A; Số cổng ra:2; Thời gian sạc:6-10 giờ cổng; Thương hiệu:i.value; Tính năng:Quản lý nguồn,Tự động cân bằng thời gian sạc và hiệu chỉnh dòng; Xuất xứ:Trung Quốc',N'12 Tháng','PK') 
Insert into SanPham values ('PK186', N'Pin sạc dự phòng Wireless Li-polymer 10000mAH UMETRAVEL PW1',1, 699000, 'PK186.png',N'Chất liệu:ABS+PC Rubber Coating; Cổng nguồn ra:USB 2.0, Type-C; Cổng vào:MicroUSB; Đèn LED trạng thái:Có;  Độ bền/độ an toàn:Chống cháy nổ, Lõi pin cao cấp, Tích hợp IC chống cháy nổ;  Dung lượng:10000mAah;Hiệu suất sử dụng:70%; Màu sắc:Đen; Nguồn ra:5V/3A - 9V/2A; Nguồn vào:MicroUSB; Thời gian sạc:6-10 giờ cổng; Thương hiệu:UmeTravel; Tính năng:Hỗ trợ sạc không dây cho các thiết bị hỗ trợ chuẩn QI, Tự động cân bằng thời gian sạc và hiệu chỉnh dòng; Xuất xứ:Trung Quốc',N'12 Tháng','PK') 
Insert into SanPham values ('PK187', N'Sạc dự phòng Veger V17 Pro 10000mAh (quick charge)',1, 700000, 'PK187.png',N'Chất liệu:Nhôm; Cổng nguồn ra:USB 2.0, Type-C; Cổng vào:MicroUSB; Đèn LED trạng thái:Có;  Độ bền/độ an toàn:Công nghệ quản lý nguồn V-power: tự ngắt khi sạc đầy, khi không sử dụng, chống đoản mạch, tự động điều chỉnh dòng; Dung lượng:10000mAah;Hiệu suất sử dụng:71%; Màu sắc:Hồng; Nguồn ra:5V/2.4A; Nguồn vào:5V/2A, 9V/2A; Số cổng ra:3 cổng; Thời gian sạc:6-10 giờ cổng; Thương hiệu:Veger; Tính năng:Tích hợp công nghệ Sạc nhanh In-Out giúp giảm ngắn thời gian sạc thiết bị một cách nhanh chóng. - Tương thích sạc cùng lúc 2 thiết bị khác nhau. - 2 cổng sạc vào tiện lợi thích hợp với Androi và Ios - Tự tắt nguồn sau 10s không sử dụng; Xuất xứ:Trung Quốc',N'1 Tháng','PK') 
Insert into SanPham values ('PK188', N'Pin sạc dự phòng Li-ion 20000mAh ivalue MTL200001 Trắng',1, 889000, 'PK188.png',N'Chất liệu:Nhựa ABS; Đèn LED trạng thái:Có; Độ bền/độ an toàn:Chống cháy nổ;Tích hợp IC bảo vệ nguồn;Lõi pin cao cấp; Dung lượng:10000mAah; Hiệu suất sử dụng:70%; Màu sắc:Trắng; Nguồn ra:5V/1A, 5V/2A; Nguồn vào:5V/2A; Số cổng ra:2 cổng; Thời gian sạc:8-11 giờ cổng; Thương hiệu:i.value; Tính năng:Tích hợp công nghệ Sạc nhanh In-Out giúp giảm ngắn thời gian sạc thiết bị một cách nhanh chóng. - Tương thích sạc cùng lúc 2 thiết bị khác nhau. - 2 cổng sạc vào tiện lợi thích hợp với Androi và Ios - Tự tắt nguồn sau 10s không sử dụng	Quản lý nguồn, Tự động cân bằng thời gian sạc và hiệu chỉnh dòng; Xuất xứ:Trung Quốc',N'12 Tháng','PK') 
Insert into SanPham values ('PK189', N'Pin sạc dự phòng Li-ion 20000mAh ivalue MTL200001 Trắng',1, 1000000, 'PK189.png',N'Chất liệu:Nhựa; Cổng nguồn ra:Type-C, USB 2.0; Cổng vào:Type-C; Đèn LED trạng thái:Có; Độ bền/độ an toàn:	thiết kế nhựa chịu được va đập nhẹ; Dung lượng:10000mAah;Hiệu suất sử dụng:70%; Màu sắc:Đen; Nguồn ra:	5V - 3A, 9V - 2A, 15V - 1.2 A, 5V - 2.4A; Nguồn vào:5V - 3A, 9V - 2A, 15V - 1.2 A; Số cổng ra:2 cổng; Thời gian sạc:4-5 giờ cổng; Thương hiệu:Anker; Tính năng:sạc chuẩn USB-C, có PD, sạc chuẩn USB-A; Xuất xứ:Trung Quốc',N'12 Tháng','PK') 
Insert into SanPham values ('PK190', N'Pin sạc dự phòng Li-ion 26800mAh Anker PowerCore+ A1375 Đen',1, 2400000, 'PK190.png',N'Chất liệu:Nhôm; Cổng nguồn ra:USB 2.0, Type-C; Cổng vào:Type-C; Đèn LED trạng thái:Có; Độ bền/độ an toàn:	Thiết kế hạn chế hư hỏng khi va đập - theo tiêu chuẩn nhà sản xuất; Dung lượng:26800mAah;Hiệu suất sử dụng:75%; Màu sắc:Đen; Nguồn ra:5V-3A, 5V=3A, 9V=3A, 15V=2A, 20=1,25A; Nguồn vào:	5V=3A, 9V=3A; Số cổng ra:3 cổng; Thời gian sạc:4-5 giờ cổng; Thương hiệu:Anker; Tính năng:sạc nhanh power delivery; Xuất xứ:Trung Quốc',N'12 Tháng','PK') 
Insert into SanPham values ('PK191', N'Pin sạc dự phòng Li-ion 10000mAh ivalue MT-L100-014 (RT-130) Trắng',1, 499000, 'PK191.png',N'Chất liệu:Nhựa ABS; Đèn LED trạng thái:Có; Độ bền/độ an toàn:Chống cháy nổ;Tích hợp IC bảo vệ nguồn;Lõi pin cao cấp; Dung lượng:10000mAah; Hiệu suất sử dụng:70%; Màu sắc:Trắng; Nguồn ra:5V/2A, 5V/2A; Nguồn vào:5V/2A; Số cổng ra:2 cổng; Thời gian sạc:6-10 giờ cổng; Thương hiệu:i.value; Tính năng:Quản lý nguồn, Tự động cân bằng thời gian sạc và hiệu chỉnh dòng; Xuất xứ:Trung Quốc',N'12 Tháng','PK') 
Insert into SanPham values ('PK192', N'Pin sạc dự phòng Li- polymer 10000mAh ivalue MTP100005 Blue',1, 599000, 'PK192.png',N'Chất liệu:Nhựa ABS; Đèn LED trạng thái:Có; Độ bền/độ an toàn:Chống cháy nổ;Tích hợp IC bảo vệ nguồn; Lõi pin cao cấp; Dung lượng:10000mAah; Hiệu suất sử dụng:70%; Màu sắc:Xanh; Nguồn ra:5V/1A, 5V/2A; Nguồn vào:5V/2A; Số cổng ra:2 cổng; Thời gian sạc:6-10 giờ cổng; Thương hiệu:i.value; Tính năng:Quản lý nguồn, Tự động cân bằng thời gian sạc và hiệu chỉnh dòng; Xuất xứ:Trung Quốc',N'12 Tháng','PK') 


Insert into SanPham values ('PK193', N'Bao da iPhone 12 Pro Max Leather Sleeve with MagSafe',1, 2990000, 'PK193.png', N'Chất lượng: Da; Dòng máy tương thích 1:iPhone 12 Pro Max; Màu sắc:Baltic Blue; Nguồn gốc: Trung Quốc; Phụ kiện đi kèm: Dây đeo; Thiết kế: Bao da lồng, Thương hiệu: Apple; Tính năng:Chống trầy xước, Tương thích với sạc không dây MagSafe ',N'12 tháng','PK')
Insert into SanPham values ('PK194', N'Ốp lưng iPhone 12 & 12 Pro Clear Case with MagSafe',1, 1590000, 'PK194.png', N'Chất lượng: Nhựa; Dòng máy tương thích 1:iPhone 12; Dòng máy tương thích 2: iPhone 12 Pro; Loại: Bao da; Màu sắc:Clear; Nguồn gốc: Trung Quốc; Thương hiệu: Apple; Tính năng:Chống trầy xước, Tương thích với sạc không dây MagSafe',N'12 tháng','PK')
Insert into SanPham values ('PK195', N'Ốp lưng iPhone 12 Pro Max Silicone Case with MagSafe',1, 1590000, 'PK195.png', N'Chất lượng: Silion; Dòng máy tương thích 1:iPhone 12; Dòng máy tương thích 2: iPhone 12 Pro Max; Nguồn gốc: Trung Quốc; Thương hiệu: Apple; Tính năng:Chống trầy xước, Tương thích với sạc không dây MagSafe',N'12 tháng','PK')
Insert into SanPham values ('PK196', N'Ốp lưng iPhone 12 Pro Max Leather Case with MagSafe',1, 1890000, 'PK196.png', N'Dòng máy tương thích Pro Max; Mùa sắc: Black; Nguồn gốc: Trung Quốc; Thương hiệu: Apple; Tính năng:Chống trầy xước, Tương thích với sạc không dây MagSafe ',N'12 tháng','PK')
Insert into SanPham values ('PK197', N'Ốp lưng iPhone 12 Mini Nhựa dẻo Naked TPU Meetu',1, 69000, 'PK197.png', N'Chất lượng: Silion; Dòng máy tương thích :iPhone 12 mini; Màu sắc:Baltic Nude; Nguồn gốc: Trung Quốc; Thiết kế: Đơn giản, Thương hiệu: Meetu; Tính năng: Chống sốc',N'12 tháng','PK')
Insert into SanPham values ('PK198', N'Ốp lưng UAG cho iPhone 12 / 12 Pro Plasma',1, 950000, 'PK198.png', N'Chất lượng: Nhựa; Dòng máy tương thích 1:iPhone 12 Pro; Dòng máy tương thích 2: iPhone 12; Màu sắc:Ice; Nguồn gốc: Trung Quốc; Thiết kế: Thời trang độc đáo, Thương hiệu: UAG; Tính năng: Chống sốc',N'12 tháng','PK')
Insert into SanPham values ('PK199', N'Ốp lưng UAG cho iPhone 12 / 12 Pro Plasma',1, 950000, 'PK199.png', N'Chất lượng: Nhựa; Dòng máy tương thích 1:iPhone 12 Pro; Dòng máy tương thích 2: iPhone 12; Màu sắc:Ice; Nguồn gốc: Trung Quốc; Thiết kế: Thời trang độc đáo, Thương hiệu: UAG; Tính năng: Chống sốc',N'12 tháng','PK')
Insert into SanPham values ('PK200', N'Ốp lưng UAG cho iPhone 12 Pro Max Civilian',1, 1150000, 'PK200.png', N'Chất lượng: Nhựa; Dòng máy tương thích 1:iPhone 12 Pro; Dòng máy tương thích 2: iPhone 12; Màu sắc:Midnigh Camo; Nguồn gốc: Trung Quốc; Thiết kế: Thời trang độc đáo, Thương hiệu: UAG; Tính năng: Chống sốc',N'12 Tháng','PK')
Insert into SanPham values ('PK201', N'Ốp lưng iPhone 12 Pro Max Giả da Hotforming PU Case Meetu',1, 399000, 'PK201.png', N'Chất lượng: Da; Dòng máy tương thích: iPhone 12 Pro Max; Màu sắc: Nâu; Nguồn gốc:Trung Quốc; Thiết kế: Thời trang, Thương hiệu: Meetu; Tính năng: Chống sốc',N'12 tháng','PK')
Insert into SanPham values ('PK202', N'Ví iPhone Leather Wallet with MagSafe',1, 159000, 'PK202.png', N'Màu sắc: Baltic Blue, Thương hiệu: Apple','12 tháng','PK')
Insert into SanPham values ('PK203', N'Vỏ iPad 10.2 & Air 3 10.5 inchs Smart Cover Black',1, 1590000, 'PK203.png', N'Chất lượng: Da; Dòng máy tương thích 1:iPad 10.2 2019; Dòng máy tương thích 2:iPad Air 3; Màu sắc:Black; Nguồn gốc: Trung Quốc; Thiết kế: Thời trang độc đáo, Thương hiệu: Apple; Tính năng: Chống trầy xước, Smart Cover',N'12 Tháng','PK')
Insert into SanPham values ('PK204', N'Bao da kèm bàn phím Logitech Slim Folio Pro cho iPad Pro 12.9',1, 4000000, 'PK204.png', N'Chất lượng: Nhựa; Dòng máy tương thích:iPad Pro 12.9 2018; Màu sắc:Black; Nguồn gốc: Trung Quốc; Thiết kế: Thiết kế vừa vặn ôm sát thân máy, chống trầy xước thân máy tối ưu. Ốp lưng có nhiều mẫu mã đẹp, trẻ trung, cá tính, Thương hiệu: Logitech; Tính năng: Chống trầy xước, Có đèn bàn phím, Có phím tắt riêng cho iOS',N'12 Tháng','PK')
Insert into SanPham values ('PK205', N'Ốp lưng iPhone 6 Plus/6S Plus Nhựa dẻo TPU UV Printing Meetu MT-2020003',1, 33000, 'PK205.png', N'Chất lượng: Nhựa; Dòng máy tương thích 1:iPhone 6 Plus; Dòng máy tương thích 2:iPhone 6s Plus; Màu sắc:MT-2020003; Nguồn gốc: Trung Quốc; Thiết kế: Thiết kế vừa vặn ôm sát thân máy, chống trầy xước thân máy tối ưu. Ốp lưng có nhiều mẫu mã đẹp, trẻ trung, cá tính, Thương hiệu: Meetu; Tính năng: Chống trầy xước',N'12 Tháng','PK')
Insert into SanPham values ('PK206', N'Ốp lưng iPhone 11 Nhựa dẻo TPU Silicone Feel Case Meetu MT-2020001',1, 66000, 'PK206.png', N'Chất lượng: Silicon; Dòng máy tương thíchiPhone 11; Màu sắc:MT-2020003; Nguồn gốc: Trung Quốc; Thiết kế: Thiết kế vừa vặn ôm sát thân máy, chống trầy xước thân máy tối ưu. Ốp lưng có nhiều mẫu mã đẹp, trẻ trung, cá tính, Thương hiệu: Meetu; Tính năng: Chống trầy xước',N'12 Tháng','PK')
Insert into SanPham values ('PK207', N'Ốp lưng iPhone 7 Plus/8 Plus Nhựa dẻo TPU UV Printing Meetu MT-2020005',1, 66000, 'PK207.png', N'Chất lượng: Silicon; Dòng máy tương thích 1: iPhone 7 Plus; Dòng máy tương thích 1: iPhone 8 Plus; Màu sắc:	MT-2020005; Nguồn gốc: Trung Quốc; Thiết kế: Thời trang, Thương hiệu: Meetu; Tính năng: Chống trầy xước',N'12 Tháng','PK')

Insert into SanPham values ('PK208', N'Bàn phím không dây iPad Pro 11 Magic Keyboard',1, 5490000, 'PK208.png', N'Cổng kết nối: USB-C;Hệ điều hành tương thích: iPadOS; Loại bàn phím: Không dây;Loại kết nối: Smart Connector; Màu sắc:Space Grey; Nguồn gốc: Trung Quốc; Thương hiệu: Apple; Tính năng: Bàn phím tự động kết nối với iPad qua cổng Smart Connector., Bổ sung trackpad hỗ trợ chuột, bàn phím có đèn nền. Bản lề dựng iPad nhiều góc độ, có cổng USB-C để sạc iPad., Tương thích với iPad Pro 11 inch 2018 & 2020. Hỗ trợ kiểu gõ TELEX, không hỗ trợ kiểu gõ VNI',N'12 Tháng','PK')
Insert into SanPham values ('PK209', N'Bàn phím không dây iPad Pro 12.9 2020 Smart Keyboard Folio',1, 5990000, 'PK209.png', N'Hệ điều hành tương thích: iPadOS; Loại bàn phím: Không dây;Loại kết nối: Smart Connector; Màu sắc:Black; Nguồn gốc: Trung Quốc; Thương hiệu: Apple; Tính năng: Bàn phím tự động kết nối với iPad qua cổng Smart Connector., Bổ sung trackpad hỗ trợ chuột, bàn phím có đèn nền. Bản lề dựng iPad nhiều góc độ, có cổng USB-C để sạc iPad., Tương thích với iPad Pro 11 inch 2018 & 2020. Hỗ trợ kiểu gõ TELEX, không hỗ trợ kiểu gõ VNI',N'12 Tháng','PK')
Insert into SanPham values ('PK210', N'Bàn phím Kingston HyperX Alloy Origins Mechanical Gaming Keyboard - HyperX Red Switch_HX-KB6RDX-US',1, 27900000, 'PK210.png', N'; Loại bàn phím: Phím cơ HyperX Switch; Màu sắc:Đen Led RGB ; Nguồn gốc: Trung Quốc; Thiết kế: Apple, Thương hiệu: HYPERX; Xuất xứ: Trung Quốc',N'12 Tháng','PK')
Insert into SanPham values ('PK211', N'Bàn phím + chuột không dây Microsoft 850',1, 750000, 'PK211.png', N'Thương hiệu: Microsoft; Xuất xứ: Trung Quôc ',N'12 Tháng','PK')
Insert into SanPham values ('PK212', N'Bàn phím Prolink PKCM-2005',1, 200000, 'PK212.png', N'Chất liệu: Nhựa; Cổng kết nối: USB; Hệ điều hàng tương thích: Windows 98/2000/ME/XP/Vista/7/8/10; Thương hiệu: Prolink; Xuất xứ:Trung quốc',N'12 Tháng','PK')
Insert into SanPham values ('PK213', N'Bàn phím Bluetooth Logitech K380',1, 750000, 'PK213.png', N'Thương hiệu: Logitech; Xuất xứ:Trung quốc',N' 12 Tháng','PK')
Insert into SanPham values ('PK214', N'Bàn phím không dây Magic Keyboard with Numeric Keypad',1, 3999000, 'PK214.png', N'Cổng kết nối: Lighting; Hệ điều hành: MacOS, iOS, iPadOS, Windows; Thương hiệu: Apple; Tính năng: Bàn phím số, pin sạc tích hợp, Thời lượng pin lên đến 1 tháng, Bàn phím gõ chính xác và thoải mái; Xuất xứ:Trung quốc',N' 12 Tháng','PK')
Insert into SanPham values ('PK215', N'Bàn phím Game Zadez G-852K ',1, 600000, 'PK215.png', N'Chất liêu: Nhựa ABS; Cổng kết nối: USB; Hệ điều hành: MacOS, iOS, iPadOS, Windows; Thương hiệu: Zadez; Màu sắc: Đen; Tính năng: Bàn phím chơi game chuyên dụng, switch Membrance (bán cơ) bền bỉ có khả năng kháng nước, tích hợp đèn nền LED. 11 phím multimedia, 26 phím N-Rollover, in laser, chất liệu ABS, nút khóa WIN.Hỗ trợ Macro Editor qua phần mềm, 4 phím nóng tổ hợp marco; Zadez; Xuất xứ:Trung quốc',N'12 Tháng','PK')
Insert into SanPham values ('PK216', N'Bàn phím Zadez có dây G-851K',1, 290000, 'PK216.png', N'Chất liêu: Nhựa; Cổng kết nối: USB; Hệ điều hành: MacOS, iOS, iPadOS, Windows; Thương hiệu: Zadez; Màu sắc: Đen; Tính năng: Thiết kế Ergonomic, nhập liệu, nhập liệu; Xuất xứ:Trung quốc',N'12 Tháng','PK')

Insert into SanPham values ('PK217', N'Tai nghe AirPods Max',1, 13990000, 'PK217.png', N'Chất liêu: Khung kim loại, đệm vải; Dòng máy tương thích: iPhone, iPad, iPod, Apple Watch, Apple TV, Mac; Hệ điều hành tương thích: iOS, iPadOS, watchOS, tvOS, macOS mới nhất; Thương hiệu: Apple; Tính năng: Thiết kế sang trọng, âm thanh đỉnh cao., Trang bị tính năng chống ồn chủ động (NFC), điều chỉnh âm thanh (Adaptive EQ), chế độ xuyên âm (Transparency Mode) và âm thanh vòm (Spatial Audio)., Điều khiển thông minh với nút Digital Crown; Xuất xứ:Trung quốc',N'12 Tháng','PK')
Insert into SanPham values ('PK218', N'Tai nghe choàng đầu có mic Gaming Logitech G331',1, 1699000, 'PK218.png', N'Chất liêu: Nhựa; Dòng máy tương thích: iPhone, iPad, iPod, Apple Watch, Apple TV, Màu sắc: Đen; Mac; Hệ điều hành tương thích: Windows® 10, Windows 8.1, Windows 7, Mac, Nintendo Switch, PlayStation 4, Xbox One; Thương hiệu: Apple; Tính năng: Nghe âm thanh, Đàm thoại, Đa nền tảng; Xuất xứ:Trung quốc',N'12 Tháng','PK')
Insert into SanPham values ('PK219', N'Tai nghe Samsung Galaxy Buds Live',1, 3290000, 'PK219.png', N'Chất liêu: Nhựa; Dòng máy tương thích: iPhone, iPad, iPod, Apple Watch, Apple TV,  Màu sắc: Đồng Ánh Kim; Mac; Thương hiệu: Samsung',N'12 Tháng','PK')
Insert into SanPham values ('PK220', N'Tai nghe Sony WI-XB400/BZ',1, 1390000, 'PK220.png', N'Chất liêu: Nhựa; Dòng máy tương thích: Tất cả điện thoại, máy tính bảng, laptop, có tích hợp bluetooth, Màu sắc: Đen; Mac; Thương hiệu: Sony; Tính năng: Tai nghe nhẹ với EXTRA BASS™ cho âm thanh mạnh mẽ, sâu lắng, Đàm thoại, Xem phim, Sạc nhanh 10 phút, dùng 60 phút; Xuất xứ: Việt Nam',N'12 Tháng','PK')
Insert into SanPham values ('PK221', N'Tai nghe dây nhét tai JBL T110',1, 390000, 'PK221.png', N'Chất liêu: Nhựa; Màu sắc: Đen; Mac; Thương hiệu: JBL; Tính năng: Nghe nhạc, Đàm thoại, Xem phim; Xuất xứ: Trung Quốc',N'12 Tháng','PK')
Insert into SanPham values ('PK222', N'Tai nghe bluetooth nhét tai i.value BT008 ',1, 450000, 'PK222.png', N'Chất liêu:Nhựa, kim loại; Dòng máy tương thích: Tất cả điện thoại, máy tính bảng, laptop, có tích hợp bluetooth, Màu sắc: Đỏ đen; Mac; Thương hiệu: i.value; Tính năng: Nghe nhạc, Đàm thoại, Xem phim; Xuất xứ: Trung Quốc',N'12 Tháng','PK')
Insert into SanPham values ('PK223', N'Tai nghe bluetooth choàng đầu có mic i.value A8 ',1, 550000, 'PK223.png', N'Chất liêu:Nhựa,Nhựa+Kim loại; Dòng máy tương thích: Máy & điên thoại vi tính có kết nối bluetooth tương thích, máy tính bảng, laptop, có tích hợp bluetooth, Màu sắc: Đen; Mac; Thương hiệu: i.value; Tính năng: Nghe nhạc, Đàm thoại, Xem phim; Xuất xứ: Trung Quốc',N'12 Tháng','PK')

Insert into SanPham values ('S224', N'Sim Mobi C120', 10, 270000, 'Sim224.png',N'Data: 2GB data/ ngày. Hết 2GB ngừng truy cập.Có thể mua thêm D10(10.000đ/ 1.5GB/ngày) ,soạn Tengoicuoc gửi 999( 200đ/SMS), Phút gọi: Miễn phí gọi nội mạng < 20 phút. Gọi liên mạng/tháng: 50 phút, Thời gian KM: 12 tháng (360 ngày) tính từ ngày kích hoạt, Chu kỳ/tháng: 30 ngày tính từ ngày đăng ký/ gia hạn thành công, Phí gọi: Tháng đầu: MIỄN PHÍ, tháng thứ 2-12: 120.000đ/ tháng, Cú pháp(200đ/sms): Đăng ký: DK MOBIC120 gửi 999, Kiểm tra data: KT ALL gửi 999, Hủy KM: HUY MOBIC120 gửi 999', null,'S')
Insert into SanPham values ('S225', N'Sim Mobi Big 7ON', 5, 220000, 'Sim225.png',N'Data: 6GB/tháng/6 tháng đầu. Hết 6GB dừng truy cập. 3GB/tháng/6 tháng sau. Hết 3GB dừng truy cập. Sử dụng hết data, KH có thể mua thêm các gói cước : MAX15 (15.000đ/ 500MB), MAX20 (20.000đ/ 1GB), MAX35 (35.000đ/ 2GB) ,soạn Tengoicuoc gửi 999( 200đ/SMS) , Phút gọi KM: Miễn phí gọi nội mạng < 10 phút. Tối đa 1000 phút/tháng. Gọi liên mạng/tháng: 20 phút, Thời gian KM: 12 tháng tính từ ngày đăng ký thành công lần đầu, Chu kỳ/tháng: 30 ngày tính từ ngày đăng ký/ gia hạn thành công, Phí gọi: Tháng đầu: MIỄN PHÍ, tháng thứ 2-12: 70.000đ/ tháng, Cú pháp(miễn phí): Đăng ký:u DK BIG70N gửi 789, Gia hạn: GH BIG70N gửi 789, Kiểm tra ưu đãi: KT BIG70N gửi 789, Hủy: HUY BIG70N gửi 789',null,'S')

Select * from SanPham
--delete from SanPham

Insert into HoaDon values ('HD01', 'NV08', 'KH01')
Insert into HoaDon values ('HD02', 'NV08', 'KH02')
Insert into HoaDon values ('HD03', 'NV07', 'KH03')
Insert into HoaDon values ('HD04', 'NV07', 'KH04')
Insert into HoaDon values ('HD05', 'NV07', 'KH05')
Insert into HoaDon values ('HD06', 'NV07', 'KH06')
Insert into HoaDon values ('HD07', 'NV08', 'KH07')
Insert into HoaDon values ('HD08', 'NV07', 'KH08')
Insert into HoaDon values ('HD09', 'NV08', 'KH09')
Insert into HoaDon values ('HD10', 'NV08', 'KH10')
Insert into HoaDon values ('HD11', 'NV07', 'KH11')
Insert into HoaDon values ('HD12', 'NV08', 'KH13')
Insert into HoaDon values ('HD13', 'NV07', 'KH14')
Insert into HoaDon values ('HD14', 'NV08', 'KH15')
Insert into HoaDon values ('HD15', 'NV08', 'KH15')
Insert into HoaDon values ('HD16', 'NV07', 'KH16')
Insert into HoaDon values ('HD17', 'NV08', 'KH17')
Insert into HoaDon values ('HD18', 'NV08', 'KH18')
Insert into HoaDon values ('HD19', 'NV07', 'KH19')
Insert into HoaDon values ('HD20', 'NV08', 'KH20')
Insert into HoaDon values ('HD21', 'NV07', 'KH20')
Insert into HoaDon values ('HD22', 'NV07', 'KH11')
Insert into HoaDon values ('HD23', 'NV07', 'KH13')
Insert into HoaDon values ('HD24', 'NV08', 'KH09')
Insert into HoaDon values ('HD25', 'NV08', 'KH16')
Insert into HoaDon values ('HD26', 'NV08', 'KH18')
Insert into HoaDon values ('HD27', 'NV08', 'KH01')
Insert into HoaDon values ('HD28', 'NV08', 'KH13')
Insert into HoaDon values ('HD29', 'NV08', 'KH11')
Insert into HoaDon values ('HD30', 'NV08', 'KH10')
Insert into HoaDon values ('HD31', 'NV07', 'KH20')
Insert into HoaDon values ('HD32', 'NV07', 'KH11')
Insert into HoaDon values ('HD33', 'NV07', 'KH13')
Insert into HoaDon values ('HD34', 'NV08', 'KH09')
Insert into HoaDon values ('HD35', 'NV08', 'KH14')
Insert into HoaDon values ('HD36', 'NV08', 'KH08')
Insert into HoaDon values ('HD37', 'NV08', 'KH05')
Insert into HoaDon values ('HD38', 'NV07', 'KH02')
Insert into HoaDon values ('HD39', 'NV07', 'KH03')
Insert into HoaDon values ('HD40', 'NV07', 'KH01')
Insert into HoaDon values ('HD41', 'NV08', 'KH09')
Insert into HoaDon values ('HD42', 'NV08', 'KH14')
Insert into HoaDon values ('HD43', 'NV08', 'KH08')
Insert into HoaDon values ('HD44', 'NV08', 'KH05')
Insert into HoaDon values ('HD45', 'NV07', 'KH02')
Insert into HoaDon values ('HD46', 'NV07', 'KH03')
Insert into HoaDon values ('HD47', 'NV07', 'KH01')
Select * from HoaDon

Set DateFormat DMY
Insert into ChiTietHoaDon values ('CTHD001','HD01', 'DT001', 5, 10995000, '12-12-2020')
Insert into ChiTietHoaDon values ('CTHD002','HD02', 'DT002', 1, 24990000, '10-10-2020')
Insert into ChiTietHoaDon values ('CTHD003','HD03', 'DT003', 1, 30990000, '01-09-2020')
Insert into ChiTietHoaDon values ('CTHD004','HD04', 'DT004', 1, 33990000, '11-11-2020')
Insert into ChiTietHoaDon values ('CTHD005','HD05', 'DT005', 1, 17990000, '09-12-2020')

Insert into ChiTietHoaDon values ('CTHD006','HD06', 'DT011', 8, 400000000, '08-11-2020')
Insert into ChiTietHoaDon values ('CTHD007','HD07', 'DT012', 1, 29000000, '30-01-2020')
Insert into ChiTietHoaDon values ('CTHD008','HD08', 'DT013', 7, 23990000, '12-12-2020')
Insert into ChiTietHoaDon values ('CTHD009','HD09', 'DT014', 1, 21990000, '05-10-2020')
Insert into ChiTietHoaDon values ('CTHD010','HD10', 'DT015', 1, 12990000, '29-10-2020')

Insert into ChiTietHoaDon values ('CTHD011','HD11', 'DT025', 8, 400000000, '12-01-2020')
Insert into ChiTietHoaDon values ('CTHD012','HD12', 'DT026', 5, 59950000,'28-02-2020')
Insert into ChiTietHoaDon values ('CTHD013','HD13', 'DT027', 1, 4990000, '11-11-2020')
Insert into ChiTietHoaDon values ('CTHD014','HD14', 'DT028', 1, 5690000, '22-12-2020')
Insert into ChiTietHoaDon values ('CTHD015','HD15', 'DT029', 1, 6190000, '30-12-2020')

Insert into ChiTietHoaDon values ('CTHD016','HD16', 'DT033', 1, 7490000, '11-11-2020')
Insert into ChiTietHoaDon values ('CTHD017','HD17', 'DT034', 1, 4590000, '15-09-2020')
Insert into ChiTietHoaDon values ('CTHD018','HD18', 'DT035', 1, 3290000, '09-06-2020')
Insert into ChiTietHoaDon values ('CTHD019','HD19', 'DT036', 1, 2490000, '01-04-2020')
Insert into ChiTietHoaDon values ('CTHD020','HD20', 'DT037', 10, 15900000, '06-01-2020')

Insert into ChiTietHoaDon values ('CTHD021','HD21', 'DT038', 1, 12990000, '11-11-2020')
Insert into ChiTietHoaDon values ('CTHD022','HD22', 'DT039', 1, 6990000, '15-09-2020')
Insert into ChiTietHoaDon values ('CTHD023','HD23', 'DT040', 1, 6990000, '09-06-2020')
Insert into ChiTietHoaDon values ('CTHD024','HD24', 'DT041', 1, 4490000, '01-04-2020')
Insert into ChiTietHoaDon values ('CTHD025','HD25', 'DT042', 8, 28720000, '06-01-2020')

Insert into ChiTietHoaDon values ('CTHD026','HD26', 'DT045', 1, 6290000, '12-12-2020')
Insert into ChiTietHoaDon values ('CTHD027','HD27', 'DT046', 1, 5490000, '10-10-2020')
Insert into ChiTietHoaDon values ('CTHD028','HD28', 'DT047', 1, 4190000, '01-09-2020')
Insert into ChiTietHoaDon values ('CTHD029','HD29', 'DT048', 1, 3690000, '11-11-2020')
Insert into ChiTietHoaDon values ('CTHD030','HD30', 'DT049', 1, 2990000, '09-12-2020')

Insert into ChiTietHoaDon values ('CTHD031','HD31', 'DT050', 1, 8190000, '11-11-2020')
Insert into ChiTietHoaDon values ('CTHD032','HD32', 'DT051', 1, 7990000, '15-09-2020')
Insert into ChiTietHoaDon values ('CTHD033','HD33', 'DT052', 1, 6290000, '09-06-2020')
Insert into ChiTietHoaDon values ('CTHD034','HD34', 'DT053', 1, 4490000, '01-04-2020')
Insert into ChiTietHoaDon values ('CTHD035','HD35', 'DT054', 8, 31920000, '06-01-2020')

Insert into ChiTietHoaDon values ('CTHD036','HD36', 'DT057', 1, 11990000, '12-12-2020')
Insert into ChiTietHoaDon values ('CTHD037','HD37', 'DT058', 1, 2490000, '10-10-2020')
Insert into ChiTietHoaDon values ('CTHD038','HD38', 'DT059', 1, 1790000, '01-09-2020')
Insert into ChiTietHoaDon values ('CTHD039','HD39', 'DT060', 1, 1250000, '11-01-2020')
Insert into ChiTietHoaDon values ('CTHD040','HD40', 'DT061', 1, 749000, '09-02-2020')

Insert into ChiTietHoaDon values ('CTHD041','HD37', 'DT062', 1, 8990000, '12-12-2020')
Insert into ChiTietHoaDon values ('CTHD042','HD38', 'DT063', 1, 6990000, '10-10-2020')
Insert into ChiTietHoaDon values ('CTHD043','HD39', 'DT064', 1, 3340000, '01-09-2020')

Insert into ChiTietHoaDon values ('CTHD044','HD40', 'DT071', 1, 69990000, '12-12-2020')
Insert into ChiTietHoaDon values ('CTHD045','HD41', 'DT072', 1, 41490000, '10-10-2020')
Insert into ChiTietHoaDon values ('CTHD046','HD42', 'DT073', 7, 244930000, '01-09-2020')
Insert into ChiTietHoaDon values ('CTHD047','HD43', 'DT074', 5, 174950000, '11-01-2020')
Insert into ChiTietHoaDon values ('CTHD048','HD44', 'DT075', 1, 28990000, '09-02-2020')
Select * from ChiTietHoaDon
--delete from ChiTietHoaDon

Insert into NhaCungCap values ('NCC01', N'SamSung',N'Hà Nội', 0796342450, 'samsung@gmail.com')
Insert into NhaCungCap values ('NCC02', N'Xiaomi',N'Quận 3', 0861232450, 'Xiaomi@gmail.com')
Insert into NhaCungCap values ('NCC03', N'Oppo',N'Quận 12', 0332655311, 'Oppo@gmail.com')
Insert into NhaCungCap values ('NCC04', N'Huwaei',N'Quân bình thạnh', 0381234967, 'huwai@gmail.com')
Insert into NhaCungCap values ('NCC05', N'Apple',N'Quận 1', 0816342450, 'apple@gmail.com')
Insert into NhaCungCap values ('NCC06', N'Nokia',N'Quận 1', 0916342451, 'nokia@gmail.com')
Select * from NhaCungCap

Set DateForMat DMY
Insert into KhuyenMai values ('KM01','DT001', '25-01-2020', '26-01-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM02','DT002', '01-01-2020', '02-02-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM03','DT003', '25-01-2020', '26-01-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM04','DT004', '30-04-2020', '30-05-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM05','DT005', '01-05-2020', '01-06-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM06','DT011', '14-02-2020', '14-03-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM07','DT012', '08-09-2020', '08-10-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM08','DT013', '25-01-2020', '26-01-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM09','DT014', '01-01-2020', '02-02-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM10','DT015', '01-05-2020', '01-06-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM11','DT026', '25-01-2020', '26-01-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM12','DT027', '01-01-2020', '02-02-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM13','DT028', '14-02-2020', '14-03-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM14','DT029', '08-09-2020', '08-10-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM15','DT030', '08-09-2020', '08-10-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM16','DT032', '01-01-2020', '02-02-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM17','DT033', '25-01-2020', '26-01-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM18','DT034', '01-05-2020', '01-06-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM19','DT035', '01-01-2020', '02-02-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM20','DT036', '08-09-2020', '08-10-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM21','DT040', '08-09-2020', '08-10-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM22','DT041', '01-01-2020', '02-02-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM23','DT042', '01-05-2020', '01-06-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM24','DT043', '25-01-2020', '26-01-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM25','DT044', '25-01-2020', '26-01-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM26','DT045', '01-01-2020', '02-02-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM27','DT046', '08-09-2020', '08-10-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM28','DT047', '25-01-2020', '26-01-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM29','DT048', '01-05-2020', '01-06-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM30','DT049', '14-02-2020', '14-03-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM31','DT053', '01-01-2020', '02-02-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM32','DT054', '08-09-2020', '08-10-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM33','DT055', '01-01-2020', '02-02-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM34','DT056', '01-01-2020', '02-02-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM35','DT058', '25-01-2020', '26-01-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM36','DT059', '08-09-2020', '08-10-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM37','DT062', '01-01-2020', '02-02-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM38','DT063', '08-09-2020', '08-10-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM39','DT064', '14-02-2020', '14-03-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM40','DT065', '25-01-2020', '26-01-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM41','DT066', '01-01-2020', '02-02-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM42','DT067', '25-01-2020', '26-01-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM43','DT070', '01-01-2020', '02-02-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM44','DT024', '14-02-2020', '14-03-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM45','DT028', '25-01-2020', '26-01-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM46','LT071', '01-01-2020', '02-02-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM47','LT074', '25-01-2020', '26-01-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM48','LT078', '14-02-2020', '14-03-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM49','LT080', '08-09-2020', '08-10-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM50','LT081', '25-01-2020', '26-01-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM51','LT082', '25-01-2020', '26-01-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM52','LT088', '25-01-2020', '26-01-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM53','LT089', '08-09-2020', '08-10-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM54','LT090', '25-01-2020', '26-01-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM55','LT101', '08-09-2020', '08-10-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM56','LT102', '25-01-2020', '26-01-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM57','LT103', '01-01-2020', '02-02-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM58','LT112', '08-09-2020', '08-10-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM59','LT113', '25-01-2020', '26-01-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM60','LT114', '08-09-2020', '08-10-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM61','LT118', '25-01-2020', '26-01-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM62','LT119', '01-01-2020', '01-02-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM63','LT120', '08-09-2020', '08-10-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM64','LT125', '08-09-2020', '08-10-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM65','LT126', '25-01-2020', '26-01-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM66','LT127', '25-01-2020', '26-01-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM67','DH132', '01-01-2020', '02-02-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM68','DH144', '08-09-2020', '08-10-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM69','TL153', '25-01-2020', '26-01-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM70','LT095', '08-09-2020', '08-10-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM71','LT096', '01-01-2020', '02-02-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM72','LT100', '08-09-2020', '08-10-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM73','DH130', '08-09-2020', '08-10-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM74','DH131', '25-01-2020', '26-01-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM75','DH132', '25-01-2020', '26-01-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM76','DH133', '08-09-2020', '08-10-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM77','DH134', '25-01-2020', '26-01-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM78','DH135', '08-09-2020', '08-10-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM79','DH128', '08-09-2020', '08-10-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM80','DH129', '25-01-2020', '26-02-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM81','DH142', '25-01-2020', '26-02-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM82','DH149', '08-09-2020', '08-10-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM83','DH150', '08-09-2020', '08-10-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM84','DH151', '08-09-2020', '08-10-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM85','TL152', '08-09-2020', '08-10-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM86','TL153', '08-09-2020', '08-10-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM87','TL155', '25-01-2020', '26-01-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM88','TL163', '08-09-2020', '08-10-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM89','TL164', '25-01-2020', '26-01-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM90','TL165', '30-04-2020', '30-05-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM91','TL166', '08-09-2020', '08-10-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM92','TL170', '30-04-2020', '30-05-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM93','TL172', '01-01-2020', '02-02-2020', N'Còn hàng')

Insert into KhuyenMai values ('KM94','DH136', '01-01-2020', '02-02-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM95','DH138', '01-05-2020', '01-06-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM96','DH132', '25-01-2020', '26-01-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM97','DH130', '14-02-2020', '14-03-2020', N'Còn hàng')
Insert into KhuyenMai values ('KM98','DH129', '08-09-2020', '08-10-2020', N'Còn hàng')
Select * from KhuyenMai
--delete from KhuyenMai

Insert into Kho values ('DT001', 10, N'Kệ A')
Insert into Kho values ('DT002', 9, N'Kệ A')
Insert into Kho values ('DT003', 5, N'Kệ A')
Insert into Kho values ('DT004', 5, N'Kệ A')
Insert into Kho values ('DT005', 3, N'Kệ A')
Insert into Kho values ('DT006', 5, N'Kệ A')
Insert into Kho values ('DT007', 11, N'Kệ A')
Insert into Kho values ('DT008', 15, N'Kệ A')
Insert into Kho values ('DT009', 1, N'Kệ A')
Insert into Kho values ('DT010', 2, N'Kệ A')

Insert into Kho values ('DT011', 1, N'Kệ B')
Insert into Kho values ('DT012', 11, N'Kệ B')
Insert into Kho values ('DT013', 1, N'Kệ B')
Insert into Kho values ('DT014', 3, N'Kệ B')
Insert into Kho values ('DT015', 9, N'Kệ B')
Insert into Kho values ('DT016', 2, N'Kệ B')
Insert into Kho values ('DT017', 5, N'Kệ B')
Insert into Kho values ('DT018', 11, N'Kệ B')
Insert into Kho values ('DT019', 10, N'Kệ B')
Insert into Kho values ('DT020', 12, N'Kệ B')
Insert into Kho values ('DT021', 10, N'Kệ B')
Insert into Kho values ('DT022', 7, N'Kệ B')
Insert into Kho values ('DT023', 6, N'Kệ B')
Insert into Kho values ('DT024', 3, N'Kệ B')

Insert into Kho values ('DT025', 8, N'Kệ C')
Insert into Kho values ('DT026', 5, N'Kệ C')
Insert into Kho values ('DT027', 4, N'Kệ C')
Insert into Kho values ('DT028', 5, N'Kệ C')
Insert into Kho values ('DT029', 2, N'Kệ C')
Insert into Kho values ('DT030', 2, N'Kệ C')
Insert into Kho values ('DT031', 1, N'Kệ C')

Insert into Kho values ('DT032', 6, N'Kệ D')
Insert into Kho values ('DT033', 10, N'Kệ D')
Insert into Kho values ('DT034', 14, N'Kệ D')
Insert into Kho values ('DT035', 3, N'Kệ D')
Insert into Kho values ('DT036', 3, N'Kệ D')
Insert into Kho values ('DT037', 9, N'Kệ D')

Insert into Kho values ('DT002', 10, N'Kệ E')
Insert into Kho values ('DT002', 10, N'Kệ E')
Insert into Kho values ('DT002', 10, N'Kệ E')
Insert into Kho values ('DT002', 10, N'Kệ E')
Insert into Kho values ('DT002', 10, N'Kệ E')
Insert into Kho values ('DT002', 10, N'Kệ E')
Insert into Kho values ('DT002', 10, N'Kệ E')
Insert into Kho values ('DT002', 10, N'Kệ E')
Insert into Kho values ('DT002', 10, N'Kệ E')
select * from Kho

Insert into BaoHanh values ('DT001', N'Lỗi phần cứng', 'KH01', N'12 tháng')
Insert into BaoHanh values ('DT002', N'Nàm hình bể', 'KH02', N'12 tháng')
Insert into BaoHanh values ('DT085', N'camera bị lỗi', 'KH18', N'12 tháng')
Insert into BaoHanh values ('DT070', N'Loa nghe bị lỗi', 'KH14', N'12 tháng')
Insert into BaoHanh values ('DT100', N'Lỗi phần mền', 'KH16', N'12 tháng')
Insert into BaoHanh values ('DT011', N'Bể màn hình', 'KH20', N'12 tháng')
Insert into BaoHanh values ('DT105', N'Cấu hình bị lỗi', 'KH11', N'12 tháng')
Insert into BaoHanh values ('DT066', N'Lỗi nút âm lượng', 'KH19', N'12 tháng')
Insert into BaoHanh values ('DT127', N'Lỗi nút nguồn', 'KH12', N'12 tháng')
Insert into BaoHanh values ('DT050', N'Màn hình bể', 'KH09', N'12 tháng')
Insert into BaoHanh values ('DT123', N'Lỗi phần cứng', 'KH06', N'12 tháng')
Insert into BaoHanh values ('DT057', N'Loa nghe bị lỗi', 'KH08', N'12 tháng')
Insert into BaoHanh values ('DT030', N'Bể màn hình', 'KH15', N'12 tháng')
Insert into BaoHanh values ('DT040', N'Lỗi nút âm lượng', 'KH17', N'12 tháng')
Insert into BaoHanh values ('DT021', N'Lỗi nút home', 'KH03', N'12 tháng')
Insert into BaoHanh values ('DT010', N'Lỗi Lỗ sạc pin', 'KH04', N'12 tháng')
Insert into BaoHanh values ('DT088', N'Lỗi phần mền', 'KH05', N'12 tháng')
Insert into BaoHanh values ('DT051', N'Màn hình bể', 'KH08', N'12 tháng')
Insert into BaoHanh values ('DT020', N'Lỗi nút âm lượng', 'KH07', N'12 tháng')
Insert into BaoHanh values ('DT030', N'Camera bị lỗi', 'KH20', N'12 tháng')
Insert into BaoHanh values ('DT001', N'Camera bị lỗi', 'KH12', N'12 tháng')
Insert into BaoHanh values ('DT033', N'Loa nghe bị lỗi', 'KH09', N'12 tháng')
Insert into BaoHanh values ('DT036', N'Nút âm lượng bị lỗi', 'KH12', N'12 tháng')
Insert into BaoHanh values ('DT111', N'Nút nguồn bị lỗi', 'KH11', N'12 tháng')
Insert into BaoHanh values ('DT095', N'Camere bị lỗi', 'KH13', N'12 tháng')
Select * from BaoHanh

Set DateForMat DMY  
Insert into PhieuNhap values ('PN001', 'NV05', 'NCC01', '12-04-2020',100000000, null )
Insert into PhieuNhap values ('PN002', 'NV06', 'NCC02', '10-12-2020',100000000, null )
Insert into PhieuNhap values ('PN003', 'NV06', 'NCC03', '30-11-2020',100000000, null )
Insert into PhieuNhap values ('PN004', 'NV05', 'NCC04', '29-10-2019',100000000, null )
Insert into PhieuNhap values ('PN005', 'NV06', 'NCC05', '12-08-2020',100000000, null )
Insert into PhieuNhap values ('PN006', 'NV05', 'NCC06', '28-10-2020',100000000, null )
Insert into PhieuNhap values ('PN007', 'NV06', 'NCC02', '30-12-2020',100000000, null )
Insert into PhieuNhap values ('PN008', 'NV05', 'NCC06', '11-12-2020',100000000, null )
Insert into PhieuNhap values ('PN009', 'NV06', 'NCC04', '14-11-2020',100000000, null )
Insert into PhieuNhap values ('PN010', 'NV05', 'NCC03', '17-10-2020',100000000, null )
Insert into PhieuNhap values ('PN011', 'NV05', 'NCC02', '25-01-2020',100000000, null )
Insert into PhieuNhap values ('PN012', 'NV06', 'NCC06', '26-03-2019',100000000, null )
Insert into PhieuNhap values ('PN013', 'NV06', 'NCC01', '01-09-2020',100000000, null )
Insert into PhieuNhap values ('PN014', 'NV05', 'NCC05', '09-11-2020',100000000, null )
Insert into PhieuNhap values ('PN015', 'NV06', 'NCC06', '18-01-2020',100000000, null )
Select * from PhieuNhap
--delete from PhieuNhap


Insert into ChiTietPhieuNhap values ('CTPN001', 'PN001','DT001', 10, 1000000000000 )
Insert into ChiTietPhieuNhap values ('CTPN002', 'PN002','DT001', 10, 1100000000000 )
Insert into ChiTietPhieuNhap values ('CTPN003', 'PN003','DT001', 10, 1200000000000 )
Insert into ChiTietPhieuNhap values ('CTPN004', 'PN004','DT001', 10, 1300000000000 )
Insert into ChiTietPhieuNhap values ('CTPN005', 'PN005','DT001', 10, 1100000000000 )
Insert into ChiTietPhieuNhap values ('CTPN006', 'PN006','DT001', 10, 1400000000000 )
Insert into ChiTietPhieuNhap values ('CTPN007', 'PN007','DT001', 10, 1700000000000 )
Insert into ChiTietPhieuNhap values ('CTPN008', 'PN008','DT001', 10, 1800000000000 )
Insert into ChiTietPhieuNhap values ('CTPN009', 'PN009','DT001', 10, 1900000000000 )
Insert into ChiTietPhieuNhap values ('CTPN010', 'PN010','DT001', 10, 1700000000000 )
Insert into ChiTietPhieuNhap values ('CTPN011', 'PN011','DT001', 10, 1900000000000 )
Insert into ChiTietPhieuNhap values ('CTPN013', 'PN012','DT001', 10, 2000000000000 )
Insert into ChiTietPhieuNhap values ('CTPN012', 'PN013','DT001', 10, 2000000000000 )
Insert into ChiTietPhieuNhap values ('CTPN014', 'PN014','DT001', 10, 3000000000000 )
Insert into ChiTietPhieuNhap values ('CTPN015', 'PN015','DT001', 10, 1000000000000 )
Select * from ChiTietPhieuNhap