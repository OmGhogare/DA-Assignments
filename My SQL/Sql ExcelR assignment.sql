/* Assignment Questions
Note: - 
1. The tables mentioned in the questions for the references are available in the classic model database.
2.  In the questions, if they specifically mention to create the tables, then you need to create the 	tables as per given specifications.
3. Solve all the assignment questions, organized by topic wise, within a single query tab only. Kindly submit your MySQL assignments in a single file, using a format that suits you best, such as a .sql file, Notepad, or Word document.
*/

SHOW TABLES;
SELECT * FROM employees;
-- Q1. SELECT clause with WHERE, AND, DISTINCT, Wild Card (LIKE)

	-- a. Fetch the employee number, first name and last name of those employees who are working as Sales Rep reporting to employee with employeenumber 1102 (Refer employee table)

			SELECT employeeNumber,firstname,lastname FROM employees WHERE
			jobTitle LIKE '%Sales Rep%' AND reportsTo=1102;

	-- b. Show the unique productline values containing the word cars at the end from the products table.

			SELECT * FROM products;
			SELECT distinct(productLine) from products 
			WHERE productLine LIKE '%Cars';
			
-- Q2. CASE STATEMENTS for Segmentation

    -- a.  a. Using a CASE statement, segment customers into three categories based on their country:(Refer Customers table)
                       --  "North America" for customers from USA or Canada
					   -- "Europe" for customers from UK, France, or Germany
                       -- "Other" for all remaining countries
                       -- Select the customerNumber, customerName, and the assigned region as "CustomerSegment".
		
			Select * from customers;
            
            SELECT customerNumber , customerName ,
            CASE WHEN country IN ('USA','Canada') THEN "North America"
				 WHEN  country IN ('UK','France','Germany') THEN "Europe"
				 ELSE "Other"
			END AS "CustomerSegment"
            FROM customers;


-- Q.3  Group By with Aggregation functions and Having clause, Date and Time functions

		-- a. Using the OrderDetails table, identify the top 10 products (by productCode) with the highest total order quantity across all orders.


				SELECT * FROM orderdetails;
				SELECT  productCode , SUM(quantityOrdered) AS total_ordered FROM orderdetails 
				GROUP BY productCode
				ORDER BY total_ordered DESC
				LIMIT 10;

		-- b. Company wants to analyse payment frequency by month. Extract the month name from the payment date to count 
			  -- the total number of payments for each month and include only those months with a payment count exceeding 20. 
               -- Sort the results by total number of payments in descending order.  (Refer Payments table). 
               
               SELECT * FROM payments;
               
               SELECT DATE_FORMAT(paymentDate,'%M') AS month_name,
               COUNT(*) as total_payment
               FROM payments
               GROUP BY month_name
               HAVING total_payment>20
               ORDER BY total_payment DESC;
               




-- Q4. CONSTRAINTS: Primary, key, foreign key, Unique, check, not null, default
	-- Create a new database named and Customers_Orders and add the following tables as per the description


			-- a. .	Create a table named Customers to store customer information. Include the following columns:
					/* customer_id: This should be an integer set as the PRIMARY KEY and AUTO_INCREMENT.
					first_name: This should be a VARCHAR(50) to store the customer's first name.
					last_name: This should be a VARCHAR(50) to store the customer's last name.
					email: This should be a VARCHAR(255) set as UNIQUE to ensure no duplicate email addresses exist.
					phone_number: This can be a VARCHAR(20) to allow for different phone number formats.
					Add a NOT NULL constraint to the first_name and last_name columns to ensure they always have a value. */

						CREATE TABLE Customers2(customer_ID INT AUTO_INCREMENT PRIMARY KEY,
							  first_name VARCHAR(50) NOT NULL,
                              last_name VARCHAR(50) NOT NULL,
                              email VARCHAR(255) UNIQUE,
                              phone_number VARCHAR(20));
                              
                              describe Customers1;
							  SELECT * FROM customers1;

			-- b. Create a table named Orders to store information about customer orders. Include the following columns:
						/*order_id: This should be an integer set as the PRIMARY KEY and AUTO_INCREMENT.
						customer_id: This should be an integer referencing the customer_id in the Customers table  (FOREIGN KEY).
						order_date: This should be a DATE data type to store the order date.
						total_amount: This should be a DECIMAL(10,2) to store the total order amount.
						Constraints:
						a)	Set a FOREIGN KEY constraint on customer_id to reference the Customers table.
						b)	Add a CHECK constraint to ensure the total_amount is always a positive value.*/

							CREATE TABLE ORDERS1 (order_id INT AUTO_INCREMENT PRIMARY KEY,
						   customer_ID INT,
                           order_date DATE NOT NULL,
                           total_amount DECIMAL(10,2),
                           CONSTRAINT fk_customer1
                           FOREIGN KEY (customer_ID) REFERENCES Customers1(customer_ID),
                           CONSTRAINT posi_price 
                           CHECK (total_amount>0)
                           );
                           
							SELECT * FROM ORDERS1;


