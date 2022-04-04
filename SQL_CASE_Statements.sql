###############################################################
###############################################################
-- Guided Project: SQL CASE Statements
###############################################################
###############################################################

select e.emp_no FROM employees e join dept_manager d on e.emp_no = d.emp_no
#############################
-- Task One: The SQL CASE Statement
-- In this task, we will learn how to write a conditional
-- statement using a single CASE clause
#############################

-- 1.1: Retrieve all the data in the employees table
SELECT * FROM employees;

-- 1.2: Change M to Male and F to Female in the employees table
SELECT
	emp_no
	,first_name
	,last_name
	,CASE
		WHEN gender = 'M' THEN 'Male'
		ELSE 'Female'
	END 
FROM
	employees;
-- 1.3: This gives the same result as 1.2 with alias given to gender column
SELECT
	emp_no
	,first_name
	,last_name
	,CASE
		WHEN gender = 'M' THEN 'Male'
		ELSE 'Female'
	END AS gender
FROM
	employees;

-- 1.4: This gives the same result as 1.2 & 1.3
SELECT
	emp_no
	,first_name
	,last_name
	,CASE gender
		WHEN 'M' THEN 'Male'
		ELSE 'Female'
	END AS gender
FROM
	employees;


#############################
-- Task Two: Adding multiple conditions to a CASE statement
-- In this task, we will learn how to add multiple conditions to a 
-- CASE statement
#############################

-- 2.1: Retrieve all the data in the customers table
SELECT * FROM customers;

-- 2.2: Create a column called Age_Category that returns Young for ages less than 30,
-- Aged for ages greater than 60, and Middle Aged otherwise
SELECT
	*
	,CASE
		WHEN age < 30 THEN 'Young'
		WHEN age > 60 THEN 'Aged'
		ELSE 'Middle Age'
	END AS Age_Category
FROM
	customers;
		 

-- 2.3: Retrieve a list of the number of employees that were employed before 1990, between 1990 and 1995, and 
-- after 1995
SELECT * FROM employees

SELECT
	emp_no
	,hire_date
	,EXTRACT(YEAR FROM hire_date) AS Year
	,CASE 
		WHEN EXTRACT(YEAR FROM hire_date) < '1990' THEN 'Employed Before 1990'
		WHEN EXTRACT(YEAR FROM hire_date) >= '1990'
			AND
			EXTRACT(YEAR FROM hire_date) < '1995' THEN 'Employed Between 1990 and 1995'
		ELSE 'Employed After 1995' 
		END AS employment_time
FROM 
	employees;

#############################
-- Task Three: The CASE Statement and Aggregate Functions
-- In this task, we will see how to use the CASE clause and
-- SQL aggregate functions to retrieve data
#############################

-- 3.1: Retrieve the average salary of all employees
SELECT * FROM salaries;

SELECT 
	emp_no
	, AVG(salary)
FROM 
	salaries
GROUP BY 
	emp_no
ORDER BY 
	AVG(salary) DESC;

-- 3.2: Retrieve a list of the average salary of employees. If the average salary is more than
-- 80000, return Paid Well. If the average salary is less than 80000, return Underpaid,
-- otherwise, return Unpaid

SELECT
	emp_no
	,ROUND(
		AVG(salary)
		 ,2) AS Average_Salary
	,CASE
		WHEN AVG(salary) > 80000 THEN 'Paid Well'
		WHEN AVG(salary) < 80000 THEN 'Underpaid'
		ELSE 'Unpaid'
	 END AS Salary_Category
FROM
	salaries
GROUP BY 
	emp_no
ORDER BY
	Average_Salary DESC;

-- 3.3: Retrieve a list of the average salary of employees. If the average salary is more than
-- 80000 but less than 100000, return Paid Well. If the average salary is less than 80000, 
-- return Underpaid, otherwise, return Manager
SELECT
	emp_no
	,ROUND(
		AVG(salary)
		 ,2) AS Average_Salary
	,CASE
		WHEN AVG(salary) > 80000 AND AVG(salary) < 100000 THEN 'Paid Well' 
		WHEN AVG(salary) < 80000 THEN 'Underpaid'
		ELSE 'Manager'
	 END AS Salary_Category
