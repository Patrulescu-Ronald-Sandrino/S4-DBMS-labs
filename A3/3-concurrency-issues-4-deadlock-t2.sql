USE [dbms-a3]; GO

DELETE FROM T2 WHERE name LIKE '%'
INSERT INTO T2 VALUES ('name1 for deadlock', 3)

/* switch between commenting the next line */
SET DEADLOCK_PRIORITY HIGH

BEGIN TRAN
UPDATE T2 SET name = 'name1 for deadlock updated in transaction 2' WHERE name = 'name1 for deadlock'
WAITFOR DELAY '00:00:03'
UPDATE T1 SET name = 'name1 for deadlock updated in transaction 2' WHERE name = 'name1 for deadlock'
COMMIT TRAN


SELECT * FROM T1
SELECT * FROM T2