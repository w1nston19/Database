/*TRIGGERS*/
CREATE TRIGGER stop_manufacture_delete
ON manufacturer
INSTEAD OF DELETE
AS DECLARE @i bit
GO
CREATE TRIGGER UpdatedManufacturerName
ON manufacturer
AFTER UPDATE
AS 
IF EXISTS (
    SELECT *
    FROM
        INSERTED I
        JOIN
        DELETED D
         ON D.ID = I.ID 
            AND D.name <> I.name
    )
print 'Manufacturer name has changed'
GO