-- Q5.  JOINS

				-- a. List the top 5 countries (by order count) that Classic Models ships to. (Use the Customers and Orders tables)
		
						 SELECT country , COUNT(country) as order_count 
						 FROM Customers JOIN
						 Orders ON Orders.customerNumber=Customers.customerNumber
						 GROUP BY country
						 HAVING COUNT(country)
						 ORDER BY order_count DESC
						 LIMIT 5;
					
                    
-- Q6. SELF JOIN
		
				-- a.  Create a table project with below fields.
                
						/* ●	EmployeeID : integer set as the PRIMARY KEY and AUTO_INCREMENT.
						●	FullName: varchar(50) with no null values
						●	Gender : Values should be only ‘Male’  or ‘Female’
						●	ManagerID: integer 
						    Add below data into it. */

					CREATE TABLE Project (
						EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
						FullName VARCHAR(25) NOT NULL,
						Gender ENUM('Male', 'Female'),
						ManagerID INT,
						CONSTRAINT check_gender CHECK (Gender IN ('Male', 'Female')));
                        
		            INSERT INTO Project (EmployeeID, FullName, Gender, ManagerID) VALUES
								(1, 'Pranaya', 'Male', 3),
								(2, 'Priyanka', 'Female', 1),
								(3, 'Preety', 'Female',NULL),
								(4, 'Anurag', 'Male', 1),
								(5, 'Sambit', 'Male', NULL),
								(6, 'Rajesh', 'Male', 3),
								(7, 'Hina', 'Female', 3);
					SELECT * FROM Project;
                    
                    -- Find out the names of employees and their related managers.
                            
							SELECT m.FullName AS Manager_Name, 
							p.FullName AS Employee_Name
							FROM Project p
							JOIN Project m 
							ON e.ManagerID = m.EmployeeID
							ORDER BY m.FullName;
						

-- Q7. DDL Commands: Create, Alter, Rename

					-- a.Create table facility. Add the below fields into it.
							/*●	Facility_ID
							●	Name
							●	State
							●	Country */
                            
                            CREATE TABLE facility(FacilityID INT,
												  Fac_Name VARCHAR(20),
                                                  State VARCHAR(20),
                                                  Country VARCHAR(20));
                                                  
                                                  DESC facility;
                                   
                                   -- i) Alter the table by adding the primary key and auto increment to Facility_ID column.
												ALTER TABLE facility MODIFY FacilityID INT AUTO_INCREMENT PRIMARY KEY;
                                                
								   -- ii) Add a new column city after name with data type as varchar which should not accept any null values.
												ALTER TABLE facility ADD COLUMN (city VARCHAR(50) NOT NULL);
                                                
-- Q8. Views in SQL

					/* a. Create a view named product_category_sales that provides insights into sales performance by product category. 
                        This view should include the following information:
						productLine: The category name of the product (from the ProductLines table).
						total_sales: The total revenue generated by products within that category (calculated by summing the orderDetails.quantity * 
						orderDetails.priceEach for each product in the category).
						number_of_orders: The total number of orders containing products from that category.
						(Hint: Tables to be used: Products, orders, orderdetails and productlines)
                    */
					SELECT* FROM productlines;
                    SELECT* FROM orderdetails;
					SELECT* FROM products;
                    SELECT * FROM orders;

					CREATE VIEW product_category_sales AS 
					SELECT pl.productLine,  SUM(od.quantityOrdered * od.priceEach) AS total_sales,  COUNT(DISTINCT o.orderNumber) AS number_of_orders  
					FROM productlines AS pl  
					JOIN products pr ON pr.productLine = pl.productLine  
					JOIN orderdetails od ON od.productCode = pr.productCode  
					JOIN orders o ON o.orderNumber = od.orderNumber  
					GROUP BY pl.productLine;
                    
                    SELECT * FROM product_category_sales;

                                                  
-- Q9. Stored Procedures in SQL with parameters

						-- a. 
                        /*Create a stored procedure Get_country_payments which takes in year and country as inputs and gives year wise, 
                        country wise total amount as an output. Format the total amount to nearest thousand unit (K)
						Tables: Customers, Payments */
							SELECT * FROM customers;
                            SELECT* FROM payments;
                            
				DELIMITER $$
				CREATE PROCEDURE Get_country_payment(IN input_year INT, IN input_country VARCHAR(20))
				BEGIN
							SELECT 
							YEAR(p.paymentDate) AS YEAR,  -- Renaming column to "YEAR"
							c.country AS country,
							CONCAT(ROUND(SUM(p.amount) / 1000, 0), 'K') AS total_amount_k  -- Concatenate 'K' to the total amount in thousands
							FROM payments p
							JOIN customers c ON c.customerNumber = p.customerNumber
							WHERE YEAR(p.paymentDate) = input_year
							AND c.country = input_country
							GROUP BY YEAR, c.country;
							END $$
							DELIMITER ;

			CALL Get_country_payment(2003,'France');


