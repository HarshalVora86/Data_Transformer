CREATE DATABASE IF NOT EXISTS corp_data_hub;

USE corp_data_hub;

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers(
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Firstname VARCHAR(30),
    Lastname VARCHAR(30),
    Email VARCHAR(50),
    Registrationdate DATE
);

INSERT INTO Customers(Firstname, Lastname, Email, Registrationdate)
VALUES
('john','doe','   john.doe@gmail.com  ','2022-03-15'),
('jane','smith','  jane.smith@gmail.com   ','2021-11-02'),
('michael','johnson','mjohnson@gmail.com  ','2020-06-20'),
('emily','davis','  emily.davis@gmail.com','2023-01-10'),
('robert','brown',' rbrown@gmail.com'    ,'2019-08-14'),
('sarah','wilson','sarah.w@gmail.com   ','2022-12-05'),
('david','taylor','david.t@gmail.com','2021-04-18'),
('laura','anderson','laura.a@gmail.com','2023-07-22'),
('james','thomas','james.t@gmail.com','2020-09-30'),
('olivia','martin','olivia.m@gmail.com','2022-05-11');


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Order_date DATE,
    Total_amount DECIMAL(10,2)
);
 
INSERT INTO Orders (OrderID, CustomerID, Order_date, Total_amount) 
VALUES
(100,1,'2023-07-01',150.90),
(101,2,'2023-07-03',260.75),
(102,3,'2023-06-15',540.00),
(103,4,'2023-08-20',89.99),
(104,5,'2023-05-10',1200.50),
(105,6,'2023-09-01',375.00),
(106,7,'2023-07-25',620.30),
(107,8,'2023-08-15',45.00),
(108,1,'2023-09-10',980.00),
(109,10,'2023-06-28',310.60);


CREATE TABLE Employees(
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(10,2)
);
 
INSERT INTO Employees(EmployeeID, FirstName, LastName, Department, HireDate, Salary)
VALUES
(1,'Mark','Johnson','Sales','2020-01-15',50000.00),
(2,'Susan','Lee','HR','2021-03-20',55000.00),
(3,'Carlos','Rivera','IT','2019-07-11',72000.00),
(4,'Angela','White','Sales','2022-05-30',48000.00),
(5,'Brian','Hall','Finance','2018-11-01',85000.00),
(6,'Nancy','Young','IT','2020-09-15',69000.00),
(7,'Kevin','Scott','HR','2023-02-10',52000.00),
(8,'Rachel','Green','Finance','2017-06-25',91000.00),
(9,'Tom','Harris','Sales','2021-08-05',47000.00),
(10,'Diana','Clark','IT','2022-12-01',76000.00);


SELECT c.*, o.* FROM Customers c INNER JOIN Orders o 
ON c.CustomerID = o.CustomerID;

SELECT c.*, o.* FROM Customers c LEFT JOIN Orders o 
ON c.CustomerID = o.CustomerID;

SELECT o.*,c.* FROM Customers c RIGHT JOIN Orders o 
ON c.CustomerID = o.CustomerID;

SELECT c.*, o.* FROM Customers c LEFT JOIN Orders o 
ON c.CustomerID = o.CustomerID
UNION
SELECT c.*, o.* FROM Customers c RIGHT JOIN Orders o 
ON c.CustomerID = o.CustomerID;

SELECT c.CustomerID, c.Firstname, c.Lastname, o.OrderID, o.Order_date, o.Total_amount 
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID 
WHERE o.Total_amount > (SELECT AVG(Total_amount) AS avg_amount FROM Orders);

SELECT EmployeeID, FirstName, LastName, Department, Salary FROM Employees 
WHERE Salary > (SELECT AVG(Salary) AS avg_salary FROM Employees);

SELECT *, YEAR(Order_date) AS YEAR, MONTH(Order_date) AS MONTH FROM Orders;

SELECT OrderID, Order_date, CURDATE(), TIMESTAMPDIFF(day, Order_date, curdate()) AS diff_in_days FROM Orders;

SELECT *, DATE_FORMAT(Order_date, "%d-%M-%Y") AS DIFF_DATE_FORMAT FROM Orders;

SELECT EmployeeID, FirstName, LastName, CONCAT(FirstName,' ',LastName) AS full_name FROM Employees;

SELECT *, REPLACE(Firstname, 'john','jonathan') AS replace_name FROM Customers;

SELECT EmployeeID, UPPER(Firstname) AS uppercase, LOWER(Lastname) AS lowercase FROM Employees;

SELECT CustomerID, Firstname, Lastname, Email , TRIM(Email) AS trim_email FROM Customers;

SELECT *, SUM(Total_amount) OVER(ORDER BY Total_amount) AS running_total_amt FROM Orders;

SELECT *, RANK() OVER(ORDER BY Total_amount DESC) AS ranking FROM Orders;

SELECT *, CASE 
    WHEN Total_amount > 1000 THEN '10% off'
    WHEN Total_amount > 500  THEN '5% off'
    WHEN Total_amount > 300  THEN '3% off'
    ELSE 'No discount' END AS discount FROM Orders;

SELECT *, CASE 
    WHEN Salary > 80000 THEN 'High'
    WHEN Salary > 60000 THEN 'Medium'
    ELSE 'Low' END AS salary_category FROM Employees;