FROM
	salaries
GROUP BY 
	emp_no
ORDER BY
	Average_Salary DESC;

-- 3.4: Count the number of employees in each salary category
SELECT
	a.salary_category, COUNT(*)
FROM(
	SELECT
		emp_no
		,ROUND(
			AVG(salary)
			 ,2) AS Average_Salary
		,CASE
			WHEN AVG(salary) > 80000 AND AVG(salary) < 100000 THEN 'Paid Well' 
			WHEN AVG(salary) < 80000 THEN 'Underpaid'
			ELSE 'Manager'
		 END AS Salary_Category
	FROM
		salaries
	GROUP BY 
		emp_no
	ORDER BY
		Average_Salary DESC
	) a
GROUP BY 
	salary_category

#############################
-- Task Four: The CASE Statement and SQL Joins
-- -- In this task, we will see how to use the CASE clause and
-- SQL Joins to retrieve data
#############################

-- 4.1: Retrieve all the data from the employees and dept_manager tables
SELECT 
	* 
FROM 
	employees
ORDER BY 
	emp_no DESC;

--
SELECT 
	* 
FROM 
	dept_manager;

-- 4.2: Join all the records in the employees table to the dept_manager table
SELECT 
	 e.emp_no
	, dm.emp_no
	, e.first_name
	, e.last_name
FROM 
	employees e
LEFT JOIN 
	dept_manager dm 
ON 
	dm.emp_no = e.emp_no
ORDER BY 
	dm.emp_no;
	
-- 4.3: Join all the records in the employees table to the dept_manager table
-- where the employee number is greater than 109990
SELECT 
	e.emp_no
	, dm.emp_no
	, e.first_name
	, e.last_name
FROM 
	employees e
LEFT JOIN 
	dept_manager dm 
ON 
	dm.emp_no = e.emp_no
WHERE 
	e.emp_no > 109990;

-- 4.4: Obtain a result set containing the employee number, first name, and last name
-- of all employees. Create a 4th column in the query, indicating whether this 
-- employee is also a manager, according to the data in the
-- dept_manager table, or a regular employee
SELECT
	e.emp_no
	,e.first_name
	,e.last_name
	,CASE
		WHEN dm.emp_no IS NOT NULL THEN 'Manager'
		ELSE 'Employee'
	END
FROM 
	employees e
LEFT JOIN
	dept_manager dm
ON 
	e.emp_no = dm.emp_no
ORDER BY
	dm.emp_no;
	

-- 4.5: Obtain a result set containing the employee number, first name, and last name
-- of all employees with a number greater than '109990'. Create a 4th column in the query,
-- indicating whether this employee is also a manager, according to the data in the
-- dept_manager table, or a regular employee

SELECT 
	 dm.emp_no
	, e.first_name
	, e.last_name
	,CASE
		WHEN dm.emp_no IS NOT NULL THEN 'Manager'
		ELSE 'Employee'
	 END	
FROM 
	employees e
LEFT JOIN 
	dept_manager dm 
ON 
	dm.emp_no = e.emp_no
WHERE 
	e.emp_no > 109990;

#############################
-- Task Five: The CASE Statement together with Aggregate Functions and Joins
-- In this task, we will see how to use the CASE clause together with
-- SQL aggregate functions and SQL Joins to retrieve data
#############################

-- 5.1: Retrieve all the data from the employees and salaries tables
SELECT * FROM employees;

SELECT * FROM salaries;

SELECT * FROM dept_manager;

-- 5.2: Retrieve a list of all salaries earned by an employee
SELECT 
	 e.emp_no
	, e.first_name
	, e.last_name
	, s.salary
FROM 
	employees e
JOIN 
	salaries s 
ON 
	e.emp_no = s.emp_no;


/* 5.3: Retrieve a list of  employee numbers, first name and last name.
Add a column called 'salary difference' which is the difference between the
manager’s maximum and minimum salary. Also, add a column called
'salary_increase', which returns 'Salary was raised by more than $30,000' if the difference 
is more than $30,000, 'Salary was raised by more than $20,000 but less than $30,000',
if the difference is between $20,000 and $30,000, 'Salary was raised by less than $20,000'
if the difference is less than $20,000 */

