use "TEAM13";

------------------------- DDL STATEMENTS FOR ORGANISATION SCHEMA -----------------------------
create schema Organisation;
go

create table Organisation.Employee
(
	EmployeeId int identity primary key,
	FirstName varchar(45),
	LastName varchar(45),
	Email varchar(45),
	PhoneNumber bigint,
	SSN varchar(12)
)


create table Organisation.Department
(
	DepartmentId varchar(20) primary key,
	Name varchar(45),
	Budget money,
)

create table Organisation.Manager
(
	ManagerId varchar(20) primary key,
	EmployeeId int,
	DepartmentId varchar(20),
	Incentives money,
	foreign key(EmployeeId) references Organisation.Employee(EmployeeId),
	foreign key(DepartmentId) references Organisation.Department(DepartmentId),
)

create table Organisation.GeneralStaff
(
	StaffId int identity primary key,
	EmployeeId int,
	ManagerId varchar(20),
	DepartmentId varchar(20),
	Designation varchar(45),
	foreign key(EmployeeId) references Organisation.Employee(EmployeeId),
	foreign key(DepartmentId) references Organisation.Department(DepartmentId),
	foreign key(ManagerId) references Organisation.Manager(ManagerId),
)

create table Organisation.Admin
(
	AdminId varchar(20) primary key,
	EmployeeId int,
	AdminUsername varchar(50),
	AdminPassword varbinary(250),
	foreign key(EmployeeId) references Organisation.Employee(EmployeeId)
)

create table Organisation.Inventory
(
	InventoryId int primary key,
	TotalStock int,
	ProductId int,
	AdminId varchar(20),
	foreign key(ProductId) references Product.Product(ProductId),
	foreign key(AdminId) references Organisation.Admin(AdminId),
)

--- DDL STATEMENTS FOR PROCUREMENT SCHEMA ------

create schema Procurement;
go

CREATE TABLE Procurement.Orders
(
OrderID int identity not null PRIMARY KEY,
OrderDate datetime not null,
OrderDetails varchar(250),
TotalQuantity int,
AdminId int not null references Procurement.Admin(AdminId),
RequisitionId INT not null references Procurement.Requisition(RequisitionId)
);

CREATE TABLE Procurement.Invoice
(
InvoiceID int identity not null PRIMARY KEY,
OrderId int not null references Procurement.Orders(OrderId),
ActualPrice money not null,
Discount float,
DiscountAmount as dbo.fn_Discounted_Amount(Discount,ActualPrice) ,
FinalAmount as dbo.fn_Final_Amount(Discount,ActualPrice),
PaymentMode varchar(50),
CreateDate datetime not null
);

create table Procurement.Ticket 
(TicketId varchar(20)  not null primary key ,
Subject varchar(45)  not null ,
Description varchar (250) not null,
ProductQuality int not null ,
StaffId int not null references Organization.GeneralStaff (StaffId),
ApprovalStatus char(10) not null,
ManagerId varchar(20) not null references Organization.Manager (ManagerId),
TicketDate datetime default (getdate())
)

create table Procurement.Requsition
(RequsitionId varchar(30) not null  primary key,
ManagerId varchar(20) not null references Organization.Manager (ManagerId),
AdminId varchar (20) not null references Organization.[Admin](AdminId),
RequsitionDate datetime default (getdate()),
CatalogueId int not null references Product.Catalogue(CatalogueId),
TicketId varchar(20) not null references Procurement.Ticket (TicketId)
)


-- DDL STATEMENTS FOR PRODUCT SCHEMA --
create schema Product;
go

CREATE TABLE Product.Category(
	CategoryId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Name VARCHAR(45),
	Description VARCHAR(250)
)

CREATE TABLE Product.Catalogue(
	CatalogueId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Discount FLOAT,
	Stock INT,
	ProductId INT
		REFERENCES Product.Product(ProductId),
	SupplierId INT
		REFERENCES Supplier.Supplier(SupplierId),
	ProductPrice MONEY,
	ProductRating INT
)
CREATE TABLE Product.ProductCategory(
	ProductId INT NOT NULL
		REFERENCES Product.Product(ProductId),
	CategoryId INT NOT NULL
		REFERENCES Product.Category(CategoryId)
		
	CONSTRAINT PKProductCategory PRIMARY KEY CLUSTERED
		(ProductId,CategoryId)
)

CREATE TABLE Product.Product
	( ProductId int IDENTITY NOT NULL PRIMARY KEY,
	  Name varchar(45) NOT NULL,
	  Description varchar(250) NOT NULL
	 )
	 
