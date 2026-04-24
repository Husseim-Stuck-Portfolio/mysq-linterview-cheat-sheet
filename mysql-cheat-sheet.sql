FOUNDATIONS | USE | Select the active database | USE company_db;
FOUNDATIONS | SELECT | Return specific columns from a table | SELECT first_name, salary FROM employees;
FOUNDATIONS | SELECT * | Return all columns from a table | SELECT * FROM employees;
FOUNDATIONS | SELECT DISTINCT | Return unique values only | SELECT DISTINCT department_id FROM employees;
FOUNDATIONS | TABLE | Return all rows from a table using table shorthand | TABLE employees;
FOUNDATIONS | VALUES ROW | Create inline rows as a result set | VALUES ROW(1, 'A'), ROW(2, 'B');
FOUNDATIONS | AS alias | Rename a column or table in output | SELECT salary AS monthly_salary FROM employees;
FOUNDATIONS | LIMIT | Restrict number of rows returned | SELECT * FROM employees LIMIT 10;
FOUNDATIONS | LIMIT OFFSET | Paginate by skipping then returning rows | SELECT * FROM employees LIMIT 10 OFFSET 20;

FILTERING | WHERE | Filter rows by a condition | SELECT * FROM employees WHERE salary > 50000;
FILTERING | AND | Require both conditions to be true | SELECT * FROM employees WHERE department_id = 10 AND salary > 50000;
FILTERING | OR | Match either condition | SELECT * FROM employees WHERE department_id = 10 OR department_id = 20;
FILTERING | NOT | Negate a condition | SELECT * FROM employees WHERE NOT status = 'inactive';
FILTERING | IN | Match any value in a list | SELECT * FROM employees WHERE department_id IN (10, 20, 30);
FILTERING | NOT IN | Exclude values from a list or subquery | SELECT * FROM employees WHERE department_id NOT IN (10, 20);
FILTERING | BETWEEN | Match values inside a range | SELECT * FROM employees WHERE salary BETWEEN 40000 AND 70000;
FILTERING | LIKE | Match text patterns with wildcards | SELECT * FROM employees WHERE last_name LIKE 'Sm%';
FILTERING | REGEXP | Match text with a regular expression | SELECT * FROM employees WHERE email REGEXP '^[A-Za-z0-9._%+-]+@company\.com$';
FILTERING | IS NULL | Match missing values | SELECT * FROM employees WHERE bonus IS NULL;
FILTERING | IS NOT NULL | Match non-missing values | SELECT * FROM employees WHERE bonus IS NOT NULL;
FILTERING | EXISTS | Keep rows when a subquery returns at least one row | SELECT * FROM departments d WHERE EXISTS (SELECT 1 FROM employees e WHERE e.department_id = d.department_id);
FILTERING | NOT EXISTS | Keep rows when a subquery returns no rows | SELECT * FROM departments d WHERE NOT EXISTS (SELECT 1 FROM employees e WHERE e.department_id = d.department_id);

SORTING_PAGING | ORDER BY ASC | Sort rows ascending | SELECT * FROM employees ORDER BY salary ASC;
SORTING_PAGING | ORDER BY DESC | Sort rows descending | SELECT * FROM employees ORDER BY salary DESC;
SORTING_PAGING | ORDER BY multiple | Sort by more than one expression | SELECT * FROM employees ORDER BY department_id ASC, salary DESC;
SORTING_PAGING | ORDER BY expression | Sort by a calculated value | SELECT * FROM employees ORDER BY salary + IFNULL(bonus, 0) DESC;
SORTING_PAGING | FIELD | Apply a custom sort order in MySQL | SELECT * FROM employees ORDER BY FIELD(job_title, 'CEO', 'Director', 'Manager', 'Analyst');

EXPRESSIONS | CASE | Return values conditionally | SELECT first_name, CASE WHEN salary < 40000 THEN 'low' WHEN salary < 70000 THEN 'mid' ELSE 'high' END AS pay_band FROM employees;
EXPRESSIONS | IF | Return one value or another based on a condition | SELECT first_name, IF(active = 1, 'active', 'inactive') AS status_label FROM employees;
EXPRESSIONS | COALESCE | Return the first non-NULL value | SELECT first_name, COALESCE(bonus, commission, 0) AS extra_pay FROM employees;
EXPRESSIONS | IFNULL | Replace NULL with a fallback value | SELECT first_name, IFNULL(bonus, 0) AS bonus_value FROM employees;
EXPRESSIONS | NULLIF | Return NULL when two expressions are equal | SELECT NULLIF(discount_code, '') AS cleaned_code FROM orders;
EXPRESSIONS | CAST | Convert a value to another data type | SELECT CAST(total_amount AS DECIMAL(10,2)) AS total_decimal FROM orders;
EXPRESSIONS | CONVERT | Convert a value to another MySQL data type | SELECT CONVERT(total_amount, DECIMAL(10,2)) AS total_decimal FROM orders;

