use TEAM13

CREATE VIEW EfficientSupplier AS
	SELECT s.SupplierId,s.SupplierName,ps.ProductId,c.ProductPrice,c.ProductRating,c.Discount,ROUND((c.ProductPrice - (c.ProductPrice/c.Discount)),2) as PriceAfterDiscount
	from Supplier.Supplier s
	join Supplier.ProductSupplier ps
	on  s.SupplierId = ps.SupplierId
	join Product.Catalogue c
	on ps.ProductId = c.ProductId


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


ALTER TABLE Organisation.Department
DROP COLUMN Expenditure;

select * from Organisation.Department

 
		