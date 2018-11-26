USE QLLinhKienDT;
DECLARE @Date varchar(20);
SET @Date = CONVERT(varchar, GETDATE(), 103);
go
SELECT COUNT(*) FROM Kho
SET IDENTITY_INSERT Kho OFF;
insert into Kho values('TP001',N'Tai nghe Sony','KTHT', '24/07/2018', N'Nhập',100,'Test');
DELETE FROM Kho WHERE IDKho = '2';
SET IDENTITY_INSERT Kho ON;
DBCC CHECKIDENT (Kho, RESEED, 1);
SET STATISTICS TIME ON
SELECT * FROM Kho;
SELECT Kho.IDKho, Kho.MaSP, Kho.TenSP, Kho.MaNguon, Kho.ThoiGian, Kho.TrangThai, Kho.SoLuong, Kho.GhiChu FROM Kho;
SET STATISTICS TIME ON
SELECT * FROM NguonCungCap;
SELECT * FROM view_TongSPNhap;
SELECT * FROM view_TongSPXuat;
SELECT * FROM TaiKhoan;
DROP VIEW view_TongSPNhap;
DROP VIEW view_TongSPXuat;
DROP table TaiKhoan
go

CREATE TABLE KhoTamThoi(
  MaSP varchar(5),
  TenSP nvarchar(50),
  MaNguon varchar(5),
  ThoiGian varchar(20) ,
  TrangThai nvarchar(5),
  SoLuong int,
  GhiChu nvarchar(50),
);


INSERT INTO KhoTamThoi SELECT MaSP, TenSP, MaNguon, ThoiGian, TrangThai, SoLuong, GhiChu FROM Kho ORDER BY IDKho ASC;

DROP TABLE Kho;

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

INSERT INTO Kho SELECT MaSP, TenSP, MaNguon, ThoiGian, TrangThai, SoLuong, GhiChu FROM Temporary;

SELECT* FROM KhoTamThoi;


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

	INSERT INTO @BangTam(MaSP, TenSP, MaNguon, ThoiGian, TrangThai, SoLuong, GhiChu) SELECT MaSP, TenSP, MaNguon, ThoiGian, TrangThai, SoLuong, GhiChu FROM Kho ORDER BY IDKho ASC;
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
	INSERT INTO Kho(MaSP, TenSP, MaNguon, ThoiGian, TrangThai, SoLuong, GhiChu) SELECT MaSP, TenSP, MaNguon, ThoiGian, TrangThai, SoLuong, GhiChu FROM @BangTam;
END;

DROP PROCEDURE SortID;
EXEC SortID;

DECLARE @BangTam1 TABLE(
	 ID int IDENTITY(1,1)Primary Key,
	 MaSP varchar(5)
);
INSERT INTO @BangTam1(MaSP) SELECT MaSP FROM view_TongSPNhap;
SELECT ID,MaSP FROM @BangTam1;
DECLARE @BangTam2 TABLE(
		 ID int IDENTITY(1,1)Primary Key,
		 MaSP varchar(5),
		 TenSP nvarchar(50),
		 TenNguon nvarchar(50),
		 SoLuong int
	);
DECLARE @currID INT = 1, @MaxID INT, @MaSP varchar(5), @SLNhap INT, @SLXuat INT;
SELECT @MaxID = MAX(ID) FROM @BangTam1;
WHILE @currID < @MaxID + 1
BEGIN
	SET @SLNhap = 0;
	SET @SLXuat = 0;
	SELECT @MaSP = MaSP FROM @BangTam1 WHERE ID = @currID;
	SELECT @SLNhap = view_TongSPNhap.SoLuong FROM view_TongSPNhap WHERE MaSP = @MaSP;
	SELECT @SLXuat = view_TongSPXuat.SoLuong FROM view_TongSPXuat WHERE MaSP = @MaSP;
	INSERT INTO @BangTam2(MaSP, TenSP, TenNguon, SoLuong)
	SELECT DISTINCT @MaSP, Kho.TenSP, NguonCungCap.TenNguon, @SLNhap - @SLXuat
	FROM Kho, NguonCungCap
	WHERE Kho.MaSP = @MaSP and NguonCungCap.MaNguon IN (SELECT MaNguon FROM view_TongSPNhap WHERE MaSP = @MaSP)
	SET @currID = @currID + 1;
END;

SELECT * FROM view_TongSPNhap;
SELECT * FROM view_TongSPXuat;
SELECT * FROM @BangTam2;
exec TaoBangHangTonKho;

SET STATISTICS TIME OFF -- hiện thống kê về thời gian thực hiện
GO
CREATE PROC handleContraintError
			  @MaSP varchar(5),
			  @MaLoai varchar(5),
			  @MaNguon varchar(5),
			  @TenSP Nvarchar(50),
			  @GiaNhap float,
			  @GiaBan float,
			  @DonViTinh Nvarchar(10)			  
AS
BEGIN
	BEGIN TRY
		insert into SanPham values(@MaSP, @MaLoai, @MaNguon, @TenSP, @GiaNhap, @GiaBan, @DonViTinh); 
	END TRY
	BEGIN CATCH
		PRINT N'Lỗi CMNR';
	END CATCH 
END

EXEC handleContraintError 'JJS','SDD','KTHT',N'Tai nghe Sony','70000','100000','cái'
DROP PROC handleContraintError
GO

SELECT MaSP, TenSP, MaNguon, TenNguon, ThoiGian, SoLuong, GhiChu FROM Kho WHERE ThoiGian >= CONVERT(date,'01/08/2017',103) AND ThoiGian <= CONVERT(date,'30/09/2017',103)
SELECT MaSP, TenSP, MaNguon, TenNguon, ThoiGian, SoLuong, GhiChu FROM Kho WHERE TrangThai = N'Nhập' AND ThoiGian >= '20170201' AND ThoiGian <= '20180908 22:29:00';
insert into Kho values('PDT03',N'Bàn phím điện thoại Asus','CTDD',N'Công ty TNHH Thương mại dịch vụ Đồng Dung','19110207',N'Nhập',20,'Test');
SELECT* FROM Kho;

SELECT * FROM ChiTietPhanQuyen
insert into ChiTietPhanQuyen values('Q001','barbtnProduct',N'Danh mục sản phẩm');
SELECT MaTaiKhoan FROM TaiKhoan WHERE Username = 'quangtuan' AND Password = 'QT1234';
