USE [dbms-a3]; GO

DELETE FROM T1 WHERE name LIKE '%'
INSERT INTO T1 VALUES ('name1 for deadlock', 3)

BEGIN TRAN
UPDATE T1 SET name = 'name1 for deadlock updated in transaction 1' WHERE name = 'name1 for deadlock'
WAITFOR DELAY '00:00:03'
UPDATE T2 SET name = 'name1 for deadlock updated in transaction 1' WHERE name = 'name1 for deadlock'
COMMIT TRAN