--- DDL STATEMENTS FOR SUPPLIER SCHEMA -- 
create schema Supplier;
go

CREATE TABLE Supplier.Supplier
	( SupplierId int IDENTITY NOT NULL PRIMARY KEY,
	  SupplierName varchar(45) NOT NULL 	 
	 )

CREATE TABLE Supplier.Contract
	( ContractId int IDENTITY NOT NULL PRIMARY KEY,
	  StartDate date NOT NULL,
	  EndDate date NOT NULL ,
	  SupplierId int NOT NULL REFERENCES Supplier.Supplier(SupplierId) ,
	  DepartmentId varchar(20) NOT NULL REFERENCES Organisation.Department(DepartmentId) ,
	  CategoryId int NOT NULL REFERENCES Product.Category(CategoryId)    
	)
	
CREATE TABLE Supplier.ProductSupplier
		( ProductId int NOT NULL REFERENCES Product.Product(ProductId),
		  SupplierId int NOT NULL REFERENCES Supplier.Supplier(SupplierId)
		  CONSTRAINT PKProductSupplier PRIMARY KEY CLUSTERED (ProductID, SupplierID)
		)
		
------------------------------------- END OF DB TABLES CREATION -----------------------------------------------

----- TABLE CONSTRAINTS -----
		
-- Encryption Information
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'P@ssword!';

CREATE CERTIFICATE ProcCert
   ENCRYPTION BY PASSWORD = 'P@ssword!'
   WITH SUBJECT = 'Database encryption key', 
   EXPIRY_DATE = '20201031';

CREATE SYMMETRIC KEY ProcKey 
   WITH ALGORITHM = AES_128
   ENCRYPTION BY CERTIFICATE ProcCert;

OPEN SYMMETRIC KEY ProcKey
DECRYPTION BY CERTIFICATE ProcCert WITH PASSWORD = 'P@ssword!'

-- TABLE LEVEL CHECK USING FUNCTIONS
CREATE FUNCTION check_email(@email varchar(45)) -- USE : CHECKS EMAIL FORMAT IN Organisation.Employee TABLE
RETURNS INT
AS
BEGIN
DECLARE @ret int
if @email like '%_@__%.__%'
	set @ret = 0 -- RETURNS '0' IF THE FORMAT IS CORRECT
RETURN @ret;
END;

alter table Organisation.Employee
add constraint Email check(dbo.check_email(Email) = 0) -- IF VALUE IS '0' THEN EMAIL FORMAT IS CORRECT

-- COMPUTED COLUMNS FUNCTIONS
CREATE FUNCTION fn_Discounted_Amount(@Discount float,@ActualPrice money) -- USE : COMPUTES Discount column value in Procurement.Invoice table
RETURNS MONEY
AS
   BEGIN
      DECLARE @discounted_amount MONEY
	  SET @discounted_amount = (@Discount * @ActualPrice)/100
	  SET @discounted_amount = ISNULL(@discounted_amount, 0)
	  RETURN @discounted_amount
         
END

CREATE FUNCTION fn_Final_Amount(@Discount money,@ActualPrice money) -- USE : COMPUTES FinalAmount column value in Procurement.Invoice table
RETURNS MONEY
AS
   BEGIN
      DECLARE @final_amount money 
	  DECLARE @Discount_money money
	  set @Discount_money = (@ActualPrice * @Discount)/100
	  SET @final_amount = @ActualPrice - @Discount_money
	  SET @final_amount = ISNULL(@final_amount, 0)
	  RETURN @final_amount
         
END
		
---- STORED PROCEDURES ----