SELECT
	e.first_name
	,e.last_name
	,s.emp_no
	, MAX(s.salary) - MIN(s.salary) AS Salary_Difference
	 , CASE 
			WHEN MAX(s.salary) - MIN(s.salary)< 20000 THEN 'Salary was raised by less than 20000'
			WHEN MAX(s.salary) - MIN(s.salary)> 20000
				AND  MAX(s.salary) - MIN(s.salary)<= 30000 THEN 'Salary was raised by between 20000 and less than 30000'
			WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more than 30000'
		END AS Salary_Increase
		
FROM
	employees e
JOIN
	salaries s
ON 
	e.emp_no = s.emp_no
GROUP BY 
	s.emp_no
	,e.first_name
	,e.last_name;
	
	
	
-- 5.4: Retrieve all the data from the employees and dept_emp tables
SELECT * FROM employees;

SELECT * FROM dept_emp;

/* 5.5: Extract the employee number, first and last name of the first 100 employees, 
and add a fourth column called "current_employee" saying "Is still employed",
if the employee is still working in the company, or "Not an employee anymore",
if they are not more working in the company.
Hint: We will need data from both the 'employees' and 'dept_emp' table to solve this exercise */
SELECT
	e.emp_no
	,e.first_name
	,e.last_name
	,de.to_date
	,CASE
		WHEN MAX(de.to_date) > CURRENT_DATE THEN 'Is Still Employed'
		ELSE 'Not an employee anymore'
	END AS current_employ
FROM 
	employees e
JOIN
	dept_emp de
ON
	e.emp_no = de.emp_no
GROUP BY
	e.emp_no
	,de.to_date;

#############################
-- Task Six: Transposing data using the CASE clause
-- In this task, we will learn how to use the SQL CASE statement to
-- transpose retrieved data
#############################

-- 6.1: Retrieve all the data from the sales table
SELECT * FROM sales;

-- 6.2: Retrieve the count of the different profit_category from the sales table
SELECT 
	a.profit_category
	, COUNT(*)
FROM (
		SELECT 
			order_line
			, profit
			,CASE
				WHEN profit < 0 THEN 'No Profit'
				WHEN profit > 0 AND profit < 500 THEN 'Low Profit'
				WHEN profit > 500 AND profit < 1500 THEN 'Good Profit'
				ELSE 'High Profit'
			END AS profit_category 
	   	FROM sales
	) a
GROUP BY 
	a.profit_category;

-- 6.3: Transpose 6.2 above
SELECT
	SUM(
		CASE 
			WHEN profit < 0 THEN 1 
			ELSE 0
		END)AS no_profit
	,SUM(
		CASE 
			WHEN profit > 0
				AND profit < 500 THEN 1 
			ELSE 0
		END)AS low_profit
	,SUM(
		CASE 
			WHEN profit BETWEEN 500 AND 1500 THEN 1 
			ELSE 0
		END)AS good_profit
		,SUM(
		CASE 
			WHEN profit > 1500 THEN 1 
			ELSE 0
		END)AS high_profit
FROM
	sales;


-- 6.4: Retrieve the number of employees in the first four departments in the dept_emp table

SELECT * FROM dept_emp;

SELECT 
	dept_no
	, COUNT(*) 
FROM 
	dept_emp
WHERE 
	dept_no IN ('d001', 'd002', 'd003', 'd004')
GROUP BY 
	dept_no
ORDER BY 
	dept_no;

-- 6.5: Transpose 6.4 above
SELECT
	 SUM(CASE WHEN dept_no = 'd001' THEN 1
	   	ELSE 0
	    END) dept_one
	,SUM(CASE WHEN dept_no = 'd002' THEN 1
		ELSE 0
		END) dept_two
	,SUM(CASE WHEN dept_no = 'd003' THEN 1
		ELSE 0
		END) dept_three
	,SUM(CASE WHEN dept_no = 'd004' THEN 1
		ELSE 0
		END) dept_four
FROM
	dept_emp;
