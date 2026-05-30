create database product_db;
use product_db;
select * from customers;
select	* from categories;
#select statement
#Sabhi customers ka data display karo.
SELECT * FROM customers;

#Sirf product_name aur price display karo.
select product_name,cost_price from products;

#₹500 se jyada price wale products show karo.
select * from products where cost_price > 500;

#Ahmedabad city ke customers show karo.
select * from customers where city = "Ahmedabad";

#Employees ko salary ke descending order me show karo.
select * from employees order by salary desc;

#Display unique states from customers table.
select distinct state from customers;

#rename column(table operation)
#Rename the column phone from customers table to mobile_number.
alter table customers rename column phone to mobile_number;
desc customers;

#delete
#Delete the reviews table permanently.
drop table reviews;

#Show all tables available inside product_db.
show tables from product_db;
#Q4. Show top 5 expensive products. 
select product_name,cost_price from products order by cost_price desc limit 5;
#Q5. Show customers whose first name starts with 'A'.
select * from customers where first_name like 'A%';

#insert query
#Q1. Add new customer.
insert into customers(first_name, last_name, email, mobile_number, city, state) values ('Rahul', 'Sharma', 'rahul@gmail.com', '9876543210', 'Surat', 'Gujarat');
#Q2. Add new category.
insert into categories(category_id,category_name) values (26,'Electronics Devices');

SET SQL_SAFE_UPDATES = 0;
#3. UPDATE Queries (Updating Data)
#Q1. Increase product price by 10%.
UPDATE products
SET cost_price = cost_price * 1.10;

#Q2. Update customer city.
update customers 
set city = 'Ahemdabad'
where customer_id = 2;
select * from orders;
#Q3. Change order status to Delivered.
update orders 
set order_status = "Delivered"
where order_id =1;
select * from payments;
#Q4. Update payment status.
update payments 
set payment_status = "paid"
where payment_id = 2;

select * from inventory;	
#Q5. Add stock quantity.
update inventory 
set stock_quantity = stock_quantity + 20
where inventory_id = 1;

#4. DELETE Queries (Removing Data)
select * from orders;
#Q1. Delete cancelled orders.
delete from orders where order_status = "Cancelled";

#Q2. Delete products with zero stock.
delete from inventory where stock_quantity = 0;

5. Aggregate Functions (SUM, AVG, COUNT, MAX, MIN)
#Q1. Find total number of customers.
select count(*) as tot_cust from customers;

#Q2. Find average product price.
select avg(cost_price) as avg_price from products;

#Q3. Find total sales amount.
select sum(selling_price)as tot_sales from products;

#Q4. Find highest product price.
select max(selling_price) as highest_price from products;

#Q5. Find minimum stock quantity.
select min(stock_quantity) as min_stock from inventory;

#6. GROUP BY Queries
#Q1. Count customers city-wise.
select city, count(*)as tot_cust from customers group by city;

#Q2. Find total sales by payment method.
select payment_method,sum(amount) as tot_sales from payments group by payment_method;

#Q3. Count products category-wise.
select category_id,count(*)as tot_category from products group by category_id;

#Q4. Find total orders by status.
select order_status,sum(order_id) as tot_order from orders group by order_status;

#Q5. Find customers who placed more than 2 orders.
select customer_id,count(order_id)as tot_order from orders group by customer_id 
having count(order_id) > 0;

#Join Concept
#1. INNER JOIN Questions
#Q1. Show customer names with their orders.
select c.first_name,c.last_name,o.order_id,o.order_date from customers c join orders o on c.customer_id = o.customer_id;

#Q2. Show product names with category names.
select p.product_id,p.product_name,c.category_name from products p join categories c on p.category_id = c.category_id;

#Q3. Show payments with customer names.
SELECT p.payment_method,
       p.amount,
       c.first_name
FROM payments p
JOIN orders o
ON p.order_id = o.order_id
JOIN customers c
ON o.customer_id = c.customer_id;

#Q4. Show products with supplier names.
select p.product_name,s.supplier_id,s.supplier_name from products p join suppliers s on p.supplier_id = s.supplier_id;

#Q5. Show ordered products with quantity.
select o1.order_id,o1.order_status,o2.quantity from orders o1 join order_details o2 on o1.order_id = o2.order_id;

#2. LEFT JOIN Questions
#Q1. Show all customers and their orders.
select c.customer_id,c.first_name,o.order_id,o.order_status from customers c left join orders o on c.customer_id = o.customer_id;

