USE [dbms-a3]; GO

/* Switch commenting between the next 2 statements */
-- SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED -- Problem
SET TRANSACTION ISOLATION LEVEL READ COMMITTED -- Solution (note that this the default TRANSACTION ISOLATION LEVEL)

BEGIN TRAN
SELECT * FROM T1 -- <- reading uncommitted change of t1
WAITFOR DELAY  '00:00:6'
SELECT * FROM T1
COMMIT TRAN

SELECT * FROM T1 -- View Results