use "TEAM13";

----------------------------------------------ENTITIES--------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Employee entity
INSERT INTO Organisation.Employee (FirstName, LastName, Email, PhoneNumber, SSN) VALUES ('Si', 'Packer', 'spacker0@berkeley.edu', 9866223678, '386-54-4446'),('Tamar', 'Logsdale', 'tlogsdale1@sun.com', 1673260872, '407-30-1477'),('Barbie', 'Nisuis', 'bnisuis2@chronoengine.com', 4718126731, '758-61-9146'),('Juliana', 'Seakes', 'jseakes3@booking.com', 4853062542, '866-37-3279'),(FirstName, LastName, Email, PhoneNumber, SSN) values ('Winona', 'Tidmarsh', 'wtidmarsh4@thetimes.co.uk', 6974370506, '899-80-6316'),('Galina', 'Nutty', 'gnutty5@furl.net', 1643248859, '612-31-7000'),('Hinda', 'Olive', 'holive6@webnode.com', 6075350179, '831-63-5671'),(FirstName, LastName, Email, PhoneNumber, SSN) values ('Dasya', 'Ivanchikov', 'divanchikov7@dot.gov', 6342588681, '165-22-7111'),(FirstName, LastName, Email, PhoneNumber, SSN) values ('Selma', 'Ronaghan', 'sronaghan8@ihg.com', 9429886092, '688-10-0192'),(FirstName, LastName, Email, PhoneNumber, SSN) values ('Marline', 'Collymore', 'mcollymore9@usatoday.com', 4961943920, '441-62-7649'),(FirstName, LastName, Email, PhoneNumber, SSN) values ('Clementius', 'Yeats', 'cyeatsa@google.co.uk', 4431192902, '692-04-2619'),(FirstName, LastName, Email, PhoneNumber, SSN) values ('Catriona', 'Truce', 'ctruceb@google.it', 1879931101, '457-74-0419'),(FirstName, LastName, Email, PhoneNumber, SSN) values ('Ethelda', 'Petzold', 'epetzoldc@macromedia.com', 4051305256, '383-63-6614'),(FirstName, LastName, Email, PhoneNumber, SSN) values ('Robinetta', 'Thirwell', 'rthirwelld@indiatimes.com', 6282027891, '164-60-4304'),(FirstName, LastName, Email, PhoneNumber, SSN) values ('Joanna', 'Sykora', 'jsykorae@ucla.edu', 7385771420, '502-41-5459'),(FirstName, LastName, Email, PhoneNumber, SSN) values ('Inga', 'Medford', 'imedfordf@examiner.com', 8526592708, '602-52-5872'),(FirstName, LastName, Email, PhoneNumber, SSN) values ('Rhodia', 'Prine', 'rprineg@123-reg.co.uk', 1571893067, '615-26-9682'),(FirstName, LastName, Email, PhoneNumber, SSN) values ('Towny', 'Petrakov', 'tpetrakovh@slate.com', 9086942090, '532-24-7916'),(FirstName, LastName, Email, PhoneNumber, SSN) values ('Sean', 'Josephy', 'sjosephyi@ocn.ne.jp', 4784155497, '594-94-8861'),(FirstName, LastName, Email, PhoneNumber, SSN) values ('Bari', 'Flett', 'bflettj@wikimedia.org', 7088855304, '616-78-0902'),(FirstName, LastName, Email, PhoneNumber, SSN) values ('Rakesh', 'Sharma', 'rk@gmail.com', 7088855320, '610-78-0902');

-- Manager entity
INSERT INTO Organisation.Manager(ManagerId,DepartmentId,Incentives) VALUES ('M-1','D1',7142),('M-2','D2',9090),('M-3','D3',8948),('M-4','D4',8880),('M-5','D5',6477),('M-6','D6',9970),('M-7','D7',8800),('M-8','D8',9281),('M-9','D9',7240),('M-10','D10',7180)

-- Department entity
INSERT INTO Organisation.Department(DepartmentId,Name,Budget) VALUES('D1','Production',9070),('D2','R&D',6057),('D3','Purchasing',6323),('D4','Marketing',5646),('D5','Human Resource',5599),('D6','Accounts',6765),('D7','Finance',9700),('D8','Sales',7655),('D9','Advertisement',6116),('D10','Legal',5081);

