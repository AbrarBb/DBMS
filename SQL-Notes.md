# ***`Basic`***

### **Constraints** 

Constraints are rules enforced on columns to maintain data integrity.

#### **Types of Constraints**

    **0\.  NOT NULL**: Ensures a column cannot have a NULL value.  
`CREATE TABLE employees (`  
    `employee_id NUMBER NOT NULL,`  
    `name VARCHAR2(50) NOT NULL`  
`);`

1. **UNIQUE**: Ensures all values in a column are unique.

   `CREATE TABLE departments (`  
    `department_id NUMBER UNIQUE,`

    `department_name VARCHAR2(50)`  
`);`

2. **PRIMARY KEY**: Combines `NOT NULL` and `UNIQUE`. A table can have only one primary key.  
     
   `CREATE TABLE projects ( project_id NUMBER PRIMARY KEY,`

    `project_name VARCHAR2(100)`  
`);`

3. **FOREIGN KEY**: Ensures values in a column match values in another table’s primary key.  
   `CREATE TABLE employees (`

    `employee_id NUMBER PRIMARY KEY,`  
    `department_id NUMBER,`  
    `CONSTRAINT fk_department FOREIGN KEY (department_id)`  
    `REFERENCES departments(department_id)`  
`);`

4. **CHECK**: Ensures values in a column meet a specific condition.

   `CREATE TABLE orders (`

    `order_id NUMBER PRIMARY KEY,`  
    `quantity NUMBER CHECK (quantity > 0)`  
`);`

5. **DEFAULT**: Assigns a default value if none is provided during insertion.

   `CREATE TABLE customers (`

    `customer_id NUMBER PRIMARY KEY,`  
    `status VARCHAR2(10) DEFAULT 'Active'`  
`);`

6. **Modify Constraints**

Add or drop constraints using `ALTER TABLE`.

Add a constraint:

`ALTER TABLE employees ADD CONSTRAINT chk_salary CHECK (salary > 0);`

* Drop a constraint:

  `ALTER TABLE employees DROP CONSTRAINT chk_salary;`

---

#### **Deletion (Cont.)**

Deleting records removes rows from a table.

#### **Using `DELETE`**

Delete specific rows:

`DELETE FROM employees`  
`WHERE department_id = 10;`

* Delete all rows (keeps structure):

  `DELETE FROM employees;`

#### **Using `TRUNCATE`**

Removes all rows but is faster than `DELETE` (no rollback possible).

`TRUNCATE TABLE employees;`  
---

### 

### **Insertion**

Insert new rows into a table.

#### **Insert a Single Row**

`INSERT INTO employees (employee_id, name, salary)`  
`VALUES (101, 'John Doe', 50000);`

#### **Insert Multiple Rows**

`INSERT ALL`  
`INTO employees (employee_id, name, salary) VALUES (102, 'Jane Doe', 60000)`  
`INTO employees (employee_id, name, salary) VALUES (103, 'Sam Smith', 70000)`  
`SELECT * FROM DUAL;`

#### **Insert Using Subquery**

`INSERT INTO employees (employee_id, name, salary)`  
`SELECT employee_id, name, salary`  
`FROM temp_employees`  
`WHERE department_id = 20;`

---

### **Updates**

Update modifies existing rows in a table.

#### **Simple Update**

`UPDATE employees`  
`SET salary = salary * 1.10`  
`WHERE department_id = 10;`

#### **Update with Subquery**

`UPDATE employees`  
`SET department_id = (`  
    `SELECT department_id`  
    `FROM departments`  
    `WHERE department_name = 'HR'`  
`)`  
`WHERE employee_id = 101;`

#### **Conditional Update**

`UPDATE employees`  
`SET status = 'Promoted'`  
`WHERE salary > 50000;`

---

### **Updates (Cont.)**

#### **Updating Multiple Columns**

`UPDATE employees`  
`SET salary = salary * 1.05,`  
    `status = 'Updated'`  
`WHERE department_id = 10;`