#Q2. Show all suppliers with products.
select s.supplier_id,s.supplier_name,p.product_id,p.product_name from suppliers s left join products p on s.supplier_id = p.supplier_id;

#Q3. Show all orders with payment details.
select o.order_id,o.order_status,p.amount from orders o left join payments p on o.order_id = p.order_id;

#Q4. Show all categories with products.
select c.category_name,p.product_id,p.product_name from categories c left join products p on c.category_id = p.category_id;

#3. RIGHT JOIN Questions
#Q1. Show all orders with customer names.
select c.first_name,o.order_id from customers c right join orders o on c.customer_id = o.customer_id;
#Q2. Show all payments with order details.
select o.order_id,p.amount from orders o right join payments p on o.order_id = p.order_id;
#Q3. Show all products with category names.
select c.category_name,p.product_name from categories c right join products p on c.category_id = p.category_id;
#Q4. Show all inventory records with product names.
select p.product_name,i.stock_quantity from products p right join inventory i on p.product_id = i.product_id;


#4. FULL JOIN Questions
#Q1. Show all customers and all orders.
select c.first_name,o.order_id
from customers c left join orders o 
on c.customer_id = o.customer_id

union
select c.first_name,o.order_id
from customers c right join orders o 
on c.customer_id = o.customer_id;

#Q3. Show all suppliers and products.
select s.supplier_name,p.product_name 
from suppliers s left join products p 
on s.supplier_id = p.supplier_id

union
select s.supplier_name,p.product_name 
from suppliers s right join products p 
on s.supplier_id = p.supplier_id;

#5. SELF JOIN Questions
#Q1. Show employees working in same department.
select e1.first_name as employee1,e2.first_name as employee2,e1.designation from employees e1 join employees e2
on e1.designation = e2.designation
and e1.employee_id != e2.employee_id;
#Q2. Show customers from same city.
select c1.first_name,c2.first_name,c1.city from customers c1 join customers c2
on c1.city = c2.city
and c1.customer_id != c2.customer_id;

#Q3. Show products having same price.
select p1.product_name,p2.product_name,p1.cost_price from products p1 join products p2
on p1.cost_price = p2.cost_price
and p1.product_id = p2.product_id; 

#Q4. Show employees with same salary.
select e1.first_name,e2.first_name,e1.salary from employees e1 join employees e2
on e1.salary  = e2.salary 
and e1.employee_id != e2.employee_id;

#Q5. Show suppliers from same city.
select s1.supplier_name,s2.supplier_name,s1.city from suppliers s1 join suppliers s2
on s1.city = s2.city
and s1.supplier_id != s2.supplier_id;

#SQL Operators and Clauses
#1. WHERE Clause
#Q1. Find customers from Gujarat whose city is not Surat.
select first_name,city,state from customers 
where state = "Gujarat"
and city != "Surat";

#Q2. Find products with price between 500 and 5000 and stock more than 10.
select p.product_name,p.selling_price,i.stock_quantity from products p join inventory i 
on p.product_id = i.product_id
where p.selling_price between 500 and 5000
and i.stock_quantity > 10;

#2. HAVING Clause
#Q1. Find customers who placed more than 0 orders.
select customer_id,count(order_id) as total_order from orders group by customer_id having count(order_id) > 0;

#Q2. Find categories having average product price above 2000.
select category_id,avg(selling_price) as avg_price from 
products group by category_id
 having avg(selling_price) > 2000;
 
 desc customers;
 select * from customers;
#3. IN Operator
#Q1. Find customers living in Ahmedabad, Surat, or Mumbai.
select customer_id,city,state from customers where city in ("Ahemdabad","Surat","Mumbai");
#Q2. Find products belonging to category 1, 2, or 5.
select product_name,category_id from products where category_id in (1,2,5);
#4. NOT IN Operator
#Q1. Find customers not from Gujarat or Maharashtra.
select first_name,state from customers c where state not in ("Ahemdabad", "Maharashtra");
#Q2. Find products not ordered yet.
select product_name from products where product_id not in (SELECT product_id
    FROM order_details);
    
#5. BETWEEN Operator
#Q1. Find payments between ₹1000 and ₹5000.
select payment_id,amount from payments where amount between 1000 and 5000;
select * from orders;
#Q2. Find orders placed between two dates.
select order_id,order_date from orders where order_date between '2026-01-01' AND '2026-05-02';