-- Admin entity
INSERT INTO Organisation.Admin (AdminId,EmployeeId,AdminUsername,AdminPassword) VALUES ('A1',21,'Admin123',ENCRYPTBYKEY(KEY_GUID(N'ProcurementSymmetricKey'),CONVERT(varbinary,'Admin@123')));

-- GeneralStaff entity
INSERT INTO Organisation.GeneralStaff (EmployeeId, ManagerId, DepartmentId, Designation) VALUES ( 1, 'M-1','D1', 'Developer'),(2,'M-1','D2','Tester'),(3, 'M-2','D3' ,'Purchase Head'),(4,'M-3','D4','Business Analyst'),(5,'M-4','D9','Advertising Head'),(6,'M-6','D10','Advisor'),(7,'M-8','D5','HR Intern'),(8,'M-9','D6','Accountant'),(9,'M-10','D7','Finance advisor'),(10,'M-5','D8','Sales Head');

-- Category entity
INSERT INTO Product.Category (Name, Description) VALUES ('Books & Magzines', 'All kinds of books to learn new technology or magzines about what happening worldwide'), ('Electronics', 'The electronics buying guides. Cameras. Headphones. Home-theater. Laptop. Printers. Routers. Speakers. Internal SSD & RAM.'), ('Furniture', ' Buy Wooden Furniture Online at India Largest Online Furniture Store. Exclusive range of Living Room Furniture and Home Furniture Online '), ('Software', 'Computer software, or simply software, is a collection of data or computer instructions that tell the computer how to work.'), ('Stationary', ' Buy Office Items and Office Supplies like Diaries, Notebooks, Pens, Notepads, Calendars and more from India best online shopping store.'), ('Arts & Handicraft', 'A handicraft, sometimes more precisely expressed as artisanal handicraft or handmade, is any of a wide variety of types of work where useful and decorative objects'), ('Computers & Laptops', 'If you are looking for the best Windows laptop then you will certainly have to go with ..'), ('Office Cleaning', 'All kinds of products to make office hygenic and clean'), ('Health and First Aid', 'First aid is the first and immediate assistance given to any person suffering from either a minor or serious illness'), ( 'Sports & Fitness', 'All kinds of Sports & Fitness kits')

-- Product entity
INSERT INTO Product.Product (Name,Description ) VALUES ('The Intelligent Investor','Finance Management Book'),('Corporate Chanakya', 'A pioneer of economics and political science in India'),('Marketing Management', 'The gold standard for todays marketing management'),('Speakers', 'Speakers for office meetings'),('Bluetooth Speakers', 'Bluetooth device to connect to meetings'),('Printer', 'Printing machines for printing'),('Chair', 'Chair for office enployees'),('Book Shelf', 'Shelf for book storage'),('Pedestal Storage', 'Storage for books and other stuffs'),('Ink Catridge', 'For printers'),('Pens', 'Pens for Products'),('Notebooks', 'Writing pads for Products'),('Office', 'For power point,Excel, Oulook use'),('Operating Systems', 'Linux or Windows operating system'),('Adobe Workshop', 'For graphic presentation'),('The Intelligent Investor','Finance Management Book'),('Corporate Chanakya', 'A pioneer of economics and political science in India'), ('Marketing Management', 'The gold standard for todays marketing management'), ('Speakers', 'Speakers for office meetings'), ('Bluetooth Speakers', 'Bluetooth device to connect to meetings'), ('Printer', 'Printing machines for printing'), ('Chair', 'Chair for office enployees'), ('Book Shelf', 'Shelf for book storage'), ('Pedestal Storage', 'Storage for books and other stuffs'), ('Ink Catridge', 'For printers'), ('Pens', 'Pens for Products'), ('Notebooks', 'Writing pads for Products'), ('Office', 'For power point,Excel, Oulook use'), ('Operating Systems', 'Linux or Windows operating system'), ('Adobe Workshop', 'For graphic presentation'),('Sports Shoes',' Shoes primarily designed for sports or other forms of physical exercise'),('Cricket Equipment','Equipme nts such as bats, stumps, bails required for a game of cricket'),('Fitness Kit','Kits include bags, accesories for fitness exercises and activities'),('First Aid Kit','A collection of basic supplies and equipment that is used to give medical treatment.'),('Medicines','Common Medicines for headache,fever and body pain '), ('Heathcare Gadgets','Equipment lie BP Machine, Oxymeter, weight machine etc for healthcare and diagnosis'), ('Glass and Tile Cleaners','Cleaning sprays, spot removers, gels for cleaning of glass,granite,tiles and marble'),('Air Freshners','Freshners for maintaing hygenic environment in office'),('Cleaning Tools','Tools such as Sponges,gloves,dusters,spary bottles for effective cleaning'),('Antiques','Antiques as decorative objects for office decoration'),('Paintings','Decoration of office and receptionfor office'),('Paint Supplies','paint supplies such as paint brushes, art easels, sculpting tools, drawing tools for func activities'),('Windows Laptops','Laptops of brands like HP,DELL,ACER running windows operating system'),('MACBooks','MACbooks by Apple operating on MACOS'),('Computers','Desktop Computers for office use of different brands')

 -- Ticket entity