#### **Using `MERGE` for Conditional Insert or Update**

`MERGE` allows you to insert or update based on conditions.

**Syntax:**

`MERGE INTO employees e`  
`USING temp_employees t`  
`ON (e.employee_id = t.employee_id)`  
`WHEN MATCHED THEN`  
    `UPDATE SET e.salary = t.salary, e.status = 'Updated'`  
`WHEN NOT MATCHED THEN`  
    `INSERT (employee_id, name, salary, department_id)`  
    `VALUES (t.employee_id, t.name, t.salary, t.department_id);`

# 

# 

# ***`1. Modify a Table (ALTER)`***

#### **a. Add a Column**

`ALTER TABLE table_name`  
`ADD (column_name data_type constraints);`

Example:  
`ALTER TABLE employees`  
`ADD (email VARCHAR2(100));`

#### **b. Modify a Column**

* Change data type or size:

`ALTER TABLE table_name`  
`MODIFY (column_name new_data_type);`

Example:  
`ALTER TABLE employees`  
`MODIFY (salary NUMBER(10, 2));`

* Add/Drop `NULL` constraint:

`ALTER TABLE employees`  
`MODIFY (email NOT NULL);`

#### **c. Drop a Column**

`ALTER TABLE table_name`  
`DROP COLUMN column_name;`

Example:

`ALTER TABLE employees`  
`DROP COLUMN email;`

#### **d. Rename a Column**

`ALTER TABLE table_name`  
`RENAME COLUMN old_column_name TO new_column_name;`

Example:  
`ALTER TABLE employees`  
`RENAME COLUMN email TO contact_email;`

#### **e. Add Constraints**

`ALTER TABLE table_name`  
`ADD CONSTRAINT constraint_name constraint_definition;`

Example:  
`ALTER TABLE employees`  
`ADD CONSTRAINT emp_email_unique UNIQUE (email);`

#### **f. Drop Constraints**

`ALTER TABLE table_name`  
`DROP CONSTRAINT constraint_name;`

Example:  
`ALTER TABLE employees`  
`DROP CONSTRAINT emp_email_unique;`

# 

# **2\. JOINS**