AGGREGATION | COUNT() | Count all rows | SELECT COUNT() FROM employees;
AGGREGATION | COUNT(column) | Count non-NULL values in a column | SELECT COUNT(bonus) FROM employees;
AGGREGATION | COUNT(DISTINCT) | Count unique non-NULL values | SELECT COUNT(DISTINCT department_id) FROM employees;
AGGREGATION | SUM | Add numeric values | SELECT SUM(salary) FROM employees;
AGGREGATION | AVG | Compute the average value | SELECT AVG(salary) FROM employees;
AGGREGATION | MIN | Return the smallest value | SELECT MIN(salary) FROM employees;
AGGREGATION | MAX | Return the largest value | SELECT MAX(salary) FROM employees;
AGGREGATION | GROUP BY | Group rows before aggregation | SELECT department_id, AVG(salary) AS avg_salary FROM employees GROUP BY department_id;
AGGREGATION | GROUP BY multiple | Group by more than one column | SELECT department_id, job_title, COUNT(*) AS employee_count FROM employees GROUP BY department_id, job_title;
AGGREGATION | HAVING | Filter grouped results after aggregation | SELECT department_id, AVG(salary) AS avg_salary FROM employees GROUP BY department_id HAVING AVG(salary) > 60000;
AGGREGATION | WITH ROLLUP | Add subtotal and grand total rows in MySQL | SELECT department_id, job_title, SUM(salary) AS total_salary FROM employees GROUP BY department_id, job_title WITH ROLLUP;
AGGREGATION | GROUP_CONCAT | Concatenate grouped string values in MySQL | SELECT department_id, GROUP_CONCAT(first_name ORDER BY first_name SEPARATOR ', ') AS employee_names FROM employees GROUP BY department_id;

JOINS | INNER JOIN | Return rows with matches in both tables | SELECT e.first_name, d.department_name FROM employees e INNER JOIN departments d ON e.department_id = d.department_id;
JOINS | LEFT JOIN | Return all left rows plus matching right rows | SELECT e.first_name, d.department_name FROM employees e LEFT JOIN departments d ON e.department_id = d.department_id;
JOINS | RIGHT JOIN | Return all right rows plus matching left rows | SELECT e.first_name, d.department_name FROM employees e RIGHT JOIN departments d ON e.department_id = d.department_id;
JOINS | CROSS JOIN | Return every combination of rows | SELECT c.color_name, s.size_name FROM colors c CROSS JOIN sizes s;
JOINS | NATURAL JOIN | Join automatically on columns with the same names | SELECT * FROM employees NATURAL JOIN departments;
JOINS | USING | Join on same-named columns more compactly | SELECT * FROM employees JOIN departments USING (department_id);
JOINS | SELF JOIN | Join a table to itself | SELECT e.first_name AS employee, m.first_name AS manager FROM employees e LEFT JOIN employees m ON e.manager_id = m.employee_id;
JOINS | multi-table JOIN | Join more than two tables in one query | SELECT e.first_name, d.department_name, o.office_name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN offices o ON d.office_id = o.office_id;

