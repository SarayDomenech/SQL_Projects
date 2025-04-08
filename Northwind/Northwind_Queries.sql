

# Saray Domenech 
# 01/04/2025
# Project: Northwind Data Analysis
# Description: A set of queries with different difficulty levels to master SQL. Includes basic queries, aggregation, subqueries, JOINs, and Views. 

USE northwind 

# 1.Total quantity of products 
SELECT COUNT(*) as Total_Products FROM products;

# 2. Number of customers by country
SELECT Country, COUNT(CustomerID) as Total_Customers FROM customers
GROUP BY Country;

# 3. Orders after 1997
SELECT COUNT(OrderID) AS Total_orders_After_1997 FROM Orders
WHERE OrderDate >= '1997-01-01';

# 4. Products with a price above 50 and from category 1.
SELECT ProductID, ProductName, CategoryID, Price FROM products
WHERE price > 50 AND CategoryID = 1 ;

# 5. Number of employees by year of birth
SELECT YEAR(BirthDate) AS Birth_Year, COUNT(EmployeeID) AS Total_Employees FROM employees
GROUP BY YEAR(BirthDate);

# 6. Top 3 highest prices of products that belong to category 2
SELECT ProductName, Price FROM products
WHERE CategoryID = 2
ORDER BY Price DESC LIMIT 3;

# 7. Suppliers from Germany  
SELECT SupplierName FROM suppliers
WHERE Country = 'Germany';

# 8. Orders with more than 4 products
SELECT OrderID, COUNT(ProductID) AS Total_Products FROM OrderDetails
GROUP BY OrderID
HAVING COUNT(ProductID) >= 4
ORDER BY Total_Products DESC;

# 9. Number of products by category 
SELECT CategoryID, COUNT(ProductID) AS Total_Products FROM products
GROUP BY CategoryID;

# 10. Average product price
SELECT AVG(Price) AS AVG_Price FROM products;

# 11. Top 3 customers with the most orders made. 
SELECT CustomerName, COUNT(OrderID) AS Total_Orders FROM customers c JOIN orders o
ON c.customerid = o.customerid
GROUP BY c.customerid
ORDER BY Total_Orders DESC LIMIT 3;

# 12. Products never included in any order. 
SELECT p.productid, p.Productname FROM products p LEFT JOIN orderdetails od ON
p.productid = od.productid
WHERE od.orderdetailid IS NULL;

# 13. Orders with more than two products
SELECT o.OrderID, COUNT(od.ProductID) AS Total_Products FROM OrderDetails od JOIN Orders o ON
o.OrderID = od.OrderID 
GROUP BY o.OrderID
HAVING COUNT(od.ProductID) > 2;

# 14. First and last names of employees who made orders before September 1996
SELECT e.FirstName, e.LastName FROM Employees e JOIN Orders o ON
e.employeeid = o.employeeid
WHERE o.Orderdate <= '1996-09-01'
GROUP BY e.employeeid, e.FirstName, e.LastName;

# 15. Suppliers with average prices above 40
SELECT s.suppliername, ROUND(AVG(p.price),2) AS AVG_Price FROM Suppliers s JOIN Products p ON
s.supplierid = p.supplierid
GROUP BY s.suppliername
HAVING AVG(p.price) > 40; 

# 16. Categories with more than 5 products 
SELECT c.Categoryname, COUNT(p.productID) AS Total_Products FROM categories c JOIN products p ON
c.categoryid = p.categoryid
GROUP BY c.categoryname
HAVING COUNT(p.productID) >=5;

# 17. Countries with more than three clients, sorted in descending order. 
SELECT Country, COUNT(CustomerID) AS Total_Custumers FROM Customers 
GROUP BY Country
HAVING COUNT(CustomerID) > 3
ORDER BY Total_Custumers DESC;

# 18. Top 5 most expensive products in the 'Beverages' category
SELECT p.ProductName, c.CategoryName, p.Price FROM Products p JOIN Categories c ON 
p.CategoryID = c.CategoryID
WHERE c.CategoryName = 'Beverages'
ORDER BY p.Price DESC LIMIT 5;

# 19. Names of products whose price is higher than the average product price. 
SELECT ProductName, Price FROM Products 
WHERE Price > (SELECT AVG(Price) FROM Products)
ORDER BY Price DESC; 

# 20. Create a view called 'PremiumProducts' that shows products with a price greater than double the average, and use it to filter those in the 'Beverages' category.
CREATE VIEW Premiumproducts AS
SELECT p.ProductID, p.ProductName, p.Price, p.CategoryID FROM Products p 
WHERE p.Price > 2*(SELECT AVG(Price) FROM Products);


SELECT ppm.ProductName, ppm.Price, c.CategoryName FROM Premiumproducts ppm JOIN Categories c ON
ppm.CategoryID =c.CategoryID 
WHERE c.categoryname = 'Beverages'
ORDER BY ppm.Price DESC;

# 21. Product with the highest price compared to the average of its supplier's products.
SELECT p.ProductName, s.SupplierName, p.Price FROM Products p JOIN Suppliers s ON
p.SupplierID =s.SupplierID
WHERE p.Price > (SELECT AVG(pp.Price) FROM Products pp WHERE pp.SupplierID = p.SupplierID)
ORDER BY p.Price DESC; 