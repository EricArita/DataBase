Use Master
go
if Exists(select *From Sys.databases Where name='QLLinhKienDT')
	Drop database QLLinhKienDT
go
create database QLLinhKienDT
go
use QLLinhKienDT
go
SET DATEFORMAT dmy;
go
create table LoaiSP(
   MaLoai varchar(5) PRIMARY KEY,
   TenLoai Nvarchar(50),
);

go
create table NguonCungCap(
   MaNguon varchar(5) Primary Key,
   TenNguon Nvarchar(50),
   GhiChu Nvarchar(50),
);
go
create table SanPham
(
  MaSP varchar(5) PRIMARY KEY,
  MaLoai varchar(5) foreign key (MaLoai) references LoaiSP(MaLoai) ON DELETE CASCADE,
  MaNguon varchar(5) foreign key (MaNguon) references NguonCungCap(MaNguon) ON DELETE CASCADE,
  TenSP Nvarchar(50),
  GiaNhap float,
  GiaBan float,
  DonViTinh Nvarchar(10),
);


go
create table Kho(
  IDKho int IDENTITY(1,1)Primary Key,
  MaSP varchar(5) FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP) ON DELETE CASCADE,
  TenSP nvarchar(50),
  MaNguon varchar(5) foreign key (MaNguon) references NguonCungCap(MaNguon),
  ThoiGian varchar(20) ,
  TrangThai nvarchar(5),
  SoLuong int,
  GhiChu nvarchar(50),
);

go
Create table KhachHang(
  MaKhach varchar(5) Primary Key,
  TenKhach Nvarchar(50),
  SoDT varchar(11),
  GhiChu Nvarchar(50),
);
go
create table TaiKhoan(
  MaTaiKhoan varchar(5) Primary key,
  TenTK Nvarchar(50),
  MatKhau varchar(10),
  HoTen Nvarchar(50),
  SoDT varchar(11),
  SoCmnd varchar(10),
  DiaChi Nvarchar(50),
  GhiChu Nvarchar(50),
  urlHinhAnh Nchar(150),
);
go
create table PhanQuyen(
  Id int IDENTITY(1,1),
  MaPhanQuyen varchar(5) Primary key,
  FormName varchar(50),
  MaTaiKhoan varchar(5),FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan) ON DELETE CASCADE,
  GhiChu Nvarchar(50),
);
go
create table HoaDon(
  MaHD varchar(5) primary key ,
  NgayLap datetime,
  MaTaiKhoan varchar(5) foreign key (MaTaiKhoan) references TaiKhoan(MaTaiKhoan) ON DELETE CASCADE,
  DaThanhToan bit,
  TenKhachHang Nvarchar(50),
  SoDT varchar(11),
  DiaChi Nvarchar(50),
  GhiChu Nvarchar(50),
);
go
create table ChiTietHD(
  MaCTHD int IDENTITY(1,1)Primary Key,
  MaHD varchar(5) foreign key (MaHD) references HoaDon(MaHD) ON DELETE CASCADE,
  MaSP varchar(5)foreign key (MaSP) references SanPham(MaSP) ON DELETE CASCADE,
  SoLuong int,
  SPTang bit
);
go
create table DMform(
 IDform varchar(4) primary key,
 TenBtn varchar(20),
 TenForm Nvarchar(100),
);
go
create table Quyen(
 ID int IDENTITY(1,1),
 MaTaiKhoan varchar(5) foreign key (MaTaiKhoan) references TaiKhoan(MaTaiKhoan) ON DELETE CASCADE,
 IDform varchar(4) foreign key (IDform) references DMform(IDform) ON DELETE CASCADE,
);
go
insert into LoaiSP values('SN01',N'Tai nghe Sony'); 
insert into LoaiSP values('SS02',N'Tai nghe SamSung'); 
insert into LoaiSP values('CL01',N'Kính cường lực'); 
insert into LoaiSP values('SDT01',N'Sạc dự phòng'); 
insert into LoaiSP values('BP',N'Bàn phím máy tính'); 
insert into LoaiSP values('PSS01',N'Pin điên thoại SamSung');
insert into LoaiSP values('PSN01',N'Pin điên thoại Sony');
insert into LoaiSP values('PAS01',N'Pin điên thoại Asus');
insert into LoaiSP values('SSN01',N'Sạc điên thoại Sony');
insert into LoaiSP values('SSS01',N'Pin điên thoại SamSung');
insert into LoaiSP values('SAS01',N'Sạc Laptop Asus');
insert into LoaiSP values('SFS01',N'Gậy Selfie');
insert into LoaiSP values('BPDT',N'Bàn phím điện thoại');
insert into LoaiSP values('TN','Thẻ nhớ')
insert into LoaiSP values('WF','Bộ thu sông wifi');
insert into LoaiSP values('DCOM','D-COM 3G');
go


