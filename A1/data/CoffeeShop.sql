---- A1 ----
USE master
GO

DROP DATABASE IF EXISTS [CoffeeShopDB]
GO

CREATE DATABASE [CoffeeShopDB]
GO

USE [CoffeeShopDB]
GO

/*
Legend:
    () - means 1:n relationship set from ER
    [] - means the table already exists
Notes:
    1. suggestion: a procedure which determines the salary based on the interval and earning rate
*/

-- Position 1:n Salaray
CREATE TABLE Position (
    pid int IDENTITY(1,1) PRIMARY KEY,
    pname varchar(max) NOT NULL,
    pearningRate real NOT NULL)
GO

-- Schedule 1:n Salary
CREATE TABLE Schedule (
    scid int IDENTITY(1,1) PRIMARY KEY ,
    scstart time(0) NOT NULL,
    scend time(0) NOT NULL)
GO

-- Employee 1:1 Salary
-- Employee 1:n DiningTable
CREATE TABLE Employee (
    eid int IDENTITY(1,1) PRIMARY KEY,
    ename varchar(max) NOT NULL,
    eworkingSince date NOT NULL,
    etrustFactor real,
    CONSTRAINT CHK_etrustFactor CHECK (etrustFactor >= 0 AND etrustFactor <= 1))
GO

-- DiningTable 1:n Ordering
CREATE TABLE Salary (
    said int IDENTITY(1,1),
    savalue money NOT NULL,
    pidfk int,
    scidfk int,
    eidfk int UNIQUE,
    CONSTRAINT PK_said PRIMARY KEY (said),
    CONSTRAINT FK_pid_Position_to_Salary FOREIGN KEY (pidfk) REFERENCES Position (pid) ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT FK_scid_Schedule_to_Salary FOREIGN KEY (scidfk) REFERENCES Schedule (scid) ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT FK_eid_Employee_to_Salary FOREIGN KEY (eidfk) REFERENCES Employee (eid) ON UPDATE CASCADE ON DELETE SET NULL)
GO

CREATE TABLE DiningTable (
    tid int IDENTITY(1,1) PRIMARY KEY,
    tusage tinyint,
    tcapacity tinyint NOT NULL,
    eidfk int,
    CONSTRAINT FK_eid_Employee_to_DiningTable FOREIGN KEY (eidfk) REFERENCES Employee (eid) ON UPDATE CASCADE ON DELETE SET NULL)
GO

-- Ordering -- Contains_product -- Product (m:n)
CREATE TABLE Ordering (
    oid int IDENTITY(1,1) PRIMARY KEY,
    ostatus varchar(max) NOT NULL, -- not taken/placed/prepared/delivered/payed
    odatetime datetime, -- placedAt
    tidfk int,
    CONSTRAINT FK_tid_DiningTable_to_Ordering FOREIGN KEY (tidfk) REFERENCES DiningTable (tid) ON UPDATE CASCADE ON DELETE SET NULL)
GO

CREATE TABLE Product (
    pid int IDENTITY(1,1) PRIMARY KEY,
    pname varchar(max) NOT NULL,
    ptype varchar(max) NOT NULL,
    pbaseSubstance varchar(max),
    pmass int NOT NULL, -- measured in miligrams
    pprice money NOT NULL,
    pcustomerExperience tinyint,
    CONSTRAINT CHK_pcustomerExperience CHECK (pcustomerExperience >= 1 AND pcustomerExperience <=5))
    --pretailer varchar(max),
    --pflavourable bool,
GO

CREATE TABLE Contains_product (
    cpid int IDENTITY(1,1),
    oidfk int,
    pidfk int,
    quantity tinyint NOT NULL,
    PRIMARY KEY (cpid, oidfk, pidfk), -- added for A4
    CONSTRAINT FK_oid_Ordering_to_Contains_product FOREIGN KEY (oidfk) REFERENCES Ordering (oid) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_pid_Product_to_Contains_product FOREIGN KEY (pidfk) REFERENCES Product (pid) ON UPDATE CASCADE ON DELETE CASCADE)
GO

-- [Ordering] -- Contains_flavor -- Flavor
CREATE TABLE Flavor (
    fid int IDENTITY(1,1) PRIMARY KEY,
    fname varchar(max) NOT NULL,
    --fbaseSubstance varchar(max) NOT NULL,
    fmass int NOT NULL, -- measured in miligrams
    fprice money NOT NULL)
GO

CREATE TABLE Contains_flavor (
    oidfk int,
    fidfk int,
    quantity int NOT NULL,
    CONSTRAINT FK_oid_Ordering_to_Contains_flavor FOREIGN KEY (oidfk) REFERENCES Ordering (oid) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_fid_Flavor_to_Contains_flavor FOREIGN KEY (fidfk) REFERENCES Flavor (fid) ON UPDATE CASCADE ON DELETE CASCADE)
GO

 -- Flavors