#•	6. LIKE Operator
#Q1. Find customers whose email ends with gmail.com.
select first_name,email from customers where email like '%gmail.com';
#Q2. Find products starting with 'S'.
select product_name from products where product_name like 'S%';

#•	7. ORDER BY Clause
#Q1. Show products from highest to lowest price.
select product_id,selling_price from products order by selling_price desc;
#Q2. Show customers alphabetically by first name.
select  first_name from customers order by first_name asc;
#8. LIMIT Clause
#Q1. Show top 3 highest payments.
select payment_id,amount from payments order by amount limit 3;
#•	Q2. Show latest 5 orders.
select order_id,order_date from orders  order by order_date desc limit 5;

#9. EXISTS Operator
#Q1. Find customers who placed at least one order.
SELECT first_name
FROM customers c
WHERE EXISTS (
    SELECT *
    FROM orders o
    WHERE c.customer_id = o.customer_id);
    
#•	10. ANY Operator
#Q1. Find products costlier than any product in category 2.
SELECT product_name, selling_price
FROM products
WHERE selling_price > ANY (
    SELECT selling_price
    FROM products
    WHERE category_id = 2
);

#Q2. Find payments greater than any pending payment.
select payment_id,amount from payments where amount > any(SELECT amount
    FROM payments
    WHERE payment_status = 'Pending'
);

#11. ALL Operator
#Q1. Find products costlier than all products in category 1.
SELECT product_name,selling_price
FROM products
WHERE selling_price > ALL (
    SELECT selling_price
    FROM products
    WHERE category_id = 4
);
#•	Q2. Find employees earning more than all managers
SELECT first_name, salary
FROM employees
WHERE salary > ALL (
    SELECT salary
    FROM employees
    WHERE designation = 'Manager'
);
#1. Basic Subquery Questions
#Q1. Find products costlier than average product price.
SELECT product_name, selling_price
FROM products
WHERE selling_price > (
    SELECT AVG(selling_price)
    FROM products
);
#Q2. Find customers who placed orders.
select first_name,customer_id
from customers
where customer_id in (
    select customer_id
    from orders
);

#2. Intermediate Subquery Questions
#Q3. Find products that were never ordered.
select product_name
from  products
where product_id not in (
    select product_id
    from order_details
);
#Q4. Find customers who spent more than average payment amount.
select c.first_name, p.amount
from customers c
join orders o
on c.customer_id = o.customer_id
join payments p
on o.order_id = p.order_id
where p.amount > (
    select avg(amount)
    from payments
);

#3. Advanced Subquery Questions
#Q5. Find highest selling product.
select product_name
from products
where product_id = (
    select product_id
    from order_details
    group by product_id
    order by SUM(quantity) desc
    limit 1
);

#Q6. Find customers who placed maximum orders.
select first_name
from customers
where customer_id in (
    select customer_id
    from orders
    group by customer_id
    having count(order_id) = (
        select max(total_orders)
        from (
            select count(order_id) as total_orders
            from orders
            group by customer_id
        ) as order_count
    )
);
#Q7. Find products whose price is higher than all products in category 2.
select product_name, selling_price
from products
where selling_price > ALL (
    select selling_price
    from products
    where category_id = 2
);
#Q8. Find suppliers supplying more than 5 products.
select supplier_name
from suppliers
where supplier_id in (
    select supplier_id
    from products
    group by supplier_id
    having count(product_id) > 5
);

#4. Correlated Subquery Questions
#Q9. Find products priced above category average.
select product_name, selling_price, category_id
from products p1
where selling_price > (
    select avg(selling_price)
    FROM products p2
    WHERE p1.category_id = p2.category_id
);
#Q11. Find employees earning more than the average salary of their department.
select first_name, salary, designation
from employees e1
where salary > (
    select avg(salary)
    from employees e2
    where e1.designation = e2.designation
);

#null operator:-
#1. Find customers whose email is NULL.
select * from customers where email is null;

#2. Find customers whose phone number is missing
select first_name,last_name from customers where mobile_number is null;

#3. Find customers whose city is NULL
select * from customers where city is null;

#4. Find customers whose state is NULL
select customer_id, first_name
from customers
where state is null;

#5. Find customers whose join_date is NULL
select * from customers where registration_date is null;

#advance
#6. Find customers where both email and phone are NULL
select *
from customers
where email is  null
and mobile_number is null;

#7. Find customers where either city or state is NULL
select * from customers where city is null or state is null;

#8. Count how many customers have NULL email
select count(*) as total_null_emails from customers
where email is null;