SUBQUERIES_CTES | scalar subquery | Use a subquery that returns a single value | SELECT first_name, salary FROM employees WHERE salary = (SELECT MAX(salary) FROM employees);
SUBQUERIES_CTES | IN subquery | Match values returned by a subquery | SELECT * FROM employees WHERE department_id IN (SELECT department_id FROM departments WHERE city = 'Berlin');
SUBQUERIES_CTES | correlated subquery | Reference the outer query inside the subquery | SELECT e.first_name FROM employees e WHERE salary > (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id);
SUBQUERIES_CTES | derived table | Use a subquery in the FROM clause | SELECT * FROM (SELECT department_id, AVG(salary) AS avg_salary FROM employees GROUP BY department_id) AS dept_avg WHERE avg_salary > 60000;
SUBQUERIES_CTES | WITH CTE | Define a named temporary result set | WITH dept_avg AS (SELECT department_id, AVG(salary) AS avg_salary FROM employees GROUP BY department_id) SELECT * FROM dept_avg WHERE avg_salary > 60000;
SUBQUERIES_CTES | multiple CTEs | Chain more than one CTE together | WITH active_employees AS (SELECT * FROM employees WHERE active = 1), dept_counts AS (SELECT department_id, COUNT() AS cnt FROM active_employees GROUP BY department_id) SELECT FROM dept_counts;
SUBQUERIES_CTES | WITH RECURSIVE | Build recursive hierarchies in MySQL | WITH RECURSIVE org AS (SELECT employee_id, manager_id, first_name, 0 AS lvl FROM employees WHERE manager_id IS NULL UNION ALL SELECT e.employee_id, e.manager_id, e.first_name, org.lvl + 1 FROM employees e JOIN org ON e.manager_id = org.employee_id) SELECT * FROM org;

SET_OPERATIONS | UNION | Combine result sets and remove duplicates | SELECT email FROM customers UNION SELECT email FROM leads;
SET_OPERATIONS | UNION ALL | Combine result sets and keep duplicates | SELECT email FROM customers UNION ALL SELECT email FROM leads;
SET_OPERATIONS | INTERSECT | Return only rows common to both query blocks in MySQL 8.4 
 | SELECT product_id FROM online_sales INTERSECT SELECT product_id FROM store_sales;
SET_OPERATIONS | EXCEPT | Return rows in the first query but not the second in MySQL 8.4 
 | SELECT product_id FROM online_sales EXCEPT SELECT product_id FROM returned_items;

