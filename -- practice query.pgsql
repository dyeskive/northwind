-- practice query

-- -- Show all info about CompanyName and Address from the Customers table.
-- SELECT company_name, address 
-- FROM customers;

-- -- Show all info about CompanyName and ContactPerson from the Suppliers table.
-- SELECT company_name, contact_name
-- FROM suppliers;

-- -- Show all info about ProductName and UnitPrice from the Products table.
-- SELECT product_name, unit_price
-- FROM products;

-- -- Show all info about LastName, FirstName, BirthDate and HireDate of Employees
-- SELECT last_name, first_name, birth_date, hire_date
-- FROM employees;

-- -- Show all info about the employee with ID 8
-- SELECT *
-- FROM employees as e
-- WHERE employee_id = 8;

-- -- Show the list of first and last names of the employees from London.
-- SELECT first_name, last_name
-- FROM employees as e
-- WHERE city = 'London';

-- -- Show the list of first, last names and ages of the employees whose age is greater than 65.
-- SELECT e.first_name, e.last_name, e.birth_date
-- FROM employees as e
-- WHERE EXTRACT(YEAR FROM AGE(CURRENT_DATE, e.birth_date)) > 65;

-- -- Show the list of products with the price between 10 and 50.
-- SELECT *
-- FROM products as p
-- WHERE p.unit_price BETWEEN 10 AND 50;

-- -- Show cities where there are more than 1 employee;
-- SELECT e.city, COUNT(e.city)
-- FROM employees as e 
-- GROUP BY e.city
-- HAVING COUNT(e.city) > 1
-- ORDER BY COUNT(e.city) ASC;


-- -- Show the list of products which names start form ‘N’ and price is greater than 20.
-- SELECT product_name, unit_price
-- FROM products
-- WHERE unit_price > 20 AND product_name LIKE 'N%'


-- -- Show the total number of employees which live in the same city.
-- SELECT city, count(employee_id)
-- FROM employees
-- GROUP BY city
-- ORDER BY count(employee_id) DESC


-- -- Calculate the count of customers from Mexico and contact signed as ‘Owner’.
-- SELECT count(c.customer_id)
-- from customers as c
-- WHERE c.country = 'Mexico' and contact_title = 'Owner'

-- --Write a query to get most expense and least expensive Product list (name and unit price).
-- SELECT product_name, unit_price
-- FROM products as p
-- order by unit_price desc
-- limit 1;

-- SELECT product_name, unit_price
-- FROM products as p
-- order by unit_price asc
-- limit 1;

-- -- Write a query to get Product list (name, unit price) of above average price.
-- SELECT 
--     p.product_name
--     ,p.unit_price
--     ,avg_price.avg
-- FROM 
--     products as p
--     ,(SELECT avg(unit_price) as avg FROM products) as avg_price
-- WHERE 
--     p.unit_price > avg_price.avg

-- -- For each employee that served the order (identified by employee_id), calculate a total freight.
-- SELECT 
--     employee_id
--     , sum(freight)
-- FROM 
--     orders as o
-- GROUP BY 
--     employee_id

-- -- Calculate the greatest, the smallest and the average age among the employees from London.
-- SELECT
--     e.*
--     ,age
-- FROM
--     employees as e
--     ,EXTRACT(YEAR FROM AGE(birth_date)) as age
-- WHERE
--     e.city = 'London'
--     AND age = (SELECT max(EXTRACT(YEAR FROM AGE(birth_date)))
--                 FROM employees as e1
--                 WHERE e1.city = 'London')


-- SELECT
--     e.first_name
--     ,e.last_name
--     ,e.birth_date
--     ,age
-- FROM
--     employees as e
--     ,EXTRACT(YEAR FROM AGE(birth_date)) as age
-- WHERE
--     e.city = 'London'
--     AND age = (SELECT min(EXTRACT(YEAR FROM AGE(birth_date)))
--                 FROM employees as e1
--                 WHERE e1.city = 'London')

-- SELECT
--     avg(age)
-- FROM
--     employees as e
--     ,EXTRACT(YEAR FROM AGE(birth_date)) as age
-- WHERE
--     e.city = 'London'


-- -- Calculate the greatest, the smallest and the average age of the employees for each city.
-- SELECT
--     e.city
--     ,max(age) max_age
--     ,min(age) min_age
--     ,avg(age) avg_age
-- FROM
--     employees as e
--     ,EXTRACT(YEAR FROM AGE(birth_date)) as age
-- GROUP BY
--     e.city;