#COALESCE / IFNULL Questions
#11. Show city name, if NULL then show 'No City'
select first_name,coalesce(city,"no city") as city_name from customers;

#12. Show phone number, if NULL then show 'Not Available'
select first_name,ifnull(mobile_number,"not available") as mobile_number from customers;

set sql_safe_updates = 0;
#UPDATE with NULL
#13. Update NULL state to Gujarat
update customers 
set state = "Gujarat"
where state is null;

#15. Find customers whose email exists but phone is NULL
select * from customers where email is not null and mobile_number is null;

#16. Find customers having more missing details
select * from customers where email is null or mobile_number is null or city is null or state is null;

#18. Count NULL values state-wise
select state,count(*)as tot_cust from customers where mobile_number is null group by state;

#String Function
#Q1. Show all product names in uppercase
select upper(product_name)as product from products;
#Q2. Show employee first names in lowercase
select lower(first_name)as employee from employees;
#Q3. Combine employee first and last name
select concat(first_name,' ',last_name)as full_name from employees;
#Q4. Find length of product names
select length(product_name) as length from products;
#Q5. Extract first 4 letters from product names
select product_name,substr(product_name,1,4)as short_name from products;

#2. NUMERIC FUNCTIONS
#Q6. Round selling price
select product_name,round(selling_price,2)as rounded_price from products;
#Q7. Find highest selling price
select max(selling_price) as max_selling_price from products;
#Q8. Find minimum salary from employees
select min(salary)as min_sal from employees;
#Q9. Find average product selling price
select avg(selling_price)as avg_selling_price from products;

#3. DATE FUNCTIONS
#Q11. Show current date
select curdate();
#Q12. Extract year from order date
select order_id,year(order_date)as order_year from orders;
#Q14. Find orders placed in January
select * from orders where month(order_date) = 1;
#Q15. Find difference between today and order date
select order_id,datediff(curdate(),order_date)as day_diff from orders;

#CASE
#Q1. Show employee salary category
select first_name,salary,
case
	when salary > 70000 then 'High Salary'
		else'Normal Salary'
       end as  salary_status
from employees;
#Q2. Show expensive and cheap products
select product_name,selling_price,
       case
           when selling_price > 50000 then 'Expensive'
           else 'Affordable'
       end as product_type
from products;
#Q3. Show stock status
select product_id,stock_quantity,
	case
		when stock_quantity = 0 then 'Out of Stock'
		else 'Available'
       end as stock_status
from inventory;

#Q5. Multiple salary categories
select first_name,salary,
case
	when salary > 80000 then 'High'
		when salary > 50000 then 'Medium'
		else 'Low'
       end as salary_grade
from employees;
#Q6. Product price grading
select product_name,selling_price,
case
	when selling_price >= 70000 then 'Premium'
		when selling_price >= 30000 then 'Standard'
		else'Budget'
       end as product_grade
from products;
#Q7. Inventory alert system
select product_id,stock_quantity,
case
	when stock_quantity = 0 then 'Out of Stock'
           when stock_quantity < 10 then 'Low Stock'
           else 'Sufficient Stock'
       end as stock_alert
from inventory;
#Q8. Employee bonus eligibility
select first_name,salary,
case 
	when salary > 60000 then salary * 0.10
		else salary * 0.05
       end as bonus
from employees;
#.Generate employee performance grade
SELECT first_name,salary,designation,
case
	when designation = 'Manager'
		and salary > 90000 then 'A Grade'
           when salary > 70000 then 'B Grade'
           when salary > 40000 then 'C Grade'
           else 'D Grade'
       end as performance_grade
from employees;

#STORED PROCEDURE
#Create a stored procedure to get all employees.
delimiter //
create procedure get_allemp()
begin
	select * from employees;
end //
delimiter ;

call get_allemp();

#Create a procedure to get employees by designation.
delimiter //

create procedure GetEmployeesByDesignation(in emp_designation VARCHAR(50))
begin
    select employee_id, first_name, last_name, salary
    from employees
    where designation = emp_designation;
end //

delimiter ;

call GetEmployeesByDesignation('Manager');

#Create a procedure to give bonus (10%) to employees whose salary > 50000.
delimiter //
create procedure givebonus()
begin
    update employees
    set salary = salary + (salary * 0.10)
    where salary > 50000;
end //
delimiter ;

call givebonus();

# WINDOW FUNCTIONS
#Show employees with average salary of company.
select employee_id,first_name,salary,
    avg(salary) over() as avg_salary
