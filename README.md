# Pewlett Hackard Analysis

## Overview of Project:

Pewlett-Hackard is one of the largest company in its field and there is a upcoming "Silver Tsunami" in few years. They wanted to be ready for it so that an HR analysis Bobby was assigned for creating databases and my job is to help Bobby to build an Employee Database with SQL by utilizing my Data Modelling, Engineering, and Analysis skills. 


#### Purpose of Pewlett Hackard Analysis :

Our main purpose to answer two fundamental questions for Pewlett-Hackard  :
* 1- Who will be retiring in next few years ?
* 2- How many positions will Pewlett-Hackard need to fill ?

To answers mentioned questions, Bobby and myself decided that we needed to create following datasets : 

*The Number of Retiring Employees by Title:
    ** Calculate the sum of retiring employees grouped by title
    **Calculate the number of roles the company needs to fill by grouping title and department.
*The Employees Eligible for the Mentorship Program:
    ** Calculate number retiring employees to mentor new hired by grouping by title and department.
    
This analysis will also help future-proof Pewlett-Hackard by generating a list of all employees eligible for retirement package 


## Analysis

The data is gathered in six CSV files and the analysis is performed using relational databases. In this analysis we are using:

* QuickDBD to create quick database design for better visualization,
* PostreSQL a database system to load, build and host company’s data, and
* pgAdmin a GUI, using SQL Language to explore, manipulate and extract the data.

As first part of the analysis, we quickly scanned six datasets that was provided by the HR and identify the components that are vital for creating targeted databases:
1- Primary Key for each dataset : That is a unique key for each dataset 
2- Foreign Key for each dataset : That is a key to connect dataset to each other. 

##### ERD and Schema :

Next, we created an Entity Relation Diagram (ERDS) by using " Quick DBD " that will assist us to demonstrate varies relations between each and every datasets as in Image-1 .


#####

Lastly, we started creating databases by usiung provided datasets and utilizing PostGres for holding data and PgAdmin which is an interface  to communicate with P0stGres. 


## Results :

1. Retiring Employees Table :
    * Employee number, first name, last name, title, from-date and to-date.
    * The table displays a list of employees who is going to retire in the next few years.
    * There are 133,776 employees in the list. 

To generate this list, we used following query to combine two datasets "employees.csv and title.csv" then filtered it by using <code> WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') </code>. As we investigate through out this data, there are duplicates in our table. In order to eliminates the duplicates, we will use <code> Distinct ON () </code> clause to retrieve a filtered table as our next piece of results. 

2. Retiring employees without duplicates :
    * This table is a derivative of first table with not duplicate information. 
    * The table displays a list of employees who is going to retire in the next few years and also shown their most current position that is one of benefit using <code> Distinct ON () </code> clause. 
    * There are 90,398 employees in the list.

To generate this list, we used following query to combine two datasets "employees.csv and title.csv" then filtered it by using <code> WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') </code> in addition to this code block, this table was ordered by <code> Order BY emp_no</code> then <code> to_date DESC </code>.
 
3. Total  number of retiring employees by Job Title : 

    
    
