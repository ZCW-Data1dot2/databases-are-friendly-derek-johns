/* SQL "Sakila" database query exercises - phase 1 */

-- Database context
USE sakila;

-- Your solutions...
-- i
SELECT *
FROM actor
WHERE first_name = 'Scarlett';

-- ii
SELECT *
FROM actor
WHERE last_name = 'Johansson';

-- iii
SELECT COUNT(DISTINCT(last_name))
FROM actor

-- iv
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1

-- v
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) > 1

-- vi
SELECT f.actor_id, a.first_name, a.last_name, COUNT(f.actor_id) 'film_count'
FROM film_actor f
JOIN actor a
ON f.actor_id = a.actor_id
GROUP BY f.actor_id
HAVING COUNT(f.actor_id) = (
	SELECT MAX(film_count)
    FROM (
		SELECT actor_id, COUNT(*) film_count
        FROM film_actor
        GROUP BY actor_id) max_film_count);

-- vii
SELECT i.film_id, f.title, i.store_id, i.inventory_id
FROM inventory i
JOIN film f
ON i.film_id = f.film_id
WHERE i.film_id = (
	SELECT film_id
	FROM film
	WHERE title = 'Academy Dinosaur'
    AND store_id = 1);

-- viii
select customer_id
from customer
where first_name = 'Mary' and last_name = 'Smith';
-- 1

select staff_id
from staff
where first_name = 'Mike' and last_name = 'Hillyer';
-- 1

insert into rental (rental_date, inventory_id, customer_id, staff_id)
values (NOW(), 1, 1, 1);

-- ix
select rental_date,
	date_add(rental_date, interval (select rental_duration from film where title = 'Academy Dinosaur') day) due_date
from rental
where rental_id = (select rental_id from rental order by rental_id desc limit 1);

-- x
select avg(length) from film;

-- xi
select c.name category_name, avg(f.length) avg_length
from film f
join film_category fc
on f.film_id = fc.film_id
join category c
on fc.category_id = c.category_id
group by c.name;

-- xii
-- Returns empty set because film table and inventory table have 2 matching columns,
-- 'film_id' and 'last_update'. This causes unexpected results with natural join. Better
-- solution is to use inner join.
-- inner join solution:
select *
from film f
join inventory i
on f.film_id = i.film_id;

