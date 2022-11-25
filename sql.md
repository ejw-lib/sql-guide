# SQL Fundamentals

## Things to Know
* Subquery from Select
* Subquery from From
* Subquery from Which
* Pre-filter
* Recursion 
* Recursive CTE
* Non-Recursive CTE
* INNER JOIN
* CROSS JOIN
* RIGHT/LEFT JOIN
* FULL JOIN ?


### Pre-Filtering

**Execution matters:**  
<br>
ORDER OF OPERATION


`SELECT FROM JOIN WHERE`  
This executes the Join first then the Where.  
  
<br>

`WITH foo AS (SELECT FROM WHERE), foo2 as (SELECT FROM WHERE)`    
`SELECT FROM JOIN`  
This executes the Where first then the Join  

<br>

## Subqueries  

### Within SELECT Statements

```
SELECT employee.emp_no, 
    (SELECT dept_no
        FROM dept_emp
        WHERE employee.emp_no = dept_emp.emp_no)

FROM employee
```



### Within WHERE Clause



## Terminology  
* RDBMS - Relational Database Mangement System
* ORDM - object-relational dababase model [Ref](https://www.techopedia.com/definition/8714/object-relational-database-ord)

*  [Types of Queries](https://www.guru99.com/sql-commands-dbms-query.html)  
    *  **DDL - Data Definition Language**
    *  **DML - Data Manipulation Language**
    *  DCL - Data Control Language  
    *  TCL - Transaction Control Language  
    *  DQL - Data Query Language  
* Entity Table - specific, real world distinguisble objects
    * Example:  Cars table with cars as records or People with people as entities.  Typically will have one PK.
* Junction Table / Association Table - shows relationship between entities.  Typically will be both PK and FK.  By definition, a FK references a PK in another entity table.

*  Filters:  WHICH with AND/OR/NOT and LIKE/IN/BETWEEN
*  Aggregations:  HAVING with AggFunc
*  Limit results:  TOP or LIMIT/DISTINCT
*  JOINS  
  *  INNER JOIN (default)
  *  LEFT/RIGHT JOIN
  *  CROSS JOIN
  *  FULL OUTER JOIN

## Types of DML Queries  

*  Correlated Subquery - has inner and outer query, where outer query depends on results of the inner query
*  Uncorrelated Subquery - independent query

## Concept of DDL  

CRUD - Create, Read, Update, Delete

## Normalization
1NF
2NF
3NF