insert into NguonCungCap values('KTHT',N'Công ty TNHH Kỹ thuật Hưng Thịnh',N'864 Cách Mạng Tháng Tám-Tân Bình-Tp.Hồ Chí Minh ');
insert into NguonCungCap values('CTDD',N'Công ty TNHH Thương mại dịch vụ Đồng Dung',N'168 Lê Lai-P. Bến Thành-Q. 1, Tp.HCM');
insert into NguonCungCap values('VTTP',N'Công ty TNHH Vi tính tiến phát',N'Tân Bình-Tp.Hồ Chí Minh');
insert into NguonCungCap values('MTMC',N'Công ty TNHH Máy tính Minh Châu',N'86 Thích Quảng Đức-Long Khánh-Đồng Nai');
insert into NguonCungCap values('TTAN',N'Công ty TNHH Thương mại dịch vụ An Nhất',N'Nguyễn Thị Minh Khai-Q.3-TPHCM');
insert into NguonCungCap values('BHXT',N'Trung Tâm Bảo Hành Laptop Xuân Thọ',N'Mai Thị Hồng Hạnh-Rạch Giá-Kiên Giang');
insert into NguonCungCap values('TBVP',N'Công ty TNHH Máy tính Thiết Bị Văn Phòng Nam Hà',N'Hai Bà Trưng-Hà Nội');
insert into NguonCungCap values('THHK',N'Công ty TNHH TM DV Tin Học Hoàng Khang',N'Võ Văn Tần-Q3-TP.HCM');
insert into NguonCungCap values('CNNK',N'Công ty TNHH Công nghệ và Xây Dựng Nam Kinh',N'Hoàng Văn Thụ-Q.Hoàng Mai-Hà Nội');
insert into NguonCungCap values('MTVPT',N'Công ty TNHH MTV Nhân Phát Thịnh',N'Mỹ Phước-Bến Cát-Bình Dương');
go


insert into SanPham values('TP001','SN01','KTHT',N'Tai nghe Sony','70000','100000','cái'); 
insert into SanPham values('TP002','SS02','CNNK',N'Tai nghe SamSung','70000','100000','cái'); 
insert into SanPham values('KCL01','CL01','TTAN',N'Kính cường lực','100000','150000','cái'); 
insert into SanPham values('SDP01','SDT01','CTDD',N'Sạc dự phòng','200000','300000','cái'); 
insert into SanPham values('BP001','BP','CTDD',N'Bàn phím máy tính','100000','150000','cái'); 
insert into SanPham values('PDT01','PSS01','CTDD',N'Pin điên thoại SamSung','100000','150000','cái');
insert into SanPham values('PDT02','PSS01','CTDD',N'Pin điên thoại Apple','100000','150000','cái');
insert into SanPham values('PDT03','PAS01','CTDD',N'Pin điên thoại Asus','100000','150000','cái');
insert into SanPham values('SDT01','SSN01','TTAN',N'Sạc điên thoại Sony','100000','150000','cái');
insert into SanPham values('SDT02','SSS01','CNNK',N'Pin điên thoại SamSung','100000','150000','cái');
insert into SanPham values('SLT02','SAS01','CTDD',N'Sạc Laptop Asus','200000','250000','cái');
insert into SanPham values('SF01','SFS01','CTDD',N'Gậy Selfie Iphone','100000','150000','cái');
insert into SanPham values('SF02','SFS01','CTDD',N'Gậy Selfie Samsung','100000','150000','cái');
insert into SanPham values('SF03','SFS01','CTDD',N'Gậy Selfie VIP ','200000','250000','cái');
insert into SanPham values('TN01','TN','TTAN',N'Thẻ nhớ 16GB','150000','200000','cái');
insert into SanPham values('TN02','TN','TTAN',N'Thẻ nhớ 8GB','100000','150000','cái');
insert into SanPham values('TN03','TN','CTDD',N'Thẻ nhớ 4GB','72000','85000','cái');
insert into SanPham values('BPDT1','BPDT','CTDD',N'Bàn phím điện thoại SAMSUNG','200000','250000','cái');
insert into SanPham values('BPDT2','BPDT','CTDD',N'Bàn phím điện thoại SONY','200000','250000','cái');
insert into SanPham values('BPDT3','BPDT','CTDD',N'Bàn phím điện thoại IPhone','200000','250000','cái');
insert into SanPham values('TSWF','WF','CTDD',N'Bộ thu sống wifi 206m','200000','250000','cái');
insert into SanPham values('DCOM1','DCOM','CNNK',N'D-Com 3g','200000','250000','cái');

