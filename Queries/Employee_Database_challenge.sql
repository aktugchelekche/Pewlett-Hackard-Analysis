-- Creating tables for PH-EmployeeDB
---------------------------------------------------------------------------------------------------------------------

CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);
Select * From departments

CREATE TABLE employees (
     emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

Select * From employees

CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

Select * From dept_manager



CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);
Select * From salaries


CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
  FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
  FOREIGN KEY (emp_no)  REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no, dept_no)
);



CREATE TABLE titles (
    emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

select * from titles as t 
select * from employees as e 
select * from departments  as d
select * from dept_emp as d_e
select * from dept_manager as d_m
select * from salaries as s


--Deliverable 1: 
---------------------------------------------------------------------------------------------------------------------

-- 1. The Number of Retiring Employees by Title:


Select e.emp_no , 
e.first_name , 
e.last_name,
t.title,
t.from_date,
t.to_date 
INTO retirement_titles 
From employees as e 
JOIN titles as t 
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
order by e.emp_no;

select * from retirement_titles limit 100

--2. The Number of Retiring Employees by Title (Duplicates Removev BY DISTINCT ON()):

SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles 
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

select * from unique_titles limit 100 

-- 3. The number of employees by their most recent  title  about to retire :

SELECT COUNT(title) ,title 
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC

select * from retiring_titles limit 10

--Deliverable 2: 

-----------------------------------------------------------------------------------------------------------------
--1. The Employees Eligible for the Mentorship Program.

SELECT DISTINCT ON (e.emp_no) e.emp_no ,  
e.first_name,
e.last_name,
e.birth_date,
d_e.from_date,
d_e.to_date,
t.title
INTO mentorship_eligibilty
FROM employees as e
JOIN dept_emp as d_e 
ON (e.emp_no = d_e.emp_no)
JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (d_e.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')

SELECT * FROM mentorship_eligibilty 

--Supporting Tables for Deliverable 3 :
----------------------------------------------------------------------------------------------------------

-- 1. Roles per Staff and Departament (Retirement Titles table does not have DEPT_NAME)
SELECT DISTINCT ON (rt.emp_no) 
	rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title,
	d.dept_name
INTO unique_per_department
FROM retirement_titles as rt
JOIN dept_emp as d_e
ON (rt.emp_no = d_e.emp_no)
JOIN departments as d
ON (d.dept_no = d_e.dept_no)
ORDER BY rt.emp_no, rt.to_date DESC;

SELECT * FROM unique_per_department limit 100


-- 2.  Number of Specific Role needed per Department 
SELECT dept_name, 
title,
COUNT(title) 
INTO department_need
FROM unique_per_department 
GROUP BY title, dept_name
ORDER BY dept_name DESC