-- -- Show the list of cities in which the average age of employees is greater than 60 (the average age is also to be shown)
-- SELECT
--     e.city
--     ,avg(age) avg_age
-- FROM
--     employees as e
--     ,EXTRACT(YEAR FROM AGE(birth_date)) as age
-- GROUP BY
--     e.city
-- HAVING
--     avg(age) > 60;


-- -- Show first, last names and ages of 3 eldest employees.
-- SELECT
--     e.first_name
--     ,e.last_name
--     ,e.birth_date
--     ,age
-- FROM
--     employees as e
--     ,EXTRACT(YEAR FROM AGE(birth_date)) as age
-- ORDER BY
--     age DESC
-- LIMIT 3;


-- -- Show first and last names of the employees as well as the count of orders each of them have received during the year 1997.
-- SELECT 
--     e.first_name
--     ,e.last_name
--     ,count(o.order_id) as order_count
-- FROM employees as e LEFT JOIN orders as o
--     ON e.employee_id = o.employee_id
--     AND EXTRACT(YEAR FROM o.order_date) = 1997
-- GROUP BY
--     e.first_name
--     ,e.last_name
-- ORDER BY 
--     order_count DESC

-- -- Show first and last names of the employees as well as the count of their orders shipped after required date during the year 1997.
-- SELECT 
--     e.first_name
--     ,e.last_name
--     ,count(o.order_id) as order_count
-- FROM employees as e LEFT JOIN orders as o
--     ON e.employee_id = o.employee_id
--     AND EXTRACT(YEAR FROM o.order_date) = 1997
--     AND o.shipped_date > o.required_date
-- GROUP BY
--     e.first_name
--     ,e.last_name
-- ORDER BY 
--     order_count DESC

-- -- Show the list of suppliers, products and its category.
-- SELECT 
--     c.category_name
--     ,p.product_name
--     ,s.company_name as supplier
-- FROM suppliers as s
--     LEFT JOIN products as p
--         ON s.supplier_id = p.supplier_id
--     LEFT JOIN categories as c
--         ON p.category_id = c.category_id


-- -- Create a report that shows all information about suppliers and products.
-- SELECT *
-- FROM suppliers as s
--     LEFT JOIN products as p
--         ON s.supplier_id = p.supplier_id


-- -- Show, for each product, the associated Supplier from Germany and Spain. 
-- -- Show the ProductID, ProductName, and the CompanyName of the Supplier. Sort by ProductID.
-- SELECT 
--     p.product_id
--     ,p.product_name
--     ,s.company_name
-- FROM products as p
--     JOIN suppliers as s
--         ON p.supplier_id = s.supplier_id
--         AND s.country IN ('Germany', 'Spain')
-- ORDER BY
--     p.product_id


-- --We’d like to show a list of the Orders that were made, including the Shipper that was used. Show the OrderID, OrderDate (date only with alias ShortDate), and CompanyName of the Shipper, and sort by OrderID. Show only those rows with an OrderID of less than 10260.
-- SELECT
--     o.order_id
--     ,o.order_date as short_date
--     ,s.company_name
-- FROM orders as o
--     JOIN shippers as s
--         ON o.ship_via = s.shipper_id
--         AND o.order_id < 10260
-- ORDER BY
--     o.order_id


-- -- We're doing inventory, and need to show information about OrderID, a list of products, and their quantity for orders which were shipped by Leverling Janet with quantities greater than 50.
-- -- The result should be sorted by Quantity.
-- SELECT
--     o.order_id
--     ,p.product_name
--     ,od.quantity
-- FROM
--     orders as o
-- JOIN 
--     order_details as od ON o.order_id = od.order_id
-- JOIN 
--     products as p ON od.product_id = p.product_id
-- JOIN 
--     employees as e ON o.employee_id = e.employee_id
-- WHERE
--     od.quantity > 50 
--     AND TRIM(e.first_name) = 'Janet' 
--     AND TRIM(e.last_name) = 'Leverling'
-- ORDER BY
--     od.quantity


-- -- There are some customers who have never actually placed an order. Show these customers.
-- SELECT
--     c.company_name
-- FROM
--     customers as c
--     LEFT JOIN orders as o 
--     ON c.customer_id = o.customer_id
-- WHERE
--     o.order_id IS NULL


-- -- One employee (Margaret Peacock, EmployeeID 4) has placed the most orders. However, there are some customers who've never placed an order with her. Show only those customers who have never placed an order with her.
-- SELECT
--     c.company_name
-- FROM
--     customers as c
--     LEFT JOIN orders as o
--     ON c.customer_id = o.customer_id
--     AND o.employee_id = 4
-- WHERE
--     o.customer_id IS NULL