go
insert into Kho values('TP001',N'Tai nghe Sony','KTHT','10/03/2017',N'Nhập',100,'');
insert into Kho values('TP001',N'Tai nghe Sony','KTHT','13/03/2017',N'Xuất',80,'');
insert into Kho values('TP001',N'Tai nghe Sony','KTHT','14/03/2017',N'Nhập',10,'');
insert into Kho values('TP001',N'Tai nghe Sony','KTHT','14/03/2017',N'Xuất',5,'');
insert into Kho values('TP002',N'Tai nghe SamSung','CNNK','11/03/2017',N'Nhập',150,'');
insert into Kho values('TP002',N'Tai nghe SamSung','CNNK','11/03/2017',N'Xuất',100,'');
insert into Kho values('TP002',N'Tai nghe SamSung','CNNK','12/03/2017',N'Xuất',2,'');
insert into Kho values('TP002',N'Tai nghe SamSung','CNNK','13/03/2017',N'Xuất',3,'');
insert into Kho values('TP002',N'Tai nghe SamSung','CNNK','13/03/2017',N'Xuất',10,'');
insert into Kho values('KCL01',N'Kính cường lực','TTAN','11/03/2017',N'Nhập',80,'');
insert into Kho values('KCL01',N'Kính cường lực','TTAN','11/03/2017',N'Xuất',50,'');
insert into Kho values('SDP01',N'Sạc dự phòng','CTDD','12/03/2017',N'Nhập',120,'');
insert into Kho values('SDP01',N'Sạc dự phòng','CTDD','12/03/2017',N'Xuất',50,'');
insert into Kho values('BP001',N'Bàn phím máy tính','CTDD','12/3/2017',N'Nhập',70,'');
insert into Kho values('BP001',N'Bàn phím máy tính','CTDD','12/3/2017',N'Xuất',20,'');
insert into Kho values('PDT01',N'Bàn phím điện thoại SamSung','CTDD','11/3/2017',N'Nhập',90,'');
insert into Kho values('PDT01',N'Bàn phím điện thoại SamSung','CTDD','11/3/2017',N'Xuất',10,'');
insert into Kho values('PDT02',N'Bàn phím điện thoại Apple','CTDD','11/8/2017',N'Nhập',120,'');
insert into Kho values('PDT02',N'Bàn phím điện thoại Apple','CTDD','11/8/2017',N'Nhập',50,'');
insert into Kho values('PDT03',N'Bàn phím điện thoại Asus','CTDD','11/9/2017',N'Nhập',80,'');
insert into Kho values('PDT03',N'Bàn phím điện thoại Asus','CTDD','11/9/2017',N'Nhập',20,'');
go

insert into KhachHang values('KH001',N'Mai Thị Tuyết Nhi','0169748259',N'Q9-TPHCM');
insert into KhachHang values('KH002',N'Hoàng Thị Lan Anh','0165028582',N'Q9-TPHCM');
insert into KhachHang values('KH003',N'Huỳnh Thị Cảnh Vi','0128569219',N'Lâm Hà-Lâm Đồng');
insert into KhachHang values('KH004',N'Huỳnh Văn Cường','0164029569',N'Bình Định');
insert into KhachHang values('KH005',N'Bùi Long Tuyên','0123484509',N'Bình Định');
insert into KhachHang values('KH006',N'Nguyễn Xuân Hội','0165765903',N'Xuân Lộc-Đồng Nai');
insert into KhachHang values('KH007',N'Nguyến Văn Tuyên','0124896892',N'Bình Phước-Đồng Nai');
insert into KhachHang values('KH008',N'Trương Quang Tuấn','0168530039',N'Lâm Hà-Lâm Đồng');
insert into KhachHang values('KH009',N'Trương Quang Tấn','0168530039',N'Lâm Hà-Lâm Đồng');
insert into KhachHang values('KH010',N'Phạm Minh Tiến','0168532889',N'Đăk Lắk');

