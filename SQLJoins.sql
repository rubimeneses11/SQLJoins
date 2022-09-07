/* joins: select all the computers from the products table:
using the products table and the categories table, return the product name and the category name */

 -- products table and categories table SHARE categoryID
 SELECT p.Name AS products , c.Name AS category -- columns with aliases
 FROM Products AS p -- table 1 with alias
 INNER JOIN Categories AS c ON p.CategoryID = c.CategoryID -- table 2 with alias & shared key
 WHERE c.Name = 'computers'; -- filter to only output computers
 
/* joins: find all product names, product prices, and products ratings that have a rating of 5 */

-- product table and reviews table share ProductID
-- condition will be rating of 5
SELECT p.Name AS products, p.Price AS price, r.Rating AS rating
FROM Products AS p
INNER JOIN Reviews AS r ON p.ProductID = r.ProductID
WHERE r.Rating = 5;
 
/* joins: find the employee with the most total quantity sold.  use the sum() function and group by */

-- tables share employeeID
SELECT employees.FirstName, employees.LastName, SUM(sales.Quantity) AS Total -- columns we wanna see w/alias for the sum
FROM Sales -- table one
INNER JOIN Employees ON employees.EmployeeID = sales.EmployeeID -- table two 
GROUP BY employees.EmployeeID -- allows employee info to be grouped with sales to prevent from only getting the sum of all sales
ORDER BY Total DESC 
LIMIT 2; -- gives 2 rows

/* joins: find the name of the department, and the name of the category for Appliances and Games */

-- both tables share departmentID
SELECT c.Name AS category, d.Name AS name
FROM Departments AS d
INNER JOIN Categories AS c ON c.DepartmentID = d.DepartmentID
WHERE c.Name = 'Games' OR c.Name = 'Appliances';

/* joins: find the product name, total # sold, and total price sold,
 for Eagles: Hotel California --You may need to use SUM() */
 
 SELECT p.Name AS product, -- we wanna see product name (Eagles: Hotel California)
 SUM(s.Quantity) AS TotalNumberSold, -- plus the sum of the quantity
 SUM(s.Quantity * s.PricePerUnit) AS TotalPriceSold -- quantity x price per unit per each transaction and then adding them all together
 FROM Sales AS s -- table one
 INNER JOIN Products AS p ON s.ProductID = p.ProductID -- table two // they both share productID
 WHERE p.Name = 'Eagles: Hotel California'; -- filter by the product we want

/* joins: find Product name, reviewer name, rating, and comment on the Visio TV. (only return for the lowest rating!) */

-- will be using products and reviews table, shared key = productID
-- display columns: product name (Visio TV), reviewer name, rating, & comment. Filter to lowest rating
SELECT products.Name, reviews.Reviewer, reviews.Rating, reviews.Comment -- columns displayed
FROM Reviews -- table one
INNER JOIN Products ON products.ProductID = reviews.ProductID -- table two and common key
WHERE products.Name = 'Visio TV' AND reviews.Rating = 1; -- filter by product name where the rating is the lowest


-- ------------------------------------------ Extra - May be difficult
/* Your goal is to write a query that serves as an employee sales report.
This query should return:
-  the employeeID
-  the employee's first and last name
-  the name of each product
-  and how many of that product they sold */

-- employees, sales, & products table will be used // common keys: employee & sales --> employeeID, sales & products --> productID
-- display employeeID, first name, last name, name of products sold, quantity of ea. product they sold

SELECT employees.EmployeeID, employees.FirstName, employees.LastName, products.Name AS ProductSold, SUM(sales.Quantity) AS TotalSold
FROM Sales
INNER JOIN Employees ON employees.EmployeeID = sales.EmployeeID
INNER JOIN Products ON products.ProductID = sales.ProductID
GROUP BY employees.EmployeeID, products.ProductID
ORDER BY TotalSold DESC;