WINDOW_FUNCTIONS | OVER | Define a window for analytic calculations | SELECT first_name, salary, AVG(salary) OVER () AS company_avg FROM employees;
WINDOW_FUNCTIONS | PARTITION BY | Split rows into groups inside a window | SELECT first_name, department_id, AVG(salary) OVER (PARTITION BY department_id) AS dept_avg FROM employees;
WINDOW_FUNCTIONS | ROW_NUMBER | Assign a unique sequence within a window | SELECT first_name, department_id, salary, ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rn FROM employees;
WINDOW_FUNCTIONS | RANK | Rank rows with gaps after ties | SELECT first_name, salary, RANK() OVER (ORDER BY salary DESC) AS salary_rank FROM employees;
WINDOW_FUNCTIONS | DENSE_RANK | Rank rows without gaps after ties | SELECT first_name, salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank FROM employees;
WINDOW_FUNCTIONS | NTILE | Split ordered rows into buckets | SELECT first_name, salary, NTILE(4) OVER (ORDER BY salary DESC) AS salary_quartile FROM employees;
WINDOW_FUNCTIONS | LAG | Access a previous row value | SELECT order_date, revenue, LAG(revenue) OVER (ORDER BY order_date) AS prev_revenue FROM daily_sales;
WINDOW_FUNCTIONS | LEAD | Access a following row value | SELECT order_date, revenue, LEAD(revenue) OVER (ORDER BY order_date) AS next_revenue FROM daily_sales;
WINDOW_FUNCTIONS | FIRST_VALUE | Return the first value in the frame | SELECT department_id, first_name, FIRST_VALUE(first_name) OVER (PARTITION BY department_id ORDER BY salary DESC) AS top_earner FROM employees;
WINDOW_FUNCTIONS | LAST_VALUE | Return the last value in the frame | SELECT department_id, first_name, LAST_VALUE(first_name) OVER (PARTITION BY department_id ORDER BY salary DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS lowest_earner FROM employees;
WINDOW_FUNCTIONS | SUM OVER | Compute running or partition totals | SELECT order_date, revenue, SUM(revenue) OVER (ORDER BY order_date) AS running_revenue FROM daily_sales;
WINDOW_FUNCTIONS | AVG OVER | Compute moving or partition averages | SELECT order_date, revenue, AVG(revenue) OVER (ORDER BY order_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_3d FROM daily_sales;
WINDOW_FUNCTIONS | WINDOW clause | Reuse a named window definition | SELECT first_name, salary, ROW_NUMBER() OVER w AS rn, RANK() OVER w AS rnk FROM employees WINDOW w AS (PARTITION BY department_id ORDER BY salary DESC);

DML | INSERT INTO VALUES | Insert one row explicitly | INSERT INTO employees (employee_id, first_name, salary, department_id) VALUES (1001, 'Ava', 65000, 10);
DML | INSERT multiple rows | Insert many rows in one statement | INSERT INTO employees (employee_id, first_name) VALUES (1002, 'Noah'), (1003, 'Mia');
DML | INSERT INTO SELECT | Insert rows returned by a query | INSERT INTO employee_archive SELECT * FROM employees WHERE active = 0;
DML | INSERT ... ON DUPLICATE KEY UPDATE | Upsert rows in MySQL when a unique key already exists | INSERT INTO inventory (product_id, qty) VALUES (1, 5) ON DUPLICATE KEY UPDATE qty = qty + VALUES(qty);
DML | REPLACE INTO | Insert or replace an existing row in MySQL | REPLACE INTO settings (setting_key, setting_value) VALUES ('theme', 'dark');
DML | UPDATE | Modify existing rows | UPDATE employees SET salary = salary * 1.05 WHERE department_id = 10;
DML | UPDATE JOIN | Update using a join in MySQL | UPDATE employees e JOIN departments d ON e.department_id = d.department_id SET e.bonus = 1000 WHERE d.city = 'Berlin';
DML | DELETE | Remove rows matching a condition | DELETE FROM employees WHERE active = 0;
DML | DELETE JOIN | Delete rows using a join in MySQL | DELETE e FROM employees e JOIN departments d ON e.department_id = d.department_id WHERE d.city = 'Berlin';
DML | TRUNCATE TABLE | Remove all rows quickly and reset auto-increment | TRUNCATE TABLE staging_employees;
DML | LOAD DATA INFILE | Bulk load CSV-like data into a MySQL table | LOAD DATA INFILE '/tmp/employees.csv' INTO TABLE employees FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

DDL | CREATE DATABASE | Create a new database | CREATE DATABASE company_db;
DDL | DROP DATABASE | Remove a database | DROP DATABASE company_db;
DDL | CREATE TABLE | Create a table with defined columns | CREATE TABLE employees (employee_id INT PRIMARY KEY, first_name VARCHAR(100), salary DECIMAL(10,2), department_id INT);
DDL | CREATE TABLE AS SELECT | Create a table from a query result | CREATE TABLE high_earners AS SELECT * FROM employees WHERE salary > 80000;
DDL | CREATE TABLE LIKE | Copy the structure of an existing table | CREATE TABLE employees_backup LIKE employees;
DDL | CREATE TEMPORARY TABLE | Create a session-only temporary table | CREATE TEMPORARY TABLE temp_ids (id INT);
DDL | ALTER TABLE ADD COLUMN | Add a new column to a table | ALTER TABLE employees ADD COLUMN email VARCHAR(255);
DDL | ALTER TABLE MODIFY COLUMN | Change a column definition in MySQL | ALTER TABLE employees MODIFY COLUMN salary DECIMAL(12,2);
DDL | ALTER TABLE CHANGE COLUMN | Rename and redefine a column in one step | ALTER TABLE employees CHANGE COLUMN first_name given_name VARCHAR(100);
DDL | ALTER TABLE RENAME COLUMN | Rename a column | ALTER TABLE employees RENAME COLUMN given_name TO first_name;
DDL | ALTER TABLE DROP COLUMN | Remove a column | ALTER TABLE employees DROP COLUMN email;
DDL | RENAME TABLE | Rename a table | RENAME TABLE employees TO staff;
DDL | DROP TABLE | Remove a table permanently | DROP TABLE staff;
DDL | CREATE VIEW | Create a virtual table from a query | CREATE VIEW v_employee_pay AS SELECT employee_id, first_name, salary FROM employees;
DDL | DROP VIEW | Remove a view | DROP VIEW v_employee_pay;

CONSTRAINTS_INDEXES | PRIMARY KEY | Uniquely identify each row | CREATE TABLE departments (department_id INT PRIMARY KEY, department_name VARCHAR(100));
CONSTRAINTS_INDEXES | FOREIGN KEY | Enforce relationships between tables | CREATE TABLE employees (employee_id INT PRIMARY KEY, department_id INT, CONSTRAINT fk_emp_dept FOREIGN KEY (department_id) REFERENCES departments(department_id));
CONSTRAINTS_INDEXES | UNIQUE | Prevent duplicate values | CREATE TABLE users (user_id INT PRIMARY KEY, email VARCHAR(255) UNIQUE);
CONSTRAINTS_INDEXES | NOT NULL | Require a value in a column | CREATE TABLE products (product_id INT PRIMARY KEY, product_name VARCHAR(100) NOT NULL);
CONSTRAINTS_INDEXES | CHECK | Enforce a validation rule | CREATE TABLE salaries (employee_id INT PRIMARY KEY, amount DECIMAL(10,2), CHECK (amount >= 0));
CONSTRAINTS_INDEXES | DEFAULT | Set a fallback value when none is supplied | CREATE TABLE tasks (task_id INT PRIMARY KEY, status VARCHAR(20) DEFAULT 'open');
CONSTRAINTS_INDEXES | AUTO_INCREMENT | Generate sequential integer IDs automatically | CREATE TABLE logs (log_id INT AUTO_INCREMENT PRIMARY KEY, message VARCHAR(255));
CONSTRAINTS_INDEXES | ON DELETE CASCADE | Delete child rows when the parent is deleted | CREATE TABLE employees (employee_id INT PRIMARY KEY, department_id INT, CONSTRAINT fk_emp_dept FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE CASCADE);
CONSTRAINTS_INDEXES | ON DELETE SET NULL | Set child foreign keys to NULL when parent is deleted | CREATE TABLE employees (employee_id INT PRIMARY KEY, department_id INT NULL, CONSTRAINT fk_emp_dept FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE SET NULL);
CONSTRAINTS_INDEXES | ON UPDATE CASCADE | Propagate parent key updates to child rows | CREATE TABLE employees (employee_id INT PRIMARY KEY, department_id INT, CONSTRAINT fk_emp_dept FOREIGN KEY (department_id) REFERENCES departments(department_id) ON UPDATE CASCADE);
CONSTRAINTS_INDEXES | CREATE INDEX | Create a non-unique index for faster lookups | CREATE INDEX idx_emp_department ON employees(department_id);
CONSTRAINTS_INDEXES | CREATE UNIQUE INDEX | Create an index that also enforces uniqueness | CREATE UNIQUE INDEX idx_users_email ON users(email);
CONSTRAINTS_INDEXES | composite index | Index multiple columns together | CREATE INDEX idx_emp_dept_salary ON employees(department_id, salary);
CONSTRAINTS_INDEXES | FULLTEXT index | Create a full-text index in MySQL | CREATE FULLTEXT INDEX idx_articles_body ON articles(body);
CONSTRAINTS_INDEXES | DROP INDEX | Remove an index from a table | DROP INDEX idx_emp_department ON employees;

TRANSACTIONS_LOCKING | START TRANSACTION | Begin an explicit transaction | START TRANSACTION;
TRANSACTIONS_LOCKING | COMMIT | Save all changes in the current transaction | COMMIT;
TRANSACTIONS_LOCKING | ROLLBACK | Undo changes in the current transaction | ROLLBACK;
TRANSACTIONS_LOCKING | SAVEPOINT | Mark a point you can roll back to | SAVEPOINT before_bonus_update;
TRANSACTIONS_LOCKING | ROLLBACK TO SAVEPOINT | Roll back to a named savepoint | ROLLBACK TO SAVEPOINT before_bonus_update;
TRANSACTIONS_LOCKING | SET TRANSACTION ISOLATION LEVEL | Set isolation for the next transaction | SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
TRANSACTIONS_LOCKING | SET autocommit | Turn automatic commit on or off | SET autocommit = 0;
TRANSACTIONS_LOCKING | FOR UPDATE | Lock selected rows for update | SELECT * FROM jobs WHERE status = 'queued' FOR UPDATE;
TRANSACTIONS_LOCKING | FOR UPDATE SKIP LOCKED | Skip rows already locked by other transactions | SELECT * FROM jobs WHERE status = 'queued' FOR UPDATE SKIP LOCKED;
TRANSACTIONS_LOCKING | FOR UPDATE NOWAIT | Fail immediately if target rows are locked | SELECT * FROM jobs WHERE job_id = 10 FOR UPDATE NOWAIT;

STRING_FUNCTIONS | CONCAT | Join strings together | SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM employees;
STRING_FUNCTIONS | CONCAT_WS | Join strings with a separator | SELECT CONCAT_WS(' - ', first_name, job_title, department_id) AS label FROM employees;
STRING_FUNCTIONS | LENGTH | Return string length in bytes | SELECT LENGTH(first_name) FROM employees;
STRING_FUNCTIONS | CHAR_LENGTH | Return string length in characters | SELECT CHAR_LENGTH(first_name) FROM employees;
STRING_FUNCTIONS | UPPER | Convert text to uppercase | SELECT UPPER(first_name) FROM employees;
STRING_FUNCTIONS | LOWER | Convert text to lowercase | SELECT LOWER(email) FROM users;
STRING_FUNCTIONS | TRIM | Remove leading and trailing spaces | SELECT TRIM(' hello ') AS cleaned_text;
STRING_FUNCTIONS | REPLACE | Replace part of a string | SELECT REPLACE(email, '@old.com', '@new.com') FROM users;
STRING_FUNCTIONS | SUBSTRING | Extract part of a string | SELECT SUBSTRING(first_name, 1, 3) FROM employees;
STRING_FUNCTIONS | LEFT | Return the leftmost characters | SELECT LEFT(first_name, 2) FROM employees;
STRING_FUNCTIONS | RIGHT | Return the rightmost characters | SELECT RIGHT(first_name, 2) FROM employees;
STRING_FUNCTIONS | LPAD | Pad text on the left | SELECT LPAD(employee_id, 6, '0') FROM employees;
STRING_FUNCTIONS | RPAD | Pad text on the right | SELECT RPAD(first_name, 10, '.') FROM employees;

NUMERIC_FUNCTIONS | ROUND | Round a number to a given precision | SELECT ROUND(1234.567, 2);
NUMERIC_FUNCTIONS | FLOOR | Round down to the nearest integer | SELECT FLOOR(1234.567);
NUMERIC_FUNCTIONS | CEIL | Round up to the nearest integer | SELECT CEIL(1234.001);
NUMERIC_FUNCTIONS | ABS | Return the absolute value | SELECT ABS(-42);
NUMERIC_FUNCTIONS | MOD | Return the remainder after division | SELECT MOD(10, 3);
NUMERIC_FUNCTIONS | RAND | Return a random decimal between 0 and 1 | SELECT RAND();

DATE_TIME | CURDATE | Return the current date | SELECT CURDATE();
DATE_TIME | CURTIME | Return the current time | SELECT CURTIME();
DATE_TIME | NOW | Return the current date and time | SELECT NOW();
DATE_TIME | DATE_ADD | Add an interval to a date | SELECT DATE_ADD(order_date, INTERVAL 7 DAY) AS next_week FROM orders;
DATE_TIME | DATE_SUB | Subtract an interval from a date | SELECT DATE_SUB(order_date, INTERVAL 1 MONTH) AS prev_month FROM orders;
DATE_TIME | DATEDIFF | Return difference in days between two dates | SELECT DATEDIFF(CURDATE(), hire_date) AS days_employed FROM employees;
DATE_TIME | TIMESTAMPDIFF | Return difference in a chosen time unit | SELECT TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS years_employed FROM employees;
DATE_TIME | EXTRACT | Pull a part from a date or datetime | SELECT EXTRACT(YEAR FROM hire_date) AS hire_year FROM employees;
DATE_TIME | DATE_FORMAT | Format a date as text in MySQL | SELECT DATE_FORMAT(hire_date, '%Y-%m-%d') AS hire_date_fmt FROM employees;
DATE_TIME | STR_TO_DATE | Parse text into a date | SELECT STR_TO_DATE('2026-04-24', '%Y-%m-%d') AS parsed_date;
DATE_TIME | LAST_DAY | Return the last day of the month | SELECT LAST_DAY(order_date) AS month_end FROM orders;

JSON | JSON_OBJECT | Build a JSON object from key-value pairs | SELECT JSON_OBJECT('name', first_name, 'salary', salary) AS employee_json FROM employees;
JSON | JSON_ARRAY | Build a JSON array from values | SELECT JSON_ARRAY(first_name, job_title, salary) AS employee_array FROM employees;
JSON | JSON_EXTRACT | Extract JSON data by path | SELECT JSON_EXTRACT(profile, '$.city') AS city FROM users;
JSON | -> | Shorthand JSON path extraction | SELECT profile->'$.city' AS city_json FROM users;
JSON | ->> | Shorthand JSON extraction as unquoted text | SELECT profile->>'$.city' AS city_text FROM users;
JSON | JSON_SET | Update or add a JSON value by path | UPDATE users SET profile = JSON_SET(profile, '$.city', 'Berlin') WHERE user_id = 1;
JSON | JSON_CONTAINS | Test whether JSON contains a value | SELECT * FROM products WHERE JSON_CONTAINS(tags, JSON_QUOTE('featured'));
JSON | JSON_ARRAYAGG | Aggregate rows into a JSON array | SELECT department_id, JSON_ARRAYAGG(first_name) AS employee_names FROM employees GROUP BY department_id;
JSON | JSON_OBJECTAGG | Aggregate key-value pairs into a JSON object | SELECT JSON_OBJECTAGG(employee_id, first_name) AS employee_map FROM employees;
JSON | JSON_TABLE | Convert JSON data into relational rows | SELECT * FROM JSON_TABLE('[{"id":1,"name":"Ava"}]', '$[*]' COLUMNS (id INT PATH '$.id', name VARCHAR(50) PATH '$.name')) AS jt;

UTILITY_METADATA | SHOW DATABASES | List available databases | SHOW DATABASES;
UTILITY_METADATA | SHOW TABLES | List tables in the current database | SHOW TABLES;
UTILITY_METADATA | SHOW COLUMNS | List columns in a table | SHOW COLUMNS FROM employees;
UTILITY_METADATA | DESCRIBE | Show a table structure summary | DESCRIBE employees;
UTILITY_METADATA | SHOW CREATE TABLE | Return the DDL used to create a table | SHOW CREATE TABLE employees;
UTILITY_METADATA | DATABASE | Return the current database name | SELECT DATABASE();
UTILITY_METADATA | USER | Return the current MySQL account | SELECT USER();
UTILITY_METADATA | VERSION | Return the MySQL server version | SELECT VERSION();
UTILITY_METADATA | INFORMATION_SCHEMA.TABLES | Query table metadata | SELECT table_name FROM information_schema.tables WHERE table_schema = 'company_db';
UTILITY_METADATA | INFORMATION_SCHEMA.COLUMNS | Query column metadata | SELECT column_name, data_type FROM information_schema.columns WHERE table_schema = 'company_db' AND table_name = 'employees';

PERFORMANCE | EXPLAIN | Show the execution plan for a query | EXPLAIN SELECT * FROM employees WHERE department_id = 10;
PERFORMANCE | EXPLAIN ANALYZE | Execute a query and show actual plan details | EXPLAIN ANALYZE SELECT * FROM employees WHERE department_id = 10;
PERFORMANCE | ANALYZE TABLE | Update table statistics | ANALYZE TABLE employees;
PERFORMANCE | OPTIMIZE TABLE | Reorganize and optimize a table in MySQL | OPTIMIZE TABLE employees;
PERFORMANCE | USE INDEX | Hint MySQL to prefer a specific index | SELECT * FROM employees USE INDEX (idx_emp_department) WHERE department_id = 10;
PERFORMANCE | FORCE INDEX | Force MySQL to use a specific index | SELECT * FROM employees FORCE INDEX (idx_emp_department) WHERE department_id = 10;
PERFORMANCE | IGNORE INDEX | Tell MySQL not to use a specific index | SELECT * FROM employees IGNORE INDEX (idx_emp_department) WHERE salary > 50000;

SECURITY | CREATE USER | Create a new MySQL user account | CREATE USER 'analyst'@'localhost' IDENTIFIED BY 'StrongPass!23';
SECURITY | ALTER USER | Change account properties such as password | ALTER USER 'analyst'@'localhost' IDENTIFIED BY 'NewStrongPass!23';
SECURITY | DROP USER | Remove a user account | DROP USER 'analyst'@'localhost';
SECURITY | CREATE ROLE | Create a reusable privilege role | CREATE ROLE 'readonly_role';
SECURITY | GRANT | Give privileges to a user or role | GRANT SELECT, INSERT ON company_db.* TO 'analyst'@'localhost';
SECURITY | REVOKE | Remove previously granted privileges | REVOKE INSERT ON company_db.* FROM 'analyst'@'localhost';
SECURITY | GRANT role | Assign a role to a user | GRANT 'readonly_role' TO 'analyst'@'localhost';
SECURITY | SET DEFAULT ROLE | Set which role is active by default | SET DEFAULT ROLE 'readonly_role' TO 'analyst'@'localhost';