-- SELECT
--     c.customer_id
--     ,c.company_name
--     ,o.order_id
--     ,od.quantity * od.unit_price as TotalOrderAmount
--     ,od.discount
-- FROM
--     customers as c
--     LEFT JOIN orders as o
--         ON c.customer_id = o.customer_id
--         AND EXTRACT(YEAR FROM o.order_date) = 1997
--     LEFT JOIN order_details as od
--         ON o.order_id = od.order_id
-- WHERE
--     o.order_id IS NOT NULL
--     AND od.quantity * od.unit_price >= 10000


-- --Show the 10 orders with the most line items, in order of total line items.
-- SELECT 
--     od.order_id
--     ,count(od.order_id) as TotalOrderLines
-- FROM order_details as od
-- GROUP BY
--     od.order_id
-- ORDER BY
--     TotalOrderLines DESC
-- LIMIT 10

-- --Which salespeople have the most orders arriving late?
-- SELECT
--     o.employee_id
--     ,e.last_name
--     ,count(o.order_id) as TotalLateOrders
-- FROM orders as o
--     JOIN employees as e
--         ON o.employee_id = e.employee_id
--         AND o.shipped_date > o.required_date
-- GROUP BY
--     o.employee_id
--     ,e.last_name
-- ORDER BY
--     TotalLateOrders DESC


-- -- Create a report that shows the CompanyName and total number of orders by the customer since December 31, 2015. 
-- -- Show the number of Orders greater than 10. Use alias NumberofOrders for the calculated column
-- SELECT
--     c.company_name
--     ,count(o.order_id) as NumberofOrders
-- FROM
--     customers as c
--     JOIN orders as o
--         ON c.customer_id = o.customer_id
--         AND o.order_date > '1997-01-01'
-- GROUP BY
--     c.company_name
-- HAVING
--     count(o.order_id) > 10

-- -- Create a report that shows the EmployeeID, the LastName and FirstName as Employee (alias), and the LastName and FirstName of who they report to as Manager (alias)
-- SELECT
--     e1.employee_id
--     ,e1.first_name || ' ' || e1.last_name as Employee
--     ,e2.first_name || ' ' || e2.last_name as Manager
-- FROM
--     employees as e1
--     LEFT JOIN employees as e2
--         ON e1.reports_to = e2.employee_id

-- -- Create a report that shows the  ContactName of customer, TotalSum (alias for the calculated column UnitPrice*Quantity*(1-Discount)) from the Order Details, and Customers table with the discount given on every purchase. Show only VIP customers with TotalSum greater than 10000. Round the TotalSum to 2 decimal places.
-- SELECT
--     c.contact_name,
--     round(sum(od.quantity * od.unit_price * (1-od.discount)) * 100) / 100 as TotalSum
-- FROM
--     customers as c
-- JOIN orders as o
--     ON c.customer_id = o.customer_id
-- JOIN order_details as od
--     ON o.order_id = od.order_id
-- GROUP BY
--     c.contact_name
-- HAVING
--     sum(od.quantity * od.unit_price * (1-od.discount)) > 10000


-- -- Create a report that shows the total quantity of products (alias TotalUnits)
-- -- ordered. Only show records for products for which the quantity ordered is fewer than 200. 
-- SELECT
--     p.product_name
--     ,sum(od.quantity) as TotalUnits
-- FROM
--     products as p
--     JOIN order_details as od
--         ON p.product_id = od.product_id
-- GROUP BY
--     p.product_name
-- HAVING
--     sum(od.quantity) < 200

-- SELECT
--     c.company_name
--     ,count(o.order_id) as NumOrders
-- FROM
--     customers as c
--     JOIN orders as o
--         ON c.customer_id = o.customer_id
--         AND o.order_date > '1997-01-01'
-- GROUP BY
--     c.company_name
-- HAVING
--     count(o.order_id) > 5
-- ORDER BY
--     NumOrders DESC


-- SELECT
--     c.company_name
--     ,o.order_id
--     ,sum(od.quantity * od.unit_price) as TotalPrice
-- FROM
--     customers as c
--     JOIN orders as o
--         ON c.customer_id = o.customer_id
--     JOIN order_details as od
--         ON o.order_id = od.order_id
-- GROUP BY
--     c.company_name
--     ,o.order_id
-- HAVING
--     sum(od.quantity * od.unit_price) > 10000
-- ORDER BY
--     TotalPrice DESC


-- SELECT
--     count(e.employee_id) as NumEmployees
--     ,count(c.customer_id) as NumCustomers
--     ,e.city
-- FROM
--     employees as e
--     JOIN customers as c
--         ON e.city = c.city
-- GROUP BY
--     e.city