go

insert into TaiKhoan values ('TK002','mainhi','1111',N'Mai Thị Tuyết Nhi','01640295695','632145',N'Quận 9','','..\..\..\resource\image\nhanvien\nv5.PNG');
insert into TaiKhoan values ('TK001','lananh','2011',N'Hoàng Thị Lan Anh','01203301033','669645',N'Quận 9','','..\..\..\resource\image\nhanvien\nv6.PNG');
insert into TaiKhoan values ('TK003','canhvi','2222',N'Huỳnh Thị Cảnh Vi','01640295785','122145',N'Quận 1','','..\..\..\resource\image\nhanvien\nv3.PNG');
insert into TaiKhoan values ('TK004','vancuong','VC01234',N'Huỳnh Văn Cường','0164029789','7832145',N'Đà Nẵng','','..\..\..\resource\image\nhanvien\nv4.PNG');
insert into TaiKhoan values ('TK005','longtuyen','LT4567',N'Bùi Long Tuyên','01640295678','616145',N'Cần Thơ','','..\..\..\resource\image\nhanvien\nv1.PNG');
insert into TaiKhoan values ('TK006','xuanhoi','XH1345',N'Nguyễn Xuân Hội','01641695695','587145',N'Quận 1','','..\..\..\resource\image\nhanvien\nv2.PNG');
insert into TaiKhoan values ('TK007','vantuyen','VT3457',N'Nguyễn Văn Tuyên','01675195695','632157',N'Đồng Nai','','..\..\..\resource\image\nhanvien\nv3.PNG');
insert into TaiKhoan values ('TK008','quangtuan','QT1234',N'Trương Quang Tuấn','01640123495','754345',N'Bình Dương','','..\..\..\resource\image\nhanvien\nv4.PNG');
insert into TaiKhoan values ('TK009','minhtien','MT1234',N'Phạm Minh Tiến','01640295612','632715',N'Lâm Đồng','','..\..\..\resource\image\nhanvien\nv1.PNG');
insert into TaiKhoan values ('TK010','quangtan','QT234',N'Trương Quang Tấn','01643595695','354145',N'Hà Nội','','..\..\..\resource\image\nhanvien\nv2.PNG');

 go

 insert into HoaDon values('HD1','3/3/2017','TK001',1,N'','','','');
 insert into HoaDon values('HD2','11/3/2017','TK002',1,N'','','','');
 insert into HoaDon values('HD3','12/1/2017','TK003',1,N'','','','');
 insert into HoaDon values('HD4','10/2/2017','TK004',1,N'','','','');
 insert into HoaDon values('HD5','9/7/2017','TK005',1,N'','','','');
 insert into HoaDon values('HD6','9/5/2017','TK006',0,N'','','','');
 insert into HoaDon values('HD7','9/9/2017','TK007',0,N'','','','');
 insert into HoaDon values('HD8','2/7/2017','TK008',0,N'','','','');
 insert into HoaDon values('HD9','2/5/2017','TK009',0,N'','','','');
 insert into HoaDon values('HD10','2/4/2017','TK010',1,N'','','','');
 insert into HoaDon values('HD11','6/3/2017','TK010',1,N'','','','');
 insert into HoaDon values('HD12','11/6/2017','TK002',1,N'','','','');
 insert into HoaDon values('HD13','12/11/2017','TK003',1,N'','','','');
 insert into HoaDon values('HD14','10/12/2017','TK004',1,N'','','','');
 insert into HoaDon values('HD15','19/7/2017','TK005',1,N'','','','');
 insert into HoaDon values('HD16','19/5/2017','TK006',0,N'','','','');
 insert into HoaDon values('HD17','9/5/2017','TK007',0,N'','','','');
 insert into HoaDon values('HD18','12/7/2017','TK008',0,N'','','','');
 insert into HoaDon values('HD19','12/8/2017','TK009',0,N'','','','');
 insert into HoaDon values('HD20','13/9/2017','TK001',1,N'','','','');

 go