[SQL join: Everything you need to know](https://blog.quest.com/an-overview-of-sql-join-types-with-examples/)  
![][image1]

### **1\. Inner Join**

Returns rows that have matching values in both tables.

**Syntax:**

`SELECT columns`  
`FROM table1`  
`JOIN table2`  
`ON table1.column = table2.column;`

**Example:**

`SELECT employees.employee_id, employees.name, departments.department_name`  
`FROM employees`  
`JOIN departments`  
`ON employees.department_id = departments.department_id;`

---

### **2\. Left (Outer) Join**

Returns all rows from the left table and matching rows from the right table. If there is no match, NULL values are returned for columns from the right table.

**Syntax:**

`SELECT columns`  
`FROM table1`  
`LEFT JOIN table2`  
`ON table1.column = table2.column;`

**Example:**

`SELECT employees.employee_id, employees.name, departments.department_name`  
`FROM employees`  
`LEFT JOIN departments`  
`ON employees.department_id = departments.department_id;`

---

### **3\. Right (Outer) Join**

Returns all rows from the right table and matching rows from the left table. If there is no match, NULL values are returned for columns from the left table.

**Syntax:**

`SELECT columns`  
`FROM table1`  
`RIGHT JOIN table2`  
`ON table1.column = table2.column;`

**Example:**

`SELECT employees.employee_id, employees.name, departments.department_name`  
`FROM employees`  
`RIGHT JOIN departments`  
`ON employees.department_id = departments.department_id;`

---

### **4\. Full (Outer) Join**

Returns all rows when there is a match in either table. If there is no match, NULL values are returned for unmatched rows in both tables.

**Syntax:**

`SELECT columns`  
`FROM table1`  
`FULL OUTER JOIN table2`  
`ON table1.column = table2.column;`

**Example:**

`SELECT employees.employee_id, employees.name, departments.department_name`  
`FROM employees`  
`FULL OUTER JOIN departments`  
`ON employees.department_id = departments.department_id;`

---

### **5\. Cross Join**

Returns the Cartesian product of two tables (every row of the first table is joined with every row of the second table).

**Syntax:**

`SELECT columns`  
`FROM table1`  
`CROSS JOIN table2;`

**Example:**

`SELECT employees.name, departments.department_name`  
`FROM employees`  
`CROSS JOIN departments;`

---

### 

### **6\. Self Join**

A join where a table is joined with itself. Useful for hierarchical or relational data.

**Syntax:**

`SELECT A.column, B.column`  
`FROM table A`  
`JOIN table B`  
`ON A.column = B.column;`

**Example:**

`SELECT E1.employee_id, E1.name AS Manager, E2.name AS Employee`  
`FROM employees E1`  
`JOIN employees E2`  
`ON E1.employee_id = E2.manager_id;`

---

### 

### **7\. Natural Join**

A join that automatically matches columns with the same name and compatible data types in both tables.

**Syntax:**

`SELECT columns`  
`FROM table1`  
`NATURAL JOIN table2;`

**Example:**

`SELECT *`  
`FROM employees`  
`NATURAL JOIN departments;`

---

### **8\. Using Clause**

If both tables have a common column, `USING` can specify the column to join on.

**Syntax:**

`SELECT columns`  
`FROM table1`  
`JOIN table2`  
`USING (common_column);`

**Example:**

`SELECT employee_id, name, department_name`  
`FROM employees`  
`JOIN departments`  
`USING (department_id);`

# ***`3. Aggregate functions`***

### **1\. COUNT()**

Returns the number of rows or non-`NULL` values in a column.

**Syntax:**

`SELECT COUNT(column_name)`  
`FROM table_name;`

**Examples:**

Count all rows:

`SELECT COUNT(*) FROM employees;`

* Count non-NULL values in a column:  
  `SELECT COUNT(department_id) FROM employees;`

---

### **2\. SUM()**

Calculates the total (sum) of a numeric column.

**Syntax:**

`SELECT SUM(column_name)`  
`FROM table_name;`

**Example:**

`SELECT SUM(salary) AS total_salary`  
`FROM employees;`

---

### **3\. AVG()**

Calculates the average value of a numeric column.

**Syntax:**

`SELECT AVG(column_name)`  
`FROM table_name;`

**Example:**

`SELECT AVG(salary) AS average_salary`  
`FROM employees;`

---

### **4\. MIN()**

Returns the smallest value in a column.

**Syntax:**

`SELECT MIN(column_name)`  
`FROM table_name;`

**Example:**

`SELECT MIN(salary) AS lowest_salary`  
`FROM employees;`

---

### **5\. MAX()**

Returns the largest value in a column.

**Syntax:**

`SELECT MAX(column_name)`  
`FROM table_name;`

**Example:**

`SELECT MAX(salary) AS highest_salary`  
`FROM employees;`

---

### 

### **6\. GROUP BY with Aggregate Functions**

Aggregate functions are often used with `GROUP BY` to compute values for specific groups.

**Example:**

`SELECT department_id, SUM(salary) AS total_salary`  
`FROM employees`  
`GROUP BY department_id;`

---

### **7\. HAVING Clause**

The `HAVING` clause is used to filter groups after applying aggregate functions. This is similar to `WHERE`, but `WHERE` cannot be used with aggregates.

**Example:**

`SELECT department_id, AVG(salary) AS average_salary`  
`FROM employees`  
`GROUP BY department_id`  
`HAVING AVG(salary) > 50000;`

---

### **8\. DISTINCT with Aggregate Functions**

You can use `DISTINCT` to remove duplicate values before applying aggregate functions.

**Example:**

`SELECT COUNT(DISTINCT department_id) AS unique_departments`  
`FROM employees;`

---

### **9\. Combining Aggregate Functions**

You can use multiple aggregate functions in a single query.

**Example:**

`SELECT`   
    `COUNT(*) AS total_employees,`  
    `SUM(salary) AS total_salary,`  
    `AVG(salary) AS average_salary,`  
    `MAX(salary) AS highest_salary,`  
    `MIN(salary) AS lowest_salary`  
`FROM employees;`

---

### **10\. Aggregate Functions with Joins**

You can combine aggregate functions with joins to compute values across related tables.

**Example:**

`SELECT d.department_name, SUM(e.salary) AS total_salary`  
`FROM employees e`  
`JOIN departments d`  
`ON e.department_id = d.department_id`  
`GROUP BY d.department_name;`

## 

## **1\. Set Operations**

Set operations allow you to combine results from multiple `SELECT` queries.

#### **a. UNION**

Combines results from two queries, removing duplicates.

**Syntax:**

`SELECT column_list`  
`FROM table1`  
`UNION`  
`SELECT column_list`  
`FROM table2;`

**Example:**

`SELECT employee_id FROM employees`  
`UNION`  
`SELECT employee_id FROM managers;`

#### **b. UNION ALL**

Combines results but does not remove duplicates.

**Syntax:**

`SELECT column_list`  
`FROM table1`  
`UNION ALL`  
`SELECT column_list`  
`FROM table2;`

**Example:**

`SELECT employee_id FROM employees`  
`UNION ALL`  
`SELECT employee_id FROM managers;`

#### **c. INTERSECT**

Returns only the rows present in both queries.

**Syntax:**

`SELECT column_list`  
`FROM table1`  
`INTERSECT`  
`SELECT column_list`  
`FROM table2;`

**Example:**

`SELECT employee_id FROM employees`  
`INTERSECT`  
`SELECT employee_id FROM managers;`

#### **d. MINUS**

Returns rows from the first query that are not present in the second query.

**Syntax:**

`SELECT column_list`  
`FROM table1`  
`MINUS`  
`SELECT column_list`  
`FROM table2;`

**Example:**

`SELECT employee_id FROM employees`  
`MINUS`  
`SELECT employee_id FROM managers;`

---

## 2\. Null Values

NULL represents missing or unknown data.

#### **a. IS NULL and IS NOT NULL**

Check for null or non-null values.

**Examples:**

`SELECT * FROM employees WHERE department_id IS NULL;`  
`SELECT * FROM employees WHERE department_id IS NOT NULL;`

#### **b. NVL (Replace NULL with a Value)**

`SELECT NVL(salary, 0) AS adjusted_salary`  
`FROM employees;`

---

## **3\. `Set Membership`**

Used with comparison operators in subqueries.

#### **1\. `IN` Operator**

Checks if a value is present in a set of values.

**Example:** Find employees working in departments 10, 20, or 30\.

`SELECT employee_id, name`  
`FROM employees`  
`WHERE department_id IN (10, 20, 30);`

---

#### **2\. `NOT IN` Operator**

Checks if a value is **not** present in a set.

**Example:** Find employees who are not in departments 10, 20, or 30\.

`SELECT employee_id, name`  
`FROM employees`  
`WHERE department_id NOT IN (10, 20, 30);`

---

#### **3\. `ANY` or `SOME` Operator**

Compares a value to **any** value in a set (or subquery result). It's often used with comparison operators (`>`, `<`, `=`).

**Example:** Find employees earning more than **any** employee in department 10\.

`SELECT employee_id, name, salary`  
`FROM employees`  
`WHERE salary > ANY (`  
    `SELECT salary`  
    `FROM employees`  
    `WHERE department_id = 10`  
`);`

---

#### **4\. `ALL` Operator**

Compares a value to **all** values in a set (or subquery result). The condition must be true for all values.

**Example:** Find employees earning more than **all** employees in department 10\.

`SELECT employee_id, name, salary`  
`FROM employees`  
`WHERE salary > ALL (`  
    `SELECT salary`  
    `FROM employees`  
    `WHERE department_id = 10`  
`);`

---

#### **5\. `EXISTS` Operator**

Checks if a subquery returns **any rows**. It’s often used in correlated subqueries.

**Example:** Find employees who belong to departments located in 'New York'.

`SELECT employee_id, name`  
`FROM employees e`  
`WHERE EXISTS (`  
    `SELECT 1`  
    `FROM departments d`  
    `WHERE d.department_id = e.department_id`  
      `AND d.location = 'New York'`  
`);`

---

#### **6\. `NOT EXISTS` Operator**

Checks if a subquery returns **no rows**.

**Example:** Find employees who have not submitted any timesheets.

`SELECT employee_id, name`  
`FROM employees e`  
`WHERE NOT EXISTS (`  
    `SELECT 1`  
    `FROM timesheets t`  
    `WHERE t.employee_id = e.employee_id`  
`);`

---

---

#### 5\. Combining `SOME`, `ALL`, `EXISTS`, and Null Handling

##### **Example:**

Find employees with salaries higher than at least one employee in department 10 and without a NULL department.

`SELECT employee_id, name, salary`  
`FROM employees`  
`WHERE salary > SOME (SELECT salary FROM employees WHERE department_id = 10)`  
`AND department_id IS NOT NULL;`

# Nested Subqueries 

A nested subquery is a query inside another query. Subqueries can be deeply nested, but Oracle SQL has limits on the depth.

---

#### **Types of Nested Subqueries**

1. **Single-Row Nested Subquery**  
2. **Multi-Row Nested Subquery**  
3. **Correlated Nested Subquery**

---

#### **1\. Single-Row Nested Subquery**

The subquery returns exactly one row and one column.

**Example:** Find employees who earn more than the average salary.

`SELECT employee_id, name, salary`  
`FROM employees`  
`WHERE salary > (`  
    `SELECT AVG(salary)`  
    `FROM employees`  
`);`

---

#### **2\. Multi-Row Nested Subquery**

The subquery returns multiple rows but only one column.

**Example:** Find employees who work in departments located in 'New York' or 'Los Angeles'.

`SELECT employee_id, name`  
`FROM employees`  
`WHERE department_id IN (`  
    `SELECT department_id`  
    `FROM departments`  
    `WHERE location IN ('New York', 'Los Angeles')`  
`);`

---

#### **3\. Correlated Nested Subquery**

The subquery depends on a value from the outer query. It’s evaluated once for every row of the outer query.

**Example:** Find employees whose salary is higher than the average salary of their department.

`SELECT employee_id, name, salary`  
`FROM employees e`  
`WHERE salary > (`  
    `SELECT AVG(salary)`  
    `FROM employees`  
    `WHERE department_id = e.department_id`  
`);`

---

### **Nested Subqueries in the `SELECT`, `WHERE`, and `FROM` Clauses**

#### **In the `SELECT` Clause**

Retrieve employee names and their department’s average salary.

`SELECT name,`  
       `(SELECT AVG(salary)`  
        `FROM employees e2`  
        `WHERE e2.department_id = e1.department_id) AS avg_salary`  
`FROM employees e1;`

---

#### **In the `WHERE` Clause**

Find employees earning more than the highest salary in department 20\.

`SELECT employee_id, name, salary`  
`FROM employees`  
`WHERE salary > (`  
    `SELECT MAX(salary)`  
    `FROM employees`  
    `WHERE department_id = 20`  
`);`

---

#### **In the `FROM` Clause**

Use a subquery as a derived table to calculate intermediate results.

`SELECT department_id, avg_salary`  
`FROM (`  
    `SELECT department_id, AVG(salary) AS avg_salary`  
    `FROM employees`  
    `GROUP BY department_id`  
`) subquery_table`  
`WHERE avg_salary > 50000;`

## **Scalar Subquery**

A **scalar subquery** is a subquery that returns exactly **one value** (a single row and single column). This value can be used wherever a single value is expected, such as in a `SELECT`, `WHERE`, or `HAVING` clause.

---

**Syntax**  
`SELECT column_name,`   
       `(SELECT single_column`   
        `FROM table_name`   
        `WHERE condition) AS alias_name`  
`FROM another_table;`

---

It can be used in:

* **`SELECT` Clause**: To include computed values.  
  * **`WHERE` Clause**: To filter rows.  
  * **`HAVING` Clause**: To filter aggregated results.

---

### 

### 

**Examples**

#### **1\. Scalar Subquery in the `SELECT` Clause**

Retrieve employees' names and their department names using a scalar subquery.

`SELECT e.name,`   
       `(SELECT d.department_name`   
        `FROM departments d`   
        `WHERE d.department_id = e.department_id) AS department_name`  
`FROM employees e;`

---

#### **2\. Scalar Subquery in the `WHERE` Clause**

Find employees whose salary is greater than the average salary of their department.

`SELECT name, salary`  
`FROM employees e`  
`WHERE salary > (`  
    `SELECT AVG(salary)`   
    `FROM employees`   
    `WHERE department_id = e.department_id`  
`);`

---

#### **3\. Scalar Subquery in the `HAVING` Clause**

Find departments where the total salary is greater than the average total salary of all departments.

`SELECT department_id, SUM(salary) AS total_salary`  
`FROM employees`  
`GROUP BY department_id`  
`HAVING SUM(salary) > (`  
    `SELECT AVG(total_salary)`  
    `FROM (SELECT department_id, SUM(salary) AS total_salary`  
          `FROM employees`  
          `GROUP BY department_id)`  
`);`

---

**Handling Multiple Rows in Scalar Subqueries**

If the subquery returns more than one row, Oracle will throw an error. To handle this, you can:

**Restrict the subquery to return one row** using `ROWNUM`, `TOP`, or a filter:

`SELECT name FROM employees`  
`WHERE department_id = (`  
    `SELECT department_id`  
    `FROM departments`  
    `WHERE location = 'New York'`  
    `AND ROWNUM = 1`  
`);`

1. **Aggregate the result to a single value** (e.g., using `MAX`, `MIN`, or `AVG`):

`SELECT name FROM employees`

`WHERE salary = (`  
    `SELECT MAX(salary)`  
    `FROM employees`  
    `WHERE department_id = 10`  
`);`

---

## **With Clause**

* **Definition**: The `WITH` clause defines **Common Table Expressions (CTEs)**, which act as temporary result sets that can be referenced within a SQL statement.

**Syntax**:  
`WITH cte_name AS (`  
    `SELECT column1, column2`  
    `FROM table_name`  
    `WHERE condition`  
`)`  
`SELECT *`   
`FROM cte_name;`  
**Example**:

`WITH EmployeeCTE AS (`  
    `SELECT employee_id, department_id, salary`  
    `FROM employees`  
    `WHERE salary > 5000`  
`)`  
`SELECT department_id, COUNT(*) AS employee_count`  
`FROM EmployeeCTE`  
`GROUP BY department_id;`

* *Explanation*: The `WITH` clause creates `EmployeeCTE` with employees earning more than 5000, then the main query counts employees by department.  
  **Use Cases**:  
  Simplifies complex queries by breaking them into smaller, manageable parts.  
  Enhances query readability and reusability.  
  Allows recursive queries.

---

## **Join Expressions**

* **Definition**: Joins are used to combine rows from two or more tables based on a related column.  
* **Types and Examples**:  
  **Left (Outer) Join**: Includes all rows from the left table and matching rows from the right table.  
  **Right (Outer) Join**: Includes all rows from the right table and matching rows from the left table.  
  **Full (Outer) Join**: Includes all rows when there's a match in either table.  
  **Cross Join**: Produces Cartesian product.  
  **Self Join**: Joins a table to itself.

**Inner Join**: Returns rows with matching values in both tables.

`SELECT e.employee_id, e.first_name, d.department_name`  
`FROM employees e`  
`INNER JOIN departments d`  
`ON e.department_id = d.department_id;`

**Left (Outer) Join**: Returns all rows from the left table and matching rows from the right table.

`SELECT e.employee_id, e.first_name, d.department_name`  
`FROM employees e`  
`LEFT JOIN departments d`  
`ON e.department_id = d.department_id;`

**Full (Outer) Join**: Returns all rows when there's a match in either table.

`SELECT e.employee_id, e.first_name, d.department_name`  
`FROM employees e`  
`FULL OUTER JOIN departments d`  
`ON e.department_id = d.department_id;`

---

## **Views**

* **Definition**: A view is a virtual table created from a query.

**Syntax**:

`CREATE VIEW view_name AS`   
`SELECT columns`  
`FROM table_name`  
`WHERE condition;`

**Example**:

`CREATE VIEW HighSalaryEmployees AS`  
`SELECT employee_id, first_name, salary`  
`FROM employees`  
`WHERE salary > 10000;`

`SELECT * FROM HighSalaryEmployees;`

* *Explanation*: The `HighSalaryEmployees` view stores the query result for employees earning more than 10,000.

---

## **Transactions**

* **Definition**: A sequence of operations performed as a single unit of work.  
* **Key Commands**:  
  * `COMMIT`: Saves the transaction permanently.  
  * `ROLLBACK`: Undoes the transaction.  
  * `SAVEPOINT`: Sets a save point within a transaction.

**Example**:

`BEGIN TRANSACTION;`

`UPDATE employees`  
`SET salary = salary * 1.1`  
`WHERE department_id = 10;`

`SAVEPOINT SalaryUpdated;`

`DELETE FROM employees`  
`WHERE employee_id = 100;`

`ROLLBACK TO SalaryUpdated;`

`COMMIT;`

* *Explanation*: This transaction increases salaries, saves a point, deletes an employee, and rolls back to the save point.

---

## **Integrity Constraints**

* **Definition**: Rules to maintain data integrity.  
* **Types**:

**NOT NULL**: Ensures a column cannot have a null value.

`ALTER TABLE employees`  
`MODIFY last_name NOT NULL;`

**UNIQUE**: Ensures all values in a column are unique.

**PRIMARY KEY**: Combines `NOT NULL` and `UNIQUE`.  
`ALTER TABLE employees`  
`ADD PRIMARY KEY (employee_id);`

**FOREIGN KEY**: Ensures referential integrity between tables.

`ALTER TABLE employees`  
`ADD CONSTRAINT fk_department`  
`FOREIGN KEY (department_id)`  
`REFERENCES departments(department_id);`

**CHECK**: Validates a condition.

`ALTER TABLE employees`  
`ADD CONSTRAINT chk_salary`  
`CHECK (salary > 0);`

---

## **SQL Data Types and Schemas**

* **Common Data Types**:  
  * `CHAR(size)`: Fixed-length character data.  
  * `VARCHAR2(size)`: Variable-length character data.  
  * `NUMBER(p, s)`: Numeric data.  
  * `DATE`: Date and time values.  
  * `BLOB`: Binary large objects (e.g., images).  
* **Schemas**:  
  * Logical collection of database objects (tables, views, indexes).  
  * Each user in Oracle typically corresponds to one schema.

---

### **Index Definition in SQL**

* **Definition**: Enhances query performance by allowing faster retrieval of rows.  
* **Types**:  
  * **B-Tree Index**: Default index type.  
  * **Bitmap Index**: Optimized for columns with low cardinality.

**Example**:

`CREATE INDEX idx_employee_name`  
`ON employees(last_name);`

## ---

**Authorization**

* **Definition**: Controls access to database objects and operations.  
* **Key Commands**:


**Grant**: Gives privileges.

`GRANT SELECT, INSERT ON employees TO user1;`

**Revoke**: Removes privileges.

`REVOKE SELECT ON employees FROM user1;`

**Roles**: Group of privileges.

`CREATE ROLE manager_role;`  
`GRANT SELECT, UPDATE ON employees TO manager_role;`

`GRANT manager_role TO user1;`

[image1]: <data:image/png;base64,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>