-- --Create a report that shows the number of employees (alias numEmployees) and number of customers (alias numCompanies) from each city that has employees in it.
-- SELECT
--     e.city
--     ,count(DISTINCT e.employee_id) as NumEmployees
--     ,count(DISTINCT c.customer_id) as NumCustomers
-- FROM
--     employees as e
--     JOIN customers as c
--         ON e.city = c.city
-- GROUP BY
--     e.city


-- --Get the lastname and firstname of employee (alias Name), company names and phone numbers (alias Phone) of all employees, customers, and suppliers, who are situated in London.
-- --Add the column (alias Type) to the result set which should specify what type of counterparty (employee, customer, or supplier) it is.
-- SELECT
--     e.last_name || ' ' || e.first_name as Name
--     ,e.home_phone as phone
--     ,'employee' as Type
-- FROM
--     employees as e
-- WHERE
--     e.city = 'London'
-- UNION
-- SELECT
--     c.company_name
--     ,c.phone
--     ,'customer' as Type
-- FROM
--     customers as c
-- WHERE
--     c.city = 'London'
-- UNION
-- SELECT
--     s.company_name
--     ,s.phone
--     ,'supplier' as Type
-- FROM
--     suppliers as s
-- WHERE
--     s.city = 'London'
-- ORDER BY type

-- -- Write the query which would show the list of employees (FirstName and LastName) and their total sales (alias TotalSales) who have sold more than 200 positions of products.
-- SELECT
--     e.first_name
--     ,e.last_name
--     --,count(od.product_id)
--     ,sum(od.quantity * od.unit_price * (1-od.discount)) as TotalSales
-- FROM
--     employees as e
--     JOIN orders as o
--         ON e.employee_id = o.employee_id
--     JOIN order_details as od
--         ON o.order_id = od.order_id
-- GROUP BY
--     e.first_name
--     ,e.last_name
-- HAVING
--     count(od.product_id)>200


-- --Write the query which would show the names of employees who sell the products of more than 25 suppliers during the 2016 year.
-- SELECT
--     e.first_name
--     ,e.last_name
--     ,count(DISTINCT p.supplier_id) as NumSuppliers
-- FROM
--     employees as e
--     JOIN orders as o
--         ON e.employee_id = o.employee_id
--     JOIN order_details as od
--         ON o.order_id = od.order_id
--     JOIN products as p
--         ON od.product_id = p.product_id
-- -- WHERE
-- --     o.order_date BETWEEN '2016-01-01' AND '2016-12-31'
-- GROUP BY
--     e.first_name
--     ,e.last_name
-- HAVING
--     count(DISTINCT p.supplier_id) > 25

-- SELECT od1.order_id
-- FROM order_details AS od1
-- JOIN order_details AS od2 ON od1.Order_ID = od2.Order_ID
-- JOIN orders AS o ON od1.Order_ID = o.Order_ID
-- WHERE o.employee_id = (SELECT employee_id FROM employees WHERE last_name = 'Leverling')
--     AND od1.Product_ID != od2.Product_ID 
--     AND od1.Quantity = od2.Quantity
--     --AND od1.Quantity >= 60
-- GROUP BY od1.Order_ID


-- -- We know that Andrew Fuller is the Vice President of Northwind Company. Create the report that shows the list of those employees (last and first name) who were hired earlier than Fuller.
-- SELECT e.last_name, e.first_name, e.hire_date
-- FROM employees AS e
-- WHERE e.hire_date < (SELECT hire_date FROM employees WHERE last_name = 'Fuller')


-- -- Write the query which should create the list of products and their unit price for products with price greater than average products' unit price
-- SELECT
--     p.product_name
--     ,p.unit_price
-- FROM
--     products as p
-- WHERE
--     p.unit_price > (SELECT AVG(p.unit_price) FROM products AS p)


-- SELECT
--     c.company_name
-- FROM customers c
-- JOIN orders o ON c.customer_id = o.customer_id
--     AND c.country = 'Germany'
-- WHERE EXTRACT(YEAR FROM order_date) = '2016'


SELECT
    o.shipped_date
    ,count(DISTINCT o.order_id) as NumberOfOrders
    ,sum(od.Total) as Total
FROM
    orders as o
    JOIN (
        SELECT
            od.order_id
            ,round(od.unit_price*od.quantity*(1-od.discount)*100)/100 as Total
        FROM
            order_details as od
    ) as od
        ON o.order_id = od.order_id
WHERE o.shipped_date BETWEEN '1997-01-01' AND '1997-03-31'
GROUP BY
    o.shipped_date
HAVING
    count(DISTINCT o.order_id) > 3
    