-- banana
-- vanilla
-- chocoalte
-- white chocolate
-- cocos
-- strawberries
-- cinnamon

INSERT INTO Position VALUES
('Manager', 11), -- 1
('Accountant', 10.5), -- 2
('Cook', 10), -- 3
('Brewer', 9), -- 4
('Waiter', 8.5), -- 5
('Cashier', 7.5), -- 6
('Janitor', 7) -- 7
GO


INSERT INTO Schedule VALUES
('00:00:00', '08:00:00'),
('08:00:00', '16:00:00'),
('16:00:00', '23:59:59'),
('09:00:00', '17:00:00'),
('17:00:00', '23:00:00'),
('20:30:00', '03:30:00')
GO


INSERT INTO Employee VALUES
('Employee 1', '2015-12-20', 0.2),
('Employee 2', '2015-12-23', 0.2),
('Employee 3', '2017-01-10', 0.17),
('Employee 4', '2017-03-15', 0.15),
('Employee 5', '2017-03-21', 0.13),
('Employee 6', '2020-09-01', 0.11),
('Employee 7', '2021-01-01', 0.07),
('Employee 8', '2021-06-01', 0.04),
('Employee 9', '2021-11-06', NULL)
GO

-- Value, Position, Schedule, Employee
INSERT INTO Salary VALUES
(2956.8, 1, 4, 1), -- Manager
(2419.2, 4, 2, 2), -- Brewer 1
(2227.68, 5, 2, 3), -- Waiter 1
(2576, 3, 2, 4), -- Cook 1
(1771.84, 7, 2, 5), -- Janitor
(1989.12, 4, 3, 6) -- Brewer 2
GO

-- Usage, Capacity, Employee
INSERT INTO DiningTable VALUES
(3, 5, 3),
(1, 4, 3),
(3, 5, 3)
GO

-- Status, PlacedAt, DiningTable
INSERT INTO Ordering VALUES
('delivered', '2021-11-07 13:03:54', 1),
('payed', '2021-11-07 12:45:39', 2),
('not taken', NULL, 3)
GO

-- Name, Type, BaseSubstance, Mass, Price, CustomerExperience
INSERT INTO Product VALUES
('Espresso', 'Beverage: Coffee', 'coffee beans', 100, 2, NULL),
('Short Coffee', 'Beverage: Coffee', 'coffee beans', 120, 2, 5),
('Long Cofee', 'Beverage: Coffee', 'coffee beans', 240, 4, NULL),
('Hot Chocolate', 'Beverage: Chocolate', 'milk, cocoa', 240, 4, NULL),
('Cappuccino', 'Beverage: Coffee', 'coffee, milk', 200, 4, NULL),
('Hot Milk', 'Beverage: Milk', 'milk, sugar', 200, 4.5, 4),
('Strawberry Milkshake', 'Beverage: Milk', 'milk, strawberries', 210, 6.5, NULL),
('Lemon Lemonade', 'Beverage: Lemonade', 'lemons', 300, 5, 3),
('Orange Fresh', 'Beverage: Fresh', 'oranges', 250, 6, NULL),
('Whiskey', 'Beverage: Alcohol', 'barley', 100, 10, 3),

('Croissant', 'Dessert: Pastry', '?', 100, 2, NULL),
('Cremeschnitte', 'Dessert', 'milk?', 150, 7, 5),
('Creme Brulee', 'Dessert', '?', 200, 8, NULL),
('Classic Pancakes', 'Dessert', '?', 300, 9, 1),
('Cheesecake', 'Dessert', 'cheese?', 400, 10, 4),
('Vanilla Icecream', 'Dessert: Icecream', 'milk, vanilla', 130, 5, 2),
('Oreo Icecream', 'Dessert: Icecream', 'milk, oreo', 130, 6, NULL),
('Pistachio Icecream', 'Dessert: Icecream', 'milk, pistachios, lemon', 130, 6.5, 4),
('Salted Caramel Icecream', 'Dessert: Icecream', 'milk, salted caramel', 130, 6.5, NULL),
('Coconut Icecream', 'Dessert: Icecream', 'milk, coconut', 130, 7, 5)
GO

-- Ordering, Product, Quantity
INSERT INTO Contains_product VALUES
(1, 2, 1),
(1, 11, 1),
(2, 1, 2)
GO

-- Name, Mass, Price
INSERT INTO Flavor VALUES
('Sugar', 5, 0.2),
('Brown Sugar', 5, 0.25),
('Honey', 5, 0.32),
('Vanilla', 5, 0.3),
('Cinnamon', 5, 0.4),
('Banana', 5, 0.25),
('Chocolate', 5, 0.25),
('Oreo', 5, 0.45),
('Lemon', 5, 0.25),
('Wintergreen', 6, 0.32)
GO


-- Ordering, Flavor, Quantity
INSERT INTO Contains_flavor VALUES
(1, 1, 1),
(1, 4, 1),
(2, 9, 2)
GO