-- STORED PROCEDURE for insertion of data in Organisation.Employee
	CREATE PROCEDURE MasterInsertSelect (@first_name VARCHAR(45), @last_name VARCHAR(45),@email varchar(45),@PhoneNumber bigint,@SSN varchar(45),@StatementType NVARCHAR(20) = '')  
	AS  
	BEGIN  
		IF @StatementType = 'Insert'  
			BEGIN  
				INSERT INTO Organisation.Employee  
							(FirstName,  
							LastName,  
							Email,  
							PhoneNumber,
							SSN)  
				VALUES     ( @first_name,  
							@last_name,  
							@email,  
							@PhoneNumber,  
							@SSN)  
			END  
  
		IF @StatementType = 'Select'  
			BEGIN  
				SELECT *  
				FROM   Organisation.Employee  
			END  
	END

	-- VARIABLES

	DECLARE @FNAME VARCHAR(45);
	DECLARE @LNAME VARCHAR(45);
	DECLARE @E_EMAIL VARCHAR(45);
	DECLARE @p_PHONENUMBER BIGINT;
	DECLARE @S_SSN VARCHAR(45);
	DECLARE @STYPE NVARCHAR(20);

	-- INITIALIZING THE VARIABLES
	SET @FNAME = 'RAHUL'
	SET @LNAME = 'BHIWANDE'
	SET @E_EMAIL = 'r@gmail.com'
	SET @p_PHONENUMBER = 7977464457
	SET @S_SSN = '367-55-7777'
	SET @STYPE = 'Insert'

	-- EXECUTING THE PROCEDURE
	EXEC MasterInsertSelect @FNAME,@LNAME,@E_EMAIL,@p_PHONENUMBER,@S_SSN,@STYPE;


	-- STORED PROCEDURE FROM Procurement.Orders
	CREATE PROC dbo.Orders
	@OrderDate datetime,
	@OrderDetails Varchar(20),
	@TotalQuantity INT,
	@AdminID varchar(20),
	@RequisitionID Varchar(20)
	AS
	BEGIN
		INSERT INTO Procurement.Orders(OrderDate,OrderDetails,TotalQuantity,AdminID,RequisitionID)
				VALUES (@OrderDate,@OrderDetails,@TotalQuantity,@AdminID,@RequisitionID)
	END

---- END OF STORED PROCEDURES ----
	
---- TRIGGERS ----

-- TRIGGER FOR CHECKING APPROVAL STATUS OF TICKET AND THEN CREATING REQUISITION
	CREATE TRIGGER Procurement.checkapprovalstatus
	ON Procurement.Requisition
	AFTER INSERT AS 
	BEGIN
	DECLARE @count smallint=0
	SELECT  @count=Count(TicketId)
		FROM Procurement.Ticket
		WHERE TicketId = (SELECT TicketId from inserted)
		AND ApprovalStatus = 'Rejected';
	IF @count > 0 
		BEGIN
			Rollback;
		END
	END;
	
---- END OF TRIGGERS ----
	
---- ANALYSIS SECTION ----

	-- Function to check product stock availability by Admin using RequisitionId
	
	/*
		[] Function to help admin check for existing stock in the inventory before placing an order
		[] Helps to prevent wasteful purchasing
	*/

	CREATE FUNCTION checkProductStock
	(@RequisitionId varchar(30)) 
	RETURNS Table
	AS 
	RETURN ( WITH tempTable AS (
			SELECT
				pr.RequisitionId,
				pc.ProductId ,
				pd.Name,
				pt.ProductQuantity,
				isNull(oi.TotalStock,0) AS [QuantityAvaiiable],
				pt.ProductQuantity - isNull(oi.TotalStock,0) AS [QuantityRequired]
			FROM
				Procurement.Requisition pr
			JOIN Procurement.Ticket pt ON
				pr.TicketId = pt.TicketId
			LEFT JOIN Product.Catalogue pc ON
				pc.CatalogueId = pr.CatalogueId
			JOIN Product.Product pd ON
				pd.ProductId = pc.ProductId
			LEFT JOIN Organisation.Inventory oi ON
				pc.ProductId = oi.ProductId
			WHERE
				pr.RequisitionId = @RequisitionId )
			SELECT
				ProductId ,
				Name AS [Product Name],
				ProductQuantity AS [Quantity Requested],
				RequisitionId,
				QuantityAvaiiable AS [Quantity Available],
				QuantityRequired AS [Quantity Required]
			FROM
				tempTable )

	
	--- VIEW FOR DEPARTMENT'S BUDGET AND EXPENDITURE INFORMATION ---
	create view DepartmentBudgetAndExpenditure AS
	select d.DepartmentId, d.Name, d.Budget, i.FinalAmount
	from Procurement.Invoice i
	join Procurement.Orders o
	on i.OrderId = o.OrderId
	join Procurement.Requisition r
	on o.RequisitionId = r.RequisitionId
	join Organisation.Manager m
	on r.ManagerId = m.ManagerId
	join Organisation.Department d
	on m.DepartmentId = d.DepartmentId
	
	--- VIEW FOR FINDING AND ANALYSING EFFICIENT SUPPLIER ---
	CREATE VIEW EfficientSupplier AS
	SELECT s.SupplierId,s.SupplierName,ps.ProductId,c.ProductPrice,c.ProductRating,c.Discount,ROUND((c.ProductPrice - (c.ProductPrice/c.Discount)),2) as PriceAfterDiscount
	from Supplier.Supplier s
	join Supplier.ProductSupplier ps
	on  s.SupplierId = ps.SupplierId
	join Product.Catalogue c
	on ps.ProductId = c.ProductId