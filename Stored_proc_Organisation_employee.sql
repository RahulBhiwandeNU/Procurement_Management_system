use "TEAM13"

select * from Procurement.Requisition

select * from Product.Catalogue

select * from Procurement.Ticket
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

  -- variables

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


 -- Trigger to update ticket status when corresponding requisition is added

CREATE TRIGGER updateTicketStatus
ON Procurement.Requisition
AFTER INSERT
AS
BEGIN
	
	BEGIN TRY
		BEGIN TRANSACTION;		
			UPDATE Procurement.Ticket SET status = 'APPROVED'
			WHERE id IN ( SELECT i.ticketId FROM INSERTED i)		
		COMMIT TRANSACTION;
	END TRY
	
	BEGIN CATCH 
			IF XACT_STATE() <> 0
		BEGIN
			ROLLBACK TRANSACTION;
		END;
	END CATCH
	
END