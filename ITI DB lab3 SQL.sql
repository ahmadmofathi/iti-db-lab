/*Display the Department id, name and id and the name of its manager. */
select Dnum,Dname,MGRSSN, Fname+' '+Lname as [Manager Name]
from Departments
join Employee
on MGRSSN=SSN

/*Display the name of the departments and the name of the projects under its control.*/
select Dname, Pname
from Departments
join Project 
on [Departments].Dnum= [Project].Dnum

/*Display the full data about all the dependence associated with the name of the employee they depend on him/her. */
select Dependent_name, [Dependent].Sex, [Dependent].Bdate, Fname+' '+Lname as [Employee Name]
from Dependent
join Employee
on ESSN =SSN

/* Display (Using Union Function)*/
select Dependent_name,[Dependent].Sex
from Dependent
join Employee
on ESSN = SSN
where [Dependent].Sex = 'F' AND [Employee].Sex = 'F'
union
select Dependent_name,[Dependent].Sex
from Dependent
join Employee
on ESSN = SSN
where [Dependent].Sex = 'M' AND [Employee].Sex = 'M'


/* Display the Id, name and location of the projects in Cairo or Alex city*/
select Pnumber, Pname, Plocation
from Project
where city in ('Alex','Cairo')

/* Display the Projects full data of the projects with a name starts with "a" letter.*/
select *
from Project
where Pname like 'a%'

/*display all the employees in department 30 whose salary from 1000 to 2000 LE monthly */
select *
from Employee
where Dno = 30 and Salary between 1000 and 2000

/*Retrieve the names of all employees in department 10 
who works more than or equal 10 hours per week on "AL Rabwah" project. */
select Fname+' '+Lname as [Employee Name]
from Employee
join Works_for 
on ESSn = SSN
join Project
on Pno=Pnumber
where Dno = 10 and Pname='Al Rabwah' and Hours>=10 


/*Find the names of the employees who directly supervised with Kamel Mohamed. */
select Fname+' '+Lname as [Employee Name]
from Employee
where Superssn in 
(select  SSN
from Employee
where Fname ='Kamel' and lname= 'Mohamed')


/*For each project, list the project name and the total hours per week (for all employees) spent on that project. */
select Pname,sum(Hours)
from Project
join Works_for
on Pnumber = Pno
group by Pname

/* Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name. */
select Fname+' '+Lname as [Employee Name],Pname
from Employee
join Project
on Dno = Dnum
join Departments
on Dno = [Departments].Dnum
order by Pname

/* Display the data of the department which has the smallest employee ID over all employees' ID. */
select * 
from Departments
where Dnum = (
select Dno
from Employee
where SSN in
(select min(SSN) from Employee)
)
/*For each department, retrieve the department name and the maximum, minimum and average salary of its employees. */
select Dname,min(salary) as [Min Salary],max(salary) as [Max Salary],avg(salary) as [Average]
from Employee
join Departments
on Dno=Dnum
group by Dname


/* List the last name of all managers who have no dependents. */
select Lname
from Employee
join Departments
on MGRSSN=SSN
where MGRSSN not in
(select Essn
from Dependent)


/*For each department-- if its average salary is less than the average salary of all employees--
display its number, name and number of its employees. */
select Dnum, Dname,count(ssn) as [No. of Employees], avg(salary) as Average
from Employee
join Departments
on Dno=Dnum
group by Dname, Dnum
having avg(salary)<(
select avg(salary)
from Employee)


/* Retrieve a list of employees and the projects they are working on ordered by 
department and within each department, ordered alphabetically by last name, first 
name. */
select Fname,Lname, Pname
from Employee
join Departments
on Dno = [Departments].Dnum
join Project
on Dno = [Project].Dnum
order by Dname, Lname, Fname


/*For each project located in Cairo City , find the project number, the controlling 
department name ,the department manager last name ,address and birthdate.*/
select Pnumber, Lname, Address, Bdate
from Project
join Departments
on [Project].Dnum = [Departments].Dnum
join Employee
on SSN = MGRSSN
where City = 'Cairo'
