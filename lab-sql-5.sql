use sakila;

#1. Drop column picture from staff.

alter table staff
	drop column picture;
    
#2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. 
#   Update the database accordingly.

select * from customer
where first_name like 'Tammy'
and last_name like 'Sanders'; #find address_id of Tammy

insert into staff(first_name,last_name,address_id,store_id,active,username) values ('Tammy','Sanders',79,2,1,'Tammy');
select * from staff;

#3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1.

select * from film
where title like 'Academy Dinosaur';

insert into rental(rental_date,inventory_id,customer_id,staff_id) 
values (curdate(), (select max(inventory_id) from sakila.inventory where film_id = 1 and store_id = 1),
(select customer_id from sakila.customer where first_name = 'CHARLOTTE' and last_name = 'HUNTER'),
(select staff_id from sakila.staff where store_id = 1 and first_name like 'Mike'));

select * from rental
order by rental_id desc
limit 1;

#4. Delete non-active users, but first, create a backup table deleted_users to store customer_id, 
#   email, and the date for the users that would be deleted.

-- Check if there are any non-active users
select count(*) from customer
where active = 0;

-- Create a table backup table by inserting all users in the customer table
create table deleted_users 
as select customer_id, email, create_date, active 
from customer;

-- Remove the active users in the table backup table
delete from deleted_users where active = 1;

-- Delete the non active users from the table customer
ALTER TABLE `sakila`.`payment` 
DROP FOREIGN KEY `fk_payment_customer`;

ALTER TABLE `sakila`.`rental` 
DROP FOREIGN KEY `fk_rental_customer`;

delete from customer where active = 0;