-- Q10. Window functions - Rank, dense_rank, lead and lag

						-- a) Using customers and orders tables, rank the customers based on their order frequency

                                SELECT * FROM customers;
                                SELECT * FROM orders;
						
									SELECT c.customerName, COUNT(o.orderNumber) AS Order_count,
									RANK() OVER (ORDER BY COUNT(o.orderNumber) DESC) AS order_rank
									FROM orders o
									JOIN customers c ON c.customerNumber = o.customerNumber
									GROUP BY c.customerName
									ORDER BY Order_count DESC;


						-- b) Calculate year wise, month name wise count of orders and year over year (YoY) percentage change. 
                          --  Format the YoY values in no decimals and show in % sign.
							--  Table: Orders
                            SELECT * FROM orders;
                            
use classicmodels;
								
                                
									SELECT YEAR(orderDate) AS Year, 
									monthname(orderDate) AS Month, 
									COUNT(orderNumber) AS Total_order, 
									LAG(COUNT(orderNumber)) OVER (PARTITION BY MONTH(orderDate) ORDER BY YEAR(orderDate)) AS Prev_year_order, 
									CONCAT(
										ROUND(
											(COUNT(orderNumber) - LAG(COUNT(orderNumber)) OVER (PARTITION BY MONTH(orderDate) ORDER BY YEAR(orderDate))) 
											/ LAG(COUNT(orderNumber)) OVER (PARTITION BY MONTH(orderDate) ORDER BY YEAR(orderDate)) * 100, 
											0
										), '%'
									) AS YoY_change
								FROM orders
								GROUP BY YEAR(orderDate), MONTH(orderDate)
								ORDER BY Year, MONTH(orderDate);
                                
							

-- Q11.Subqueries and their applications

				-- a.Find out how many product lines are there for which the buy price value is greater than the 
				  -- average of buy price value. Show the output as product line and its count.
                  
                  SELECT * FROM productlines;
				  SELECT * FROM products;

                  SELECT productLine, COUNT(*) as total FROM products
                  WHERE buyPrice>(SELECT AVG(buyPrice) FROM products)
                  GROUP BY productLine;
                  
                  
                  
-- 12.  ERROR HANDLING in SQL
				-- Create the table Emp_EH. Below are its fields.
                /* 
					●	EmpID (Primary Key)
					●	EmpName
					●	EmailAddress
						Create a procedure to accept the values for the columns in Emp_EH. Handle the 
                        error using exception handling concept. Show the message as “Error occurred” in case of anything wrong.
				*/
                CREATE TABLE Emp_EH (
				EmpID INT PRIMARY KEY,
				EmpName VARCHAR(100),
				EmailAddress VARCHAR(255));
                
                DELIMITER $$
                CREATE PROCEDURE Insert_Emp_EH(
                IN p_EmpID INT,
                IN p_EmpName VARCHAR(200),
                IN p_EmailAddress VARCHAR(30))
                BEGIN
						DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
							BEGIN
									SELECT 'Error Occured' AS ErrorMessage ;
							END;
                            
                            INSERT INTO Emp_EH (EmpID,EmpName,EmailAddress)
                            VALUES(p_EmpID,p_EmpName,p_EmailAddress);
                            
                            SELECT 'Employee inserted successfully' AS SuccessMessage;
				END $$
                
                CALL Insert_Emp_EH(101,'Om','omghogare1234@gmail.com');
				CALL Insert_Emp_EH(101,'Sunil','sunilshah34@gmail.com');

                            
                  
-- 13. TRIGGERS
				/*
				Create the table Emp_BIT. Add below fields in it.
				●	Name
				●	Occupation
				●	Working_date
				●	Working_hours
				Insert the data as shown in below query.
				INSERT INTO Emp_BIT VALUES
				('Robin', 'Scientist', '2020-10-04', 12),  
				('Warner', 'Engineer', '2020-10-04', 10),  
				('Peter', 'Actor', '2020-10-04', 13),  
				('Marco', 'Doctor', '2020-10-04', 14),  
				('Brayden', 'Teacher', '2020-10-04', 12),  
				('Antonio', 'Business', '2020-10-04', 11);  				 
				Create before insert trigger to make sure any new value of Working_hours, if it is negative, then it should be inserted as positive. */
                
                
                CREATE TABLE Emp_BIT (
				Name VARCHAR(100),
				Occupation VARCHAR(50),
				Working_date DATE,
				Working_hours INT);
                
                DELIMITER $$

							CREATE TRIGGER before_insert_Emp_BIT
							BEFORE INSERT ON Emp_BIT
							FOR EACH ROW
							BEGIN
								-- Ensure Working_hours is always positive
								IF NEW.Working_hours < 0 THEN
									SET NEW.Working_hours = ABS(NEW.Working_hours);
								END IF;
							END $$

				DELIMITER ;
                
                
										INSERT INTO Emp_BIT VALUES
														('Robin', 'Scientist', '2020-10-04', 12),  
														('Warner', 'Engineer', '2020-10-04', 10),  
														('Peter', 'Actor', '2020-10-04', 13),  
														('Marco', 'Doctor', '2020-10-04', 14),  
														('Brayden', 'Teacher', '2020-10-04', 12),  
														('Antonio', 'Business', '2020-10-04', -11);  
                                                        
										SELECT *FROM Emp_BIT;