insert into ChiTietHD values('HD1','TP001',2,1);
insert into ChiTietHD values('HD1','TP002',4,0);
insert into ChiTietHD values('HD1','BP001',2,0);
insert into ChiTietHD values('HD2','TP002',2,0);
insert into ChiTietHD values('HD2','KCL01',1,0);
insert into ChiTietHD values('HD3','KCL01',1,0);
insert into ChiTietHD values('HD4','SDP01',3,0);
insert into ChiTietHD values('HD5','BP001',4,1);
insert into ChiTietHD values('HD6','PDT01',2,0);
insert into ChiTietHD values('HD7','PDT02',1,0);
insert into ChiTietHD values('HD8','PDT03',2,0);
insert into ChiTietHD values('HD9','SDT01',5,0);
insert into ChiTietHD values('HD10','SDT02',2,0);
insert into ChiTietHD values('HD15','BP001',4,1);
insert into ChiTietHD values('HD16','PDT01',2,0);
insert into ChiTietHD values('HD17','PDT02',1,0);
insert into ChiTietHD values('HD18','PDT03',2,0);
insert into ChiTietHD values('HD19','SDT01',5,0);
insert into ChiTietHD values('HD20','SDT02',2,0);
insert into ChiTietHD values('HD7','PDT01',1,0);
insert into ChiTietHD values('HD8','PDT02',2,0);
insert into ChiTietHD values('HD9','SDT01',5,0);
insert into ChiTietHD values('HD10','SDT02',2,0);
insert into ChiTietHD values('HD15','BP001',4,1);
insert into ChiTietHD values('HD16','PDT01',2,0);
insert into ChiTietHD values('HD17','PDT02',1,0);
insert into ChiTietHD values('HD18','PDT03',2,0);
insert into ChiTietHD values('HD19','SDT01',5,0);
insert into ChiTietHD values('HD20','SDT02',2,0);

go
insert into DMform values('Q001','btnSanPham',N'Danh mục sản phẩm');
insert into DMform values('Q002','btnLoaiSanPham',N'Danh mục loại sản phẩm');
insert into DMform values('Q003','btnKhachHang',N'Danh mục khách hàng');
insert into DMform values('Q004','btnNhaCungCap',N'Danh mục nhà cung cấp');
insert into DMform values('Q005','btnNhapHang',N'Nhập hàng');
insert into DMform values('Q006','btnBanHang',N'Bán hàng');
insert into DMform values('Q007','btnThongKe',N'Thống kê');
insert into DMform values('Q008','btnBaoCaoDT',N'Báo cáo doanh thu');
insert into DMform values('Q009','btnBaoCaoSPnhap',N'Báo cáo sản phẩm nhập');
insert into DMform values('Q010','btnBaoCaoSPBan',N'Báo cáo sản phẩm bán');
insert into DMform values('Q011','btnBaoCaoNV',N'Báo cáo nhân viên');
insert into DMform values('Q012','btnTaiKhoan',N'Quản lý tài khoản');
insert into DMform values('Q013','btnDoiMK',N'Đổi mật khẩu');
insert into DMform values('Q014','btnDangXuat',N'Đăng xuất');
insert into DMform values('Q015','btnPhanQuyen',N'Phân quyền');
insert into DMform values('Q016','btnSaoLuuDL',N'Sao lưu dữ liệu');
insert into DMform values('Q017','btnPhucHoiDL',N'Phục hồi dữ liệu');
insert into DMform values('Q018','btnGioiThieu',N'Giới thiệu');
insert into DMform values('Q019','btnDoiGiaoDien',N'Đổi giao diện');
go
insert into Quyen values('TK001','Q001');
insert into Quyen values('TK001','Q002');
insert into Quyen values('TK001','Q003');
insert into Quyen values('TK001','Q004');
insert into Quyen values('TK001','Q005');
insert into Quyen values('TK001','Q006');
insert into Quyen values('TK001','Q007');
insert into Quyen values('TK001','Q008');
insert into Quyen values('TK001','Q009');
insert into Quyen values('TK001','Q010');
insert into Quyen values('TK001','Q011');
insert into Quyen values('TK001','Q012');
insert into Quyen values('TK001','Q013');
insert into Quyen values('TK001','Q014');
insert into Quyen values('TK001','Q015');
insert into Quyen values('TK001','Q016');
insert into Quyen values('TK001','Q017');
insert into Quyen values('TK001','Q018');
insert into Quyen values('TK001','Q019');
insert into Quyen values('TK002','Q019');
insert into Quyen values('TK002','Q013');
insert into Quyen values('TK002','Q014');
go
create view view_TongSPNhap
as
	select MaSP,TrangThai,sum(SoLuong) as SoLuong
	from Kho
	where TrangThai = N'Nhập'
	group by MaSP,TrangThai

