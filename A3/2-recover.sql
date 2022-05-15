USE [dbms-a3]; GO




CREATE OR ALTER PROCEDURE run2RecoverAddSuccess AS
    -- autogenerate the names based on the ids that will be assigned
    DECLARE @id1 INT = 1 + (SELECT MAX(id) FROM [T1])
    DECLARE @id2 INT = 1 + (SELECT MAX(id) FROM [T2])
    IF @id1 IS NULL
        SET @id1 = 0
    IF @id2 iS NULl
        SET @id2 = 0
    DECLARE @name1 VARCHAR(30) = CONCAT('Name 1-', @id1)
    DECLARE @name2 VARCHAR(30) = CONCAT('Name 2-', @id2)

    EXEC addTransactT1 @name1, 25
    EXEC addTransactT2 @name2, 125
    SET @id1 = (SELECT MAX(id) FROM [T1])
    SET @id2 = (SELECT MAX(id) FROM [T2])
    EXEC addTransactT1mn2 @id1, @id2
GO

CREATE OR ALTER PROCEDURE run2RecoverAddFailure AS
    -- autogenerate the names based on the ids that will be assigned
    DECLARE @id1 INT = 1 + (SELECT MAX(id) FROM [T1])
    DECLARE @id2 INT = 1 + (SELECT MAX(id) FROM [T2])
    IF @id1 IS NULL
        SET @id1 = 0
    IF @id2 iS NULL
        SET @id2 = 0
    DECLARE @name1 VARCHAR(30) = CONCAT('Name 1-', @id1)
    DECLARE @name2 VARCHAR(30) = CONCAT('Name 2-', @id2)

    EXEC addTransactT1 @name1, 30
    EXEC addTransactT2 @name2, -30 -- fails, but the operation before is committed
    SET @id1 = (SELECT id FROM [T1] WHERE name = @name1)
    SET @id2 = (SELECT id FROM [T2] WHERE name = @name2)
    EXEC addTransactT1mn2 @id1, @id2 -- fails, because of the FK constraint (since @id2 won't be present if the prev. operation fails)
GO