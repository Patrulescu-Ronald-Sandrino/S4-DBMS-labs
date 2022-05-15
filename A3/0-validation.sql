USE [dbms-a3]
GO


CREATE OR ALTER PROCEDURE validateName (@name VARCHAR(30)) AS
    IF @name IS NULL OR LEN(@name) < 2
        RAISERROR ('Invalid name', 14, 1)
GO

CREATE OR ALTER PROCEDURE validateValue (@value REAL) AS
    IF @value IS NULL OR @value < 0
        RAISERROR ('Invalid value', 14, 1)
GO


CREATE OR ALTER PROCEDURE validateT (@name VARCHAR(30), @value REAL) AS
    EXEC validateName @name
    EXEC validateValue @value
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