go
create view view_TongSPXuat
as
	select MaSP,TrangThai,sum(SoLuong) as SoLuong
	from Kho
	where TrangThai = N'Xuất'
	group by MaSP,TrangThai
go
CREATE PROC SortID
AS
BEGIN
	DECLARE @BangTam TABLE(	
		 MaSP varchar(5),
		 TenSP nvarchar(50),
		 MaNguon varchar(5),
		 ThoiGian varchar(20) ,
		 TrangThai nvarchar(5),
		 SoLuong int,
		 GhiChu nvarchar(50)
	);

	INSERT INTO @BangTam SELECT MaSP, TenSP, MaNguon, ThoiGian, TrangThai, SoLuong, GhiChu FROM Kho ORDER BY IDKho ASC;
	DROP TABLE Kho;
	CREATE TABLE Kho(
		 IDKho int IDENTITY(1,1)Primary Key,
		 MaSP varchar(5) FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP) ON DELETE CASCADE,
		 TenSP nvarchar(50),
		 MaNguon varchar(5) foreign key (MaNguon) references NguonCungCap(MaNguon),
		 ThoiGian varchar(20) ,
		 TrangThai nvarchar(5),
		 SoLuong int,
	     GhiChu nvarchar(50),
	);
	INSERT INTO Kho SELECT MaSP, TenSP, MaNguon, ThoiGian, TrangThai, SoLuong, GhiChu FROM @BangTam;
END;


--select nhap.MaSP, COALESCE(nhap.SoLuong - xuat.SoLuong,nhap.SoLuong) as SoLuong,sp.TenSP
--        from SanPham sp, view_TongSPXuat xuat right join view_TongSPNhap nhap on nhap.MaSP = xuat.MaSP
--         where nhap.MaSP = sp.MaSP
--         group by nhap.MaSP,xuat.SoLuong,nhap.SoLuong,sp.TenSP

--go

--select MAX(CAST(RIGHT(mahd,LEN(mahd)-2) as INT)) as sohd
--from hoadon

--select hd.MaHD, hd.NgayLap , sum((ct.SoLuong*sp.GiaNhap)) as TongNhap, sum((ct.SoLuong*sp.GiaBan)) as TongBan
--from HoaDon hd,ChiTietHD ct,SanPham sp
--where hd.MaHD=ct.MaHD and ct.MaSP = sp.MaSP and hd.NgayLap >='2-3-2017' and hd.NgayLap<= '3-5-2017'
--group by hd.MaHD,hd.NgayLap 

--select * from Sanpham


--select k.*, sp.TenSP, n.MaNguon
-- from Kho k, SanPham sp, NguonCungCap n
-- where k.MaSP = sp.MaSP and sp.MaNguon = n.MaNguon and k.TrangThai =N'Nhập';

--select tk.HoTen,hd.MaHD, hd.NgayLap,ct.MaSP, ct.SoLuong, sp.DonViTinh,sp.GiaBan, (ct.SoLuong*sp.GiaBan) as ThanhTien
--from TaiKhoan tk,HoaDon hd, ChiTietHD ct,SanPham sp
--where tk.MaTaiKhoan= hd.MaTaiKhoan and hd.MaHD = ct.MaHD and ct.MaSP = sp.MaSP 


--select k.MaSP, sp.TenSP, n.TenNguon , sum(k.SoLuong) as SL
--from Kho k, SanPham sp, NguonCungCap n
--where k.MaSP = sp.MaSP and sp.MaNguon = n.MaNguon and k.TrangThai = N'Xuất'
--group by k.MaSP,sp.TenSP,n.TenNguon
--ORDER BY SL DESC

--select Q.*,F.TenBtn, F.TenForm
--from Quyen Q, DMform F
--where Q.IDform=F.IDform 

--select hd.* , tk.HoTen
--from HoaDon hd , TaiKhoan tk
--where hd.MaTaiKhoan = tk.MaTaiKhoan

--select * from ChiTietHD

--select hd.*, sp.GiaBan, sp.TenSP
--from ChiTietHD hd, SANPHAM sp
--where hd.MaHD = 'HD1' and hd.MaSP = sp.MaSP
--INSERT INTO TaiKhoan VALUES('TK999','nguyentinh','1234',N'Nguyễn Tính','01212181202','341672915',N'Vũ Trụ',N'Sao hỏa','..\..\..\resource\image\nhanvien\IMG_0825.JPG')

