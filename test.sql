use TEAM13

select * from Organisation.Admin

delete from Organisation.Admin
where AdminId = 'A2'


select AdminUsername,DECRYPTBYKEY(AdminPassword)
from Organisation.Admin

INSERT INTO Organisation.Admin (AdminId,EmployeeId,AdminUsername,AdminPassword) VALUES ('A1',21,'Admin123',ENCRYPTBYKEY(KEY_GUID(N'ProcurementSymmetricKey'),CONVERT(varbinary,'Admin@123')));

UPDATE Organisation.Admin  
SET AdminPassword = EncryptByKey(Key_GUID('ProcKey'), CONVERT(varbinary,'root'))
where AdminId = 'A1'
GO  
select * from Organisation.Admin 

declare  @clean_data varchar(100)

set  @clean_data='Hello World'

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

insert into Organisation.Admin (AdminId,EmployeeId,AdminUsername,AdminPassword) values('A2',22,'UserRahul',EncryptByKey(Key_GUID('ProcKey'), CONVERT(varbinary,'root')))


CLOSE SYMMETRIC KEY ProcKey;

SELECT cast(DecryptByKeyAutoCert(cert_id('cert_dbKeys'), N'P@ssword!', secretmessage) as varchar(100)) FROM EncryptedData

select AdminUsername,convert(varchar,Decryptbykey(AdminPassword)) 
from Organisation.Admin