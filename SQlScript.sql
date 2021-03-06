USE [master]
GO
/****** Object:  Database [Inventory]    Script Date: 5/20/2021 12:52:08 PM ******/
CREATE DATABASE [Inventory]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Inventory', FILENAME = N'F:\SQL SERVER\MSSQL12.SQLEXPRESS\MSSQL\DATA\Inventory.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Inventory_log', FILENAME = N'F:\SQL SERVER\MSSQL12.SQLEXPRESS\MSSQL\DATA\Inventory_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Inventory] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Inventory].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Inventory] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Inventory] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Inventory] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Inventory] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Inventory] SET ARITHABORT OFF 
GO
ALTER DATABASE [Inventory] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Inventory] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Inventory] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Inventory] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Inventory] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Inventory] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Inventory] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Inventory] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Inventory] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Inventory] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Inventory] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Inventory] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Inventory] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Inventory] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Inventory] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Inventory] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Inventory] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Inventory] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Inventory] SET  MULTI_USER 
GO
ALTER DATABASE [Inventory] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Inventory] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Inventory] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Inventory] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Inventory] SET DELAYED_DURABILITY = DISABLED 
GO
USE [Inventory]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 5/20/2021 12:52:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[PkProduct] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NULL,
	[Description] [varchar](1000) NULL,
	[Price] [decimal](20, 2) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PkProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ResponseCode]    Script Date: 5/20/2021 12:52:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ResponseCode](
	[PkResponseCode] [bigint] NULL,
	[ResponseDescription] [varchar](3000) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT (getdate()) FOR [UpdatedDate]
GO
/****** Object:  StoredProcedure [dbo].[sp_addupdateinventory]    Script Date: 5/20/2021 12:52:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_addupdateinventory] 
@pkProduct int,
@Name varchar(500),
@Description varchar(1000),
@Price decimal(20,2)
AS
BEGIN
IF(@pkProduct=0)
BEGIN
INSERT INTO Product(Name,[Description],Price) VALUES (@Name,@Description,@Price);
SELECT PkResponseCode AS Code,ResponseDescription AS [Message] FROM ResponseCode WHERE PkResponseCode =2000
END
ELSE
BEGIN
UPDATE Product
SET Name=@Name,
[Description]=@Description,
Price=@Price,
UpdatedDate=GETDATE()
WHERE pkProduct=@pkProduct
SELECT PkResponseCode AS Code,ResponseDescription AS [Message] FROM ResponseCode WHERE PkResponseCode =2001
END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_deleteinventory]    Script Date: 5/20/2021 12:52:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_deleteinventory] 
@pkProduct int
AS
IF EXISTS(SELECT '*' FROM Product WHERE PkProduct=@pkProduct)
BEGIN
DELETE FROM Product WHERE PkProduct=@pkProduct
SELECT PkResponseCode AS Code,ResponseDescription AS [Message] FROM ResponseCode WHERE PkResponseCode =2002
END
ELSE
BEGIN
SELECT PkResponseCode AS Code,ResponseDescription AS [Message] FROM ResponseCode WHERE PkResponseCode =2004
END

GO
USE [master]
GO
ALTER DATABASE [Inventory] SET  READ_WRITE 
GO
