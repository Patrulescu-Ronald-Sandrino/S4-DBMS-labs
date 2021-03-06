USE [dbms-a3]; GO

/* Switch commenting between the next 2 statements */
-- SET TRANSACTION ISOLATION LEVEL READ COMMITTED -- Problem
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ -- Solution

BEGIN TRAN
SELECT * FROM T1
WAITFOR DELAY  '00:00:6'
SELECT * FROM T1 -- <- reads a different value than before
COMMIT TRAN

SELECT * FROM T1 -- View Results