INSERT INTO  Procurement.Ticket (TicketId,Subject,Description,ProductQuantity,StaffId,ApprovalStatus,ManagerId,TicketDate) VALUES ('T1','Request for magazines', 'Need  magazines for business and finance information',10,2,'Approved','M-3','2019/08/01'),('T2','Request for laptop', 'need few laptops for the adminstration work',6,6,'Approved','M-1','2019/03/28'),('T3','Request for mouse', 'Need few mound for the new joinee', 20, 4,'Approved','M-9','2018/03/17'),('T4', 'Request for tissue paper', 'Need tissue paper in meeting rooms',100,7,'Approved','M-8','2019/07/4'),('T5', 'Request for webcams', 'Need webcam in meeting room',12,6,'Rejected','M-6','2018/02/13'),('T6', 'Request for printer', 'Need to order printer on first floor ', 2, 3,'Approved','M-2','2019/12/01'),('T7', 'Request for room freshner','Need to order freshner for meeting room', 23,5,'Rejected','M-6','2018/1/08'),('T8' , 'Request for Chair', 'Need char for third floor',21,8,'Approved', 'M-5','2018/09/09'),('T9', 'Request for Pencil', 'Need to order stationary for office' , 200, 9, 'Rejected','M-7','2019/10/22'),('T10', 'Request for Paiting', 'Need to order decoration for second floor', 5,9,'Rejected','M-4','2018/12/09'),('T12', 'Request for spekaers', 'Need speakers for the christams function in office',4,10,'Approved','M-6','2019/12/01'),('T13', 'Request for bookshelf', 'Need bookself in the library area' ,2,2,'Approved','M-4','2018/05/23'),('T14', 'Request for notebooks', 'Need new notebooks for new joinee',120,4,'Approved','M-9','2019/04/22'),('T15', 'Request for ink catridge' ,'Need to refill the printer on 4th floor',4,1,'Approved','M-10','2018/06/12');

-- Supplier entity
INSERT Supplier.Supplier VALUES ('Proin Corp.'),('Sit Industries'),('Rhoncus Associates'),('Molestie Tortor'),('Interdum Ltd'),('Vehicula Institute'),('Nisi A Limited'),('Ipsum Non Inc.'),('Ut Consulting'),('Orci Donec LLP'),('Fusce Limited'),('Nam PC')

-- ProductSupplier entity
INSERT Supplier.ProductSupplier VALUES (2,3),(6,7),(8,7),(9,11),(10,11),(11,10),(12,4),(14,12),(16,4),(22,2),(23,2),(24,2),(26,1),(27,10),(4,3),(30,3),(1,10),(12,10),(19,1),(21,8),(25,2),(17,4),(13,5),(18,6),(7,7),(3,9),(5,5),(30,12),(29,11),(28,3),(5,3),(20,4),(20,6),(15,9)

