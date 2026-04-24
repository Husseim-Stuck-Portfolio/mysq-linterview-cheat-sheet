# mysq-linterview-cheat-sheet
A practical, well-organized "MySQL cheat sheet" covering core SQL queries, filtering, joins, grouping, aggregation, subqueries, CTEs, window functions, DDL, DML, transactions, JSON, indexing, and performance tuning in MySQL


# MySQL Cheat Sheet for Beginners and Analysts

A practical, well-organized **MySQL cheat sheet** covering core SQL queries, filtering, joins, grouping, aggregation, subqueries, CTEs, window functions, DDL, DML, transactions, JSON, indexing, and performance tuning in MySQL 8.4.

This repository is designed for data analytics students, junior analysts, bootcamp learners, and developers who want a fast, searchable, real-world SQL reference with corrected syntax examples and logically grouped query patterns.

## Contributing

Contributions are welcome if you want to improve examples, fix syntax, expand MySQL coverage, or add more real-world analytics use cases.

## Why this MySQL Cheat Sheet?

If you are learning SQL for data analytics, business intelligence, backend development, or technical interviews, this project gives you a single place to review the most useful MySQL commands and patterns.

It focuses on:
- MySQL-first syntax
- Clear examples you can reuse quickly
- Logical grouping by topic
- Short explanations for fast scanning
- Common interview and day-to-day queries
- Cleanup of mixed SQL dialect examples from broader SQL references

## What’s Included

This MySQL cheat sheet includes:

- SELECT statements
- WHERE filtering
- ORDER BY and pagination
- CASE, IF, COALESCE, IFNULL, CAST
- GROUP BY, HAVING, ROLLUP, GROUP_CONCAT
- INNER JOIN, LEFT JOIN, RIGHT JOIN, CROSS JOIN, SELF JOIN
- Subqueries and correlated subqueries
- CTEs and recursive CTEs
- UNION, UNION ALL, INTERSECT, EXCEPT
- Window functions
- INSERT, UPDATE, DELETE, REPLACE, UPSERT-style patterns
- CREATE TABLE, ALTER TABLE, views, indexes, constraints
- Transactions and row locking
- String, numeric, and date functions
- JSON functions in MySQL
- Metadata, EXPLAIN, and optimization basics
- User and role management

## Who This Repository Is For

This repository is useful for:

- Data analytics students learning SQL and MySQL
- Bootcamp students building portfolio projects
- Junior data analysts preparing for interviews
- Developers who need a quick MySQL syntax reference
- Anyone converting generic SQL notes into valid MySQL syntax

## Repository Structure

```text
.
├── README.md
├── mysql_cheat_sheet.csv
├── mysql_cheat_sheet.md
└── source_files/
```

Suggested file purpose:
- `README.md` → SEO-friendly landing page and project overview
- `mysql_cheat_sheet.csv` → pipe-delimited or structured cheat sheet data
- `mysql_cheat_sheet.md` → readable markdown version
- `source_files/` → raw source material used for extraction and cleanup

## Main Topics

### 1. Foundations
Basic commands such as `USE`, `SELECT`, `SELECT DISTINCT`, aliases, and row limiting.

### 2. Filtering and Sorting
Essential row filtering with `WHERE`, `IN`, `BETWEEN`, `LIKE`, `REGEXP`, `IS NULL`, plus sorting and pagination.

### 3. Expressions and Conditional Logic
Useful expressions including `CASE`, `IF`, `COALESCE`, `IFNULL`, `NULLIF`, `CAST`, and `CONVERT`.

### 4. Grouping and Aggregation
Core analytics patterns with `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `GROUP BY`, `HAVING`, `WITH ROLLUP`, and `GROUP_CONCAT`.

### 5. Joins
Practical joins including `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `CROSS JOIN`, `USING`, and self joins.

### 6. Subqueries and CTEs
Scalar subqueries, correlated subqueries, derived tables, standard CTEs, and recursive CTEs.

### 7. Set Operations
Result-set combination with `UNION`, `UNION ALL`, `INTERSECT`, and `EXCEPT` in modern MySQL versions.

### 8. Window Functions
Analytical SQL patterns using `ROW_NUMBER`, `RANK`, `DENSE_RANK`, `LAG`, `LEAD`, `SUM() OVER`, and `AVG() OVER`.

### 9. Data Modification
Row changes with `INSERT`, multi-row insert, `INSERT INTO ... SELECT`, `UPDATE`, `DELETE`, `REPLACE INTO`, and duplicate-key update patterns.

### 10. DDL and Constraints
Schema design commands such as `CREATE TABLE`, `ALTER TABLE`, indexes, primary keys, foreign keys, unique constraints, and defaults.

### 11. Transactions and Locking
Transaction control with `START TRANSACTION`, `COMMIT`, `ROLLBACK`, `SAVEPOINT`, and row locking like `FOR UPDATE`.

### 12. MySQL Functions
String functions, numeric functions, date/time functions, and JSON handling.

### 13. Performance and Metadata
`EXPLAIN`, `EXPLAIN ANALYZE`, `ANALYZE TABLE`, `OPTIMIZE TABLE`, `SHOW TABLES`, `DESCRIBE`, and `INFORMATION_SCHEMA`.

## Example Queries

### Basic SELECT
```sql
SELECT first_name, salary
FROM employees
WHERE salary > 50000
ORDER BY salary DESC
LIMIT 10;
```

### GROUP BY Example
```sql
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 60000;
```

### JOIN Example
```sql
SELECT e.first_name, d.department_name
FROM employees e
INNER JOIN departments d
  ON e.department_id = d.department_id;
```

### Window Function Example
```sql
SELECT
  first_name,
  department_id,
  salary,
  ROW_NUMBER() OVER (
    PARTITION BY department_id
    ORDER BY salary DESC
  ) AS salary_rank
FROM employees;
```

## SEO Keywords Targeted

- MySQL cheat sheet
- SQL cheat sheet for beginners
- MySQL query examples
- MySQL syntax reference
- SQL interview cheat sheet
- MySQL joins and group by examples
- MySQL window functions cheat sheet
- MySQL commands for data analysts
- MySQL 8.4 cheat sheet
- SQL portfolio project README

## How This Cheat Sheet Was Built

This project was created by extracting SQL patterns from source notes and attached reference files, then reorganizing and correcting them into a MySQL-focused structure.

The cleanup process included:
- grouping related queries together
- removing duplicates
- replacing non-MySQL syntax where needed
- preserving practical examples
- making the sheet easier to scan and search

## Best Ways to Use This Project

- Review before SQL interviews
- Use as a quick command lookup during projects
- Study one section at a time
- Compare generic SQL syntax with MySQL-specific syntax
- Add your own examples as you learn

## Contributing

Contributions are welcome if you want to improve examples, fix syntax, expand MySQL coverage, or add more real-world analytics use cases.

Suggested contribution ideas:
- add more MySQL 8.4 examples
- improve query explanations
- add edge cases and caveats
- add sample datasets
- add performance tuning examples

## License

MIT for open reuse

## Author

Created as a practical MySQL learning and reference resource for SQL study, portfolio work, and analytics practice.
