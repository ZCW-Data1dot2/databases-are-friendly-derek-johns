/* SQL "Sakila" database query exercises - phase 1 */

-- Database context
USE sakila;

-- Your solutions...

-- 1a
select first_name, last_name from actor;

-- 1b
select concat(first_name, ' ', last_name) 'Actor Name' from actor;

-- 2a
select * from actor where first_name = 'Joe';

-- 2b
select * from actor where last_name like '%GEN%';

-- 2c
select * from actor where last_name like '%LI%'
order by last_name, first_name;

-- 2d
select country_id, country from country
where country in ('Afghanistan', 'Bangladesh', 'China');

-- 3a
alter table actor
add column middle_name varchar(45) after first_name;

-- 3b
alter table actor
modify column middle_name blob;

-- 3c
alter table actor
drop column middle_name;

-- 4a
select last_name, count(last_name) name_count from actor
group by last_name;

-- 4b
select last_name, count(last_name) name_count from actor
group by last_name
having count(last_name) >= 2;

-- 4c
update actor
set first_name = 'HARPO'
where first_name = 'GROUCHO' and last_name = 'WILLIAMS';

-- 4d
update actor
set first_name = case
when first_name = 'HARPO' then 'GROUCHO'
when first_name = 'GROUCHO' then 'MUCHO GROUCHO'
else first_name
end;

-- 5a
show create table address;

-- 6a
select s.first_name, s.last_name, a.address
from staff s
join address a
on s.address_id = a.address_id;

-- 6b
select s.staff_id, sum(p.amount) total_sales
from staff s
join payment p
on s.staff_id = p.staff_id
where monthname(p.payment_date) = 'August'
and year(p.payment_date) = 2005
group by s.staff_id;

-- 6c
select f.title, count(fa.actor_id) actor_count
from film_actor fa
inner join film f
on fa.film_id = f.film_id
group by f.title;

-- 6d
select count(*)
from inventory i
join film f
on i.film_id = f.film_id
where f.title = 'Hunchback Impossible';

-- 6e
select c.customer_id, c.first_name, c.last_name, sum(p.amount) total_payments
from customer c
join payment p
on c.customer_id = p.customer_id
group by c.customer_id
order by c.last_name, first_name;

-- 7a
select title, language_id from film
where title like 'K%' or title like 'Q%'
and language_id = (select language_id from language where name = 'English');

-- 7b
select a.first_name, a.last_name
from film_actor fa
join actor a
on fa.actor_id = a.actor_id
where film_id = (select film_id from film where title = 'Alone Trip');

-- 7c
select c.first_name, c.last_name, c.email, co.country
from customer c
join address a
on c.address_id = a.address_id
join city ci
on a.city_id = ci.city_id
join country co
on ci.country_id = co.country_id
where co.country = 'Canada';

-- 7d
select f.title, c.name
from category c
join film_category fc
on c.category_id = fc.category_id
join film f
on fc.film_id = f.film_id
where c.name = 'Family';

-- 7e
select f.title, count(*) rent_count
from rental r
join inventory i
on r.inventory_id = i.inventory_id
join film f
on i.film_id = f.film_id
group by r.inventory_id
order by rent_count desc;

-- 7f
select s.store_id, sum(p.amount) store_total
from payment p
join staff s
on p.staff_id = s.staff_id
group by s.store_id;

-- 7g
select s.store_id, c.city, co.country
from store s
join address a
on s.address_id = a.address_id
join city c
on a.city_id = c.city_id
join country co
on c.country_id = co.country_id;

-- 7h
select c.name, sum(p.amount) genre_total
from category c
join film_category fc
on c.category_id = fc.category_id
join inventory i
on fc.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
join payment p
on r.rental_id = p.rental_id
group by c.name
order by genre_total desc limit 5 ;

-- 8a
create view V_Top5Genres as
select c.name, sum(p.amount) genre_total
from category c
join film_category fc
on c.category_id = fc.category_id
join inventory i
on fc.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
join payment p
on r.rental_id = p.rental_id
group by c.name
order by genre_total desc limit 5;

-- 8b
select * from v_top5genres;

-- 8c
drop view v_top5genres;