from employees;

#Rank employees based on salary (highest first).
select  employee_id,first_name,salary,
    rank() over(order by salary desc) as salary_rank
from employees;

#Find cumulative salary of employees (running total).
select employee_id,first_name,salary,
    sum(salary) over(order by employee_id) as running_total
from employees;

#Find rank of employees within each branch.
select employee_id,first_name,branch_id,salary,
    rank() over(partition by branch_id order by salary desc) as branch_rank
from employees;

#Triggers
#Create a trigger that stores employee details in employee_log whenever a new employee is added.
create table employee_log (
    log_id int auto_increment primary key,
    employee_id int,
    action_type varchar(50),
    created_at timestamp default current_timestamp
);
delimiter //
create trigger after_employee_insert
after insert on employees
for each row
begin
    insert into employee_log(employee_id, action_type)
    values (new.employee_id, 'NEW EMPLOYEE ADDED');
end //
delimiter ;
#Do not allow products with negative selling_price.
delimiter //

create trigger before_product_insert
before insert on products
for each row
begin
    if new.selling_price >0 then
        signal sqlstate '45000'
        set message_text = 'Price cannot be negative';
    end if;
end //

delimiter ;
INSERT INTO employees
(first_name, last_name, designation, salary, branch_id, manager_id)
VALUES
('Amit', 'Patel', 'Manager', 80000, 1, NULL);
INSERT INTO employees
(first_name, last_name, designation, salary, branch_id, manager_id)
VALUES
('Rahul', 'Sharma', 'Developer', 45000, 1, 1);
select * from employees;

#Q3. Auto Update Product Stock.
delimiter //

create trigger after_orderdetails_insert
after insert on order_details
for each row
begin
    update inventory
    set stock_quantity = stock_quantity - new.quantity
    where product_id = new.product_id;
end //

delimiter ;

#CTE question
#Q1. Display employees with salary greater than 50000 using CTE.
WITH high_salary_employees AS (
    SELECT employee_id, first_name, salary
    FROM employees
    WHERE salary > 50000
)
SELECT *
FROM high_salary_employees;

#Q2. Find expensive products using CTE.
with expensive_products as (
    select product_name, selling_price
    from products
    where selling_price > 20000
)

select *
from expensive_products;

#Find customers from a specific city using CTE.
with specific_city as (
select customer_id,first_name,city
from customers where city = "Ahemdabad"
)
select * from specific_city;

#Q4. Find average salary and employees earning above average.
with avg_salary_cte as (
    select avg(salary) as avg_salary
    from employees
)

select employee_id, first_name, salary
from employees
where salary > (
    select avg_salary
    from avg_salary_cte
);

#Find total payment made by each customer.
with customer_payments as (
    select o.customer_id,
           sum(p.amount) as total_payment
    from payments p
    join orders o
    on p.order_id = o.order_id
    GROUP BY o.customer_id
)

select *
from customer_payments;

#Find duplicate product names using CTE.
with duplicate_products as (
    select product_name,
           count(*) as total_count
    from products
    group by product_name
    having count(*) > 1
)

select *
from duplicate_products;

#Find branch-wise highest salary employee.
with branch_salary as (
    select employee_id,first_name,branch_id,salary,
           rank() over(
			partition by branch_id
               order by salary desc
           ) as rank_no
    from employees
)

select * from branch_salary where rank_no = 1;

#Recursive CTE to print numbers 1 to 10.
with recursive numbers as (
    select 1 as num
    union all
    select num + 1
    from numbers
    where num < 10
)

select * from  numbers;

#Find running total of payments using CTE.
with payment_running_total as (
    select p.payment_id,o.customer_id,p.amount,
           sum(amount) over(order by payment_id) as running_total
    from payments p join orders o 
    on p.order_id = p.order_id
)

select * from payment_running_total;

#TCL Command
select * from products;
START TRANSACTION;

UPDATE products
SET selling_price = selling_price + 2000
WHERE product_id = 2;

COMMIT;
select * from products where product_id = 2;

#ROLLBACK
start transaction;

update products
set selling_price = 90000
where product_id = 2;

rollback;

#savepoint
start transaction;

update employees
set salary = salary + 2000 where employee_id = 1;
savepoint emp_update;

update employees
set salary = salary + 5000 where employee_id = 2;
rollback to emp_update;
commit;
select * from employees;
SELECT employee_id, first_name, salary
FROM employees
WHERE employee_id IN (1,2);