-- Contract entity
 INSERT Supplier.Contract VALUES ('2018-01-03','2021-01-03',10,'D1',5),('2019-05-01','2020-05-01',4,'D3',10),('2018-10-15','2020-10-15',3,'D5',8),('2018-07-01','2021-07-01',3,'D5',7),('2019-01-01','2022-01-01',10,'D3',1),('2017-04-10','2020-04-10',9,'D6',4),('2020-01-01','2023-01-01',8,'D2',2),('2020-08-25','2022-08-25',7,'D4',3),('2017-09-10','2020-09-10',6,'D7',6),('2019-11-01','2021-11-01',1,'D10',9)

 --Inventory entity
 INSERT INTO Organisation.Inventory VALUES (01,5,2,'A1'),(02,3,5,'A1'),(03,4,8,'A1'),(04,25,11,'A1'),(05,20,12,'A1'),(06,2,19,'A1'),(07,2,23,'A1'),(08,15,28,'A1'),(09,10,29,'A1'),(10,4,6,'A1');

 --ProductCategory entity
 INSERT INTO Product.ProductCategory (ProductId, CategoryId) VALUES ('1','1'), ('2','1'), ('3','1'), ('4','2'), ('5','2'), ('6','2'), ('7','3'), ('8','3'), ('9','3'), ('10','4'), ('11','4'), ('12','4'), ('13','5'), ('14','5'), ('15','5'), ('16','6'), ('17','6'), ('18','6'), ('19','7'), ('20','7'), ('21','7'), ('22','8'), ('23','8'), ('24','8'), ('25','9'), ('26','9'), ('27','9'), ('28','10'), ('29','10'), ('20','10')

 -- Catalogue entity
 INSERT INTO Product.Catalogue(Discount,Stock,ProductId,SupplierId,ProductPrice,ProductRating) VALUES (10,50,1,10,9.50,3),(10,50,2,3,10,4),(10,100,3,9,10,4),(20,100,4,3,50,5),(12,200,5,3,50,4),(15,200,5,5,40,3),(15,200,6,7,40,4),(20,400,7,7,35,5),(20,100,8,7,70,5),(15,200,9,11,50,4),(12,150,10,11,20,3),(5,450,11,10,0.5,4),(8,400,12,4,1,4),(9,300,12,10,1,3),(20,100,13,5,70,5),(20,200,14,12,70,5),(15,100,15,9,70,4),(10,200,16,4,30,4),(12,200,17,4,60,4),(15,200,18,6,65,4),(10,100,19,1,50,5),(18,400,20,4,20,4),(15,500,20,6,25,5),(15,100,21,8,40,4),(12,100,22,2,25,4),(10,200,23,2,20,5),(10,200,24,2,25,4),(20,250,25,2,55,5),(12,200,26,1,50,5),(15,300,27,10,25,4),(25,500,28,3,999,5),(25,500,29,11,1499,5),(18,400,30,3,799,5),(20,100,30,12,699,4);

 -- Requisition entity
 INSERT INTO Procurement.Requisition (RequisitionId,ManagerId,AdminId,RequisitionDate,CatalogueId,TicketId) VALUES ('R1','M-3','A1','2019/08/03', 1,'T1'),('R2','M-1','A1','2019/03/29',28,'T2'),('R3','M-9','A1','2018/03/20',33,'T3'),('R4','M-8', 'A1','2019/07/05',27, 'T4'),('R5','M-2','A1','2019/12/15',5,'T6'),('R6','M-5','A1','2018/09/12',8,'T8'),('R7','M-6','A1','2019/12/03',4,'T12'),('R8','M-4','A1','2018/05/25',9,'T13'),('R9', 'M-9','A1','2019/04/23',13,'T14'),('R10','M-10','A1','2018/06/14',11,'T15');

 -- Invoice entity
 INSERT INTO Procurement.Invoice(OrderId, ActualPrice, Discount, PaymentMode, CreateDate) VALUES (4,95,10,'NEFT','2019-08-05'),(5,80,12,'Cash','2018-06-16'),(6,330,20,'NEFT','2019-03-31'),(7,15980,20,'NEFT','2018-03-22'),(8,2500,10,'Card','2019-07-07'),(9,100,12,'Cash','2019-12-17'),(10,735,20,'NEFT','2018-09-14'),(11,200,20,'Card','2019-012-05'),(12,140,20,'NEFT','2018-05-27'),(13,120,8,'Cash','2019-04-25')
