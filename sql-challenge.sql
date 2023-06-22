-- Create titles table
create table titles (
	title_id VARCHAR(7) PRIMARY KEY NOT NULL,
	title VARCHAR(40) NOT NULL
);

-- Create employees table
create table employees (
	emp_no INT PRIMARY KEY NOT NULL,
	emp_title VARCHAR(7)NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(35) NOT NULL,
	last_name VARCHAR(35) NOT NULL,
	sex VARCHAR(1)NOT NULL,
	hire_date DATE NOT NULL,
	foreign key (emp_title) references titles (title_id)
);

-- Create departments table
create table departments (
	dept_no VARCHAR(8) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(40) NOT NULL
);

-- -- Create dept_emp table
create table dept_emp (
	emp_no INT PRIMARY KEY NOT NULL,
	dept_no VARCHAR(8) NOT NULL,
    foreign key (emp_no) references employees (emp_no),
    foreign key (dept_no) references departments (dept_no)
);
-- -- Create salaries table
create table salaries (
	emp_no INT PRIMARY KEY NOT NULL,
	salary INT NOT NULL,
    foreign key (emp_no) references employees (emp_no)
);

-- -- Create dept_manager table
create table dept_manager (
	dept_no VARCHAR(8) NOT NULL,
	emp_no INT NOT NULL,
    foreign key (emp_no) references employees (emp_no),
    foreign key (dept_no) references departments (dept_no)
);



-- SELECT emp_no, last_name, first_name, sex FROM employees,
SELECT * FROM employees
INNER JOIN salaries 
ON salaries.emp_no = employees.emp_no

-- List the first name, last name, and hire date for the employees who were hired in 1986
SELECT emp_no, last_name, first_name, hire_date 
FROM employees 
WHERE EXTRACT (year from hire_date) = 1986;

-- List the manager of each department along with their department number, 
-- department name, employee number, last name, and first name.
SELECT DISTINCT ON (dept_manager.dept_no) dept_manager.dept_no, departments.dept_name, dept_manager.emp_no,
employees.last_name, employees.first_name
FROM dept_manager 
INNER JOIN departments 
ON dept_manager.dept_no= departments.dept_no
INNER JOIN employees 
ON dept_manager.emp_no = employees.emp_no
ORDER BY dept_manager.dept_no, employees.hire_date DESC;

-- List first name, last name, and sex of each employee whose first name 
-- -- is Hercules and whose last name begins with the letter B.
SELECT last_name, first_name, sex FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

-- List each employee in the Sales department, including their employee number, last name, and first name.
Select 
last_name, 
first_name,
employees.emp_no
FROM employees 
INNER JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
WHERE dept_no = 'd007';

-- List each employee in the Sales and Development departments, including their employee number, 
-- last name, first name, and department name.
Select 
last_name, 
first_name,
departments.dept_name,
employees.emp_no
FROM employees 
INNER JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments 
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_no = 'd007' OR departments.dept_no = 'd005';


-- List the frequency counts, in descending order, of all the employee last names
-- (that is, how many employees share each last name).
select last_name,count(last_name) as Frequency 
from employees 
group by last_name
order by frequency desc;