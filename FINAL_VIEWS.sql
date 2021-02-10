	use "TEAM13";
	
	
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

	select DepartmentId, Name, Budget, SUM(FinalAmount) AS 'Total Expenditure'
	from DepartmentBudgetAndExpenditure
	GROUP BY DepartmentId, Name, Budget
	Order by DepartmentId
	
	--- VIEW FOR FINDING AND ANALYSING EFFICIENT SUPPLIER ---
	CREATE VIEW EfficientSupplier2 AS
	SELECT s.SupplierId,s.SupplierName,pp.ProductId,pp.Name,c.ProductPrice,c.ProductRating,c.Discount,ROUND((c.ProductPrice - (c.ProductPrice/c.Discount)),2) as PriceAfterDiscount
	from Supplier.Supplier s
	join Product.Catalogue c
	on  s.SupplierId = c.SupplierId
	join Product.Product pp
	on c.ProductId = pp.ProductId

	with temp
	as 
	(
		select *,dense_rank() over (partition by ProductId order by PriceAfterDiscount desc) RankBasedOnPrice
		from EfficientSupplier2
	)
	select SupplierId,SupplierName,ProductId,Name,ProductRating,Discount,PriceAfterDiscount
	from temp
	where RankBasedOnPrice = 1
	order by SupplierId,ProductId

	---VIEW FOR FINDING THE TRUSTED SUPPLIER
	CREATE VIEW TrustedSupplier AS (
	SELECT s.SupplierId, s.SupplierName, o.TotalQuantity
	FROM Supplier.Supplier s
	JOIN Product.Catalogue c
	ON s.SupplierId = c.SupplierId
	JOIN Procurement.Requisition r
	ON c.CatalogueId = r.CatalogueId
	JOIN Procurement.Orders o
	ON r.RequisitionId = o.RequisitionId )

	SELECT SupplierId, SupplierName, SUM(TotalQuantity) TotalProductsOrdered
	FROM TrustedSupplier
	GROUP BY SupplierId, SupplierName
	ORDER BY TotalProductsOrdered DESC