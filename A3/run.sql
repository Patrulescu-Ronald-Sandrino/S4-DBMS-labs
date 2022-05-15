USE [dbms-a3]; GO

-- TODO: MAYBE [validation] use THROW instead of RAISERROR
-- TODO: MAYBE refactor auto-generation of names

-- 1 - rollback
USE [dbms-a3]; GO
EXEC run1RollbackAddSuccess
SELECT * FROM [LogsDML]
EXEC run1RollbackAddFailure
SELECT * FROM [LogsDML]


-- 2 - recover
USE [dbms-a3]; GO
EXEC run2RecoverAddSuccess
SELECT * FROM [LogsDML]
WAITFOR DELAY '00:00:03'
EXEC run2RecoverAddFailure
SELECT * FROM [LogsDML]


-- 3 - concurrency issues


-- 4 - update conflict
