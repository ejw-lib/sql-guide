# SQL Guide
Notes and resources about SQL  

###  Overview
A very common method method to search a Relational Database Mangement System (RDBMS) is through Structured Query Language (SQL).  This is a very old language but more recently object-relational dababase model (ORDM) has become another popular way of accessing databases [Ref](https://www.techopedia.com/definition/8714/object-relational-database-ord).  

### Three Types of Non-Administrative SQL (Languages)
- DDL - Data Definition Language:  Creation of the Schema (Tables and Relationships/Constraints)
        Create, Drop, Alter, Truncate
- DML - Data Manipulation Language: Change the contents within the Tables
        Insert, Update, Delete
- DQL - Data Query Language: Retreive data from the schema/tables
        Select, .... see below
[References](https://www.guru99.com/sql-commands-dbms-query.html)


### Key Concepts Related to Above SQL Languages
Create, Read, Update, Delete (CRUD)  

### Important DQL Concepts
* General Queries - SELECT FROM patterns
* Filters - WHICH with AND/OR/NOT and LIKE/IN/BETWEEN
* Filters with [Regular Expressions](https://www.postgresql.org/docs/current/functions-matching.html)
* Limit results - TOP or LIMIT/DISTINCT
* Aggregations - HAVING with AggFunc
* Modify Data - CAST, DATEDIFF
* Subquery from SELECT, FROM, WHICH
* Joining Tables - INNER JOIN, RIGHT/LEFT JOIN, CROSS (aka CARTESIAN) JOIN, FULL (aka OUTER) JOIN
* Self Join
* Restructuring Data - CASES
* Windows Functions - OVER
* Common Table Expressions (CTE) - WITH AS patterns
* Recursive CTE - WITH AS UNION WHERE patterns

### Other Common Terms
* Derived Table - a subquery nested within a FROM clause
* Correlated Table/Query - DML lingo meaning that the query has an inner and outer query, where outer query depends on results of the inner query
* Uncorrelated Table/Query - DML lingo meaning that the queries are independent  
* Deterministic Function - returns the same results every time given the same inputs
* Non-Deterministic Function - doesn't necessarily return the same results given the same inputs  
* Entity Table - specific, real world distinguisble objects.  Example:  Cars table with cars as records or People with people as entities.  Typically will have one PK.
* Junction Table / Association Table - shows relationship between entities.  Typically will be both PK and FK.  By definition, a FK references a PK from another entity table.
### Creating Queries

**Order of Operations**  
1.  FROM
1.  WHERE
1.  GROUP BY
1.  HAVING
1.  SELECT
1.  ORDER BY
1.  LIMIT
[Ref](https://www.sisense.com/blog/sql-query-order-of-operations/)

**Operators**
* Typically used within WHERE clauses to perform a task
* Here are 6 operators:
    * Arithmetic (`+, -, *, /, %`)
    * Bitwise (`&, &=, |,|=, ^, ~`)
    * Comparison (`=,!=,>,!>,<, !<, >=, <=, <>`)
    * Compound (`+=, -=, *=, /=, %=`)
    * Logical (`ALL, ANY, SOME, AND, BETWEEN, EXISTS, IN, LIKE, NOT, OR, IS NULL`)
    * String (`+, +=, %, [], [^], _ `)
[Ref](https://www.dataquest.io/blog/sql-operators/)

**Optimizing Queries:**  
- Since queries can be written in many ways, it is necessary to analyze queries for the amount of time and memory that they require.  The easist way of doing this is by using built in tools of your RDBMS.  In some database systems, the tool is easily accessible and has a nice graphical interface.  With postgreSQL, using `ANALYZE` in the query builder will provide information about the query performance.  In many cases the way you write the query does not matter since the query engine will take the query and optimize it before execution.  The execution steps are what you will need to look at to determine the bottlenecks.  

Here is an example of how the same end result can be written in two ways:   

`SELECT FROM JOIN WHERE`  
This executes the Join first then the Where.  
  
<br>

`WITH foo AS (SELECT FROM WHERE), foo2 as (SELECT FROM WHERE)`    
`SELECT FROM JOIN`  
This executes the Where first then the Join  

### Creating the Schema  

*** Entity Relationship Diagrams (ERD)**  
It is best practice to layout tables and their constraints in a visual diagram.  This is often done with an ERD.  Although important, generation of the diagrams by an RDBMS tool from an existing schema is now common so developers can make the schema outside their RDBMS or generate the actual schema and then visualize it throughout development.  

**Normalization of RDBMS**  
`First Normal Form (1NF)` -  Removing nested data of a cell within a row to be represented as multiple rows of singular data within cells (atomicity)
`Second Normal Form (2NF)` - Columns should be independent (no partial dependency) and columns not independent need to be split into their own tables.  
`Third Normal Form (3NF)` - The columns in the table should only have direct relations (no transitive dependencies) with the other columns and if they don't then typically the indirect relations should be moved to their own table with it's own primary key identify the entity.
`Boyce Codd Normal Form (BCNF aka 3.5NF)` - The non-key columns should depend on the super key  
[Ref](https://www.simplilearn.com/tutorials/sql-tutorial/what-is-normalization-in-sql)



## Query Scenarios

>> Coming Soon  

>> Other commands to include:  INTO, OPTION, FOR BROWSE, PARTITION, UNION, UNION ALL, ROLLUP, ALL, ANY, EXISTS  

### Additional History of SQL
Relational Databases Management Systems (RDMS) were developed in the 1960s and a standard management method (Structured Query Language - SQL ) was developed in the 1970s.  Relational databases work well on large datasets because the underlying concept of what makes them work is relational algebra and relational calculus.  SQL itself is a declarative programming language - essentially, we say what we want in the languages terminology and it executes the process without us telling it through logic how to do the task.  Each RMDS has an optimization engine the decides the best way to execute the request so in many situations whether you write a query in one way or another does not matter because the management system will decide the best way of reordering the logical steps.