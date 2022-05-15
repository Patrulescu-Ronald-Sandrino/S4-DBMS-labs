USE [dbms-a3]
GO


CREATE OR ALTER PROCEDURE validateName (@name VARCHAR(30)) AS
    BEGIN
        IF @name IS NULL OR LEN(@name) < 2
            RAISERROR ('Invalid name', 14, 1)
    END
GO

CREATE OR ALTER PROCEDURE validateValue (@value REAL) AS
    BEGIN
        IF @value IS NULL OR @value < 0
            RAISERROR ('Invalid value', 14, 1)
    END
GO


CREATE OR ALTER PROCEDURE validateT (@name VARCHAR(30), @value REAL) AS
    BEGIN
        EXEC validateName @name
        EXEC validateValue @value
    END
GO

-- validateName NULL; GO -- fails
-- validateName 'a'; GO -- fails
-- validateName 'abc'; GO

-- validateValue NULL; GO -- fails
-- validateValue -1; GO -- fails
-- validateValue 0; GO

-- EXEC validateT NULL, 5 -- fails
-- EXEC validateT 'abc', -1 -- fails
-- EXEC validateT 'abc', 0