------------------------------------------------------------------------------------------------------------------------ENTITIES END------------------------------------------------------------------------------

	--- INSERT STORED PROCEDURE SCRIPT for Procurement.Orders
	EXEC  dbo.Orders
	@OrderDate = '2019-08-04 00:00:00.000',
	@OrderDetails = 'Order againts ticketID T1',
	@TotalQuantity = 10,
	@AdminID = 'A1',
	@RequisitionID = 'R1'
	EXEC  dbo.Orders
	@OrderDate = '2019-03-30 00:00:00.000',
	@OrderDetails = 'Order againts ticketID T2',
	@TotalQuantity = 6,
	@AdminID = 'A1',
	@RequisitionID = 'R2'
	EXEC  dbo.Orders
	@OrderDate = '2018-03-21 00:00:00.000',
	@OrderDetails = 'Order againts ticketID T15',
	@TotalQuantity = 20,
	@AdminID = 'A1',
	@RequisitionID = 'R3'	
	EXEC  dbo.Orders
	@OrderDate = '2019-07-06 00:00:00.000',
	@OrderDetails = 'Order againts ticketID T4',
	@TotalQuantity = 100,
	@AdminID = 'A1',
	@RequisitionID = 'R4'
	EXEC  dbo.Orders
	@OrderDate = '2019-12-16 00:00:00.000',
	@OrderDetails = 'Order againts ticketID T6',
	@TotalQuantity = 2,
	@AdminID = 'A1',
	@RequisitionID = 'R5'
	EXEC  dbo.Orders
	@OrderDate = '2018-09-13 00:00:00.000',
	@OrderDetails = 'Order againts ticketID T8',
	@TotalQuantity = 21,
	@AdminID = 'A1',
	@RequisitionID = 'R6'
	EXEC  dbo.Orders
	@OrderDate = '2019-12-04 00:00:00.000',
	@OrderDetails = 'Order againts ticketID T12',
	@TotalQuantity = 4,
	@AdminID = 'A1',
	@RequisitionID = 'R7'
	EXEC  dbo.Orders
	@OrderDate = '2018-05-26 00:00:00.000',
	@OrderDetails = 'Order againts ticketID T13',
	@TotalQuantity = 2,
	@AdminID = 'A1',
	@RequisitionID = 'R8'
	EXEC  dbo.Orders
	@OrderDate = '2019-04-24 00:00:00.000',
	@OrderDetails = 'Order againts ticketID T14',
	@TotalQuantity = 120,
	@AdminID = 'A1',
	@RequisitionID = 'R9'
	EXEC  dbo.Orders
	@OrderDate = '2018-06-15 00:00:00.000',
	@OrderDetails = 'Order againts ticketID T15',
	@TotalQuantity = 4,
	@AdminID = 'A1',
	@RequisitionID = 'R10'
	
	--- QUERY FOR DEPARTMENT INFORMATION AND EXPENDITURE -----
	
	/* 
	   [] The below view will allow the user view the department's budget and expenditure.
	   [] This may allow the user to gain an insight on department spending as well as its budget handling.
	*/

	select DepartmentId, Name, Budget, SUM(FinalAmount) AS 'Total Expenditure'
	from DepartmentBudgetAndExpenditure
	GROUP BY DepartmentId, Name, Budget
	Order by DepartmentId
	

	--- QUERY FOR FINDING AND VIEWING MOST EFFICIENT SUPPLIER -----
	
	/*
	   [] The below view will help the user to view various supplier for a single product.
	   [] This in turn can help the organization to select cost as well as quality efficient supplier.
	   [] The view also provides information about the product price as well as its rating.
	*/

	with temp
	as 
	(
		select *,dense_rank() over (partition by ProductId order by PriceAfterDiscount desc) RankBasedOnPrice
		from EfficientSupplier
	)
	select SupplierId,SupplierName,ProductId,ProductRating,Discount,PriceAfterDiscount
	from temp
	where RankBasedOnPrice = 1
	order by ProductId
