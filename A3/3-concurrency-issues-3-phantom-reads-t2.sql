USE [dbms-a3]; GO

/* Switch commenting between the next 2 statements */
-- SET TRANSACTION ISOLATION LEVEL REPEATABLE READ -- Problem
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE -- Solution

BEGIN TRAN
SELECT * FROM T1
WAITFOR DELAY  '00:00:6'
SELECT * FROM T1 -- <- reads the insert row from the other transaction
COMMIT TRAN

SELECT * FROM T1 -- View Results