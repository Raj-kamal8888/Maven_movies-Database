USE mavenmovies; -- Making the database as Default Schema

/*
Assignment: 1
Pull the list of first_name, last_name and email of each of our customers
*/ 

-- Solution: 1
SELECT
	first_name,
    last_name,
    email
FROM customer;

/*
Assignment: 2
Pull the record of the films and see if there are rental duations other then: 3,5 or 7 days
*/ 

-- Solution: 2
SELECT DISTINCT 
	rental_duration
FROM film;

/*
Assignment: 3
Pull the list of all payments from our first 100 customers
*/ 

-- Solution: 3
SELECT
	customer_id,
    rental_id,
    amount,
    payment_date
FROM payment
WHERE customer_id BETWEEN 1 AND 100;

/*
Assignment: 4
Pull the list of payments over $5 for those same customers, since Jan-1-2006
*/ 

-- Solution: 4
SELECT
	customer_id,
    rental_id,
    amount,
    payment_date
FROM payment
WHERE customer_id < 101
	AND amount > 5
	AND payment_date > '2006-01-01';
    
/*
Assignment: 5
Pull payments from those specific customers along with payments above $5 from any customer
*/ 

-- Solution: 5
SELECT
	customer_id,
    rental_id,
    amount,
    payment_date
FROM payment
WHERE amount > 5
	OR customer_id IN (42,53,60,75);
    
/*
Assignment: 6
To understand the special feature in the film record, pull the list of all the films
which include 'Behind the Scenes' as special features
*/ 

-- Solution: 6
SELECT
	title,
    special_features
FROM film
WHERE special_features LIKE '%Behind the Scenes%';

/*
Assignment: 7
Count of all film titles sliced by rental duration
*/ 

-- Solution: 7
SELECT
	rental_duration,
    COUNT( DISTINCT title) AS title_count
FROM film
GROUP BY rental_duration
ORDER BY 2 DESC;

SELECT
	rental_duration,
    COUNT(film_id) AS total_films_with_rental_duration
FROM film
GROUP BY rental_duration
ORDER BY 2 DESC;

/*
Assignment: 8
Pull count of films, along with avg, min and max of rental rate grouped by replacement cost
*/ 

-- Solution: 8
SELECT
	replacement_cost,
	COUNT(film_id) as number_of_films,
    MIN(rental_rate) as chepaest_rental,
    MAX(rental_rate) as expensive_rental,
    AVG(rental_rate) as average_rental
FROM film
GROUP BY replacement_cost
ORDER BY 1 DESC;

/*
Assignment: 9
Pull the list of customer_id with less then 15 rentals all time
*/ 

-- Solution: 9
SELECT
	customer_id,
    COUNT(rental_id) as total_rental_all_time
FROM rental
GROUP BY customer_id
HAVING total_rental_all_time  < 15
ORDER BY total_rental_all_time DESC;

/*
Assignment: 10
Pull list of all film titles along with there length and rental rate and sort from longest to shortes
*/ 

-- Solution: 10
SELECT
	title,
    length,
    rental_rate
FROM film
ORDER BY length DESC;

/*
Assignment: 11
Find out the names of all customers along with there store they prefer and are they active on them or not
*/ 

-- Solution: 11
SELECT
	first_name,
    last_name,
    CASE
		WHEN store_id = 1 AND active = 1 Then 'store 1 active'
        WHEN store_id = 1 AND active = 0 Then 'store 1 inactive'
        WHEN store_id = 2 AND active = 1 Then 'store 2 active'
        WHEN store_id = 2 AND active = 0 Then 'store 2 inactive'
		ELSE 'check again!!'
	END AS 'store_&_status'
FROM customer;

/*
Assignment: 12
How many inactive customers we have at each store
*/ 

-- Solution: 12
SELECT 
    COUNT(CASE WHEN store_id = 1 AND active = 0 THEN customer_id ELSE NULL END) AS store_1_inactive_customers,
    COUNT(CASE WHEN store_id = 2 AND active = 0 THEN customer_id ELSE NULL END) AS store_2_inactive_customers
FROM customer;

/*
Assignment: 13
How many active and inactive customers we have at each store
*/ 

-- Solution: 13
SELECT
	store_id,
    COUNT(CASE WHEN active = 1 THEN customer_id ELSE NULL END) AS active_customers,
    COUNT(CASE WHEN active = 0 THEN customer_id ELSE NULL END) AS inactive_customers
FROM customer
GROUP BY store_id;
--14.	We will need a list of all staff members, including their first and last names, 
email addresses, and the store identification number where they work. 
*/ 

SELECT 
	first_name, 
    last_name, 
	email, 
    store_id
FROM staff;

/*
--15	We will need separate counts of inventory items held at each of your two stores. 
*/ 

SELECT 
	store_id, 
	COUNT(inventory_id) AS inventory_items
FROM inventory
GROUP BY 
	store_id;

/*
--16	We will need a count of active customers for each of your stores. Separately, please. 
*/

SELECT 
	store_id, 
    COUNT(customer_id) AS active_customers
FROM customer
WHERE active = 1
GROUP BY 
	store_id;

/*
--17.	In order to assess the liability of a data breach, we will need you to provide a count 
of all customer email addresses stored in the database. 
*/

SELECT 
	COUNT(email) AS emails
FROM customer;

/*
--18.	We are interested in how diverse your film offering is as a means of understanding how likely 
you are to keep customers engaged in the future. Please provide a count of unique film titles 
you have in inventory at each store and then provide a count of the unique categories of films you provide. 
*/

SELECT 
	store_id, 
    COUNT(DISTINCT film_id) AS unique_films
FROM inventory
GROUP BY 
	store_id; 
	
SELECT 
	COUNT(DISTINCT name) AS unique_categories
FROM category;

/*
--19.	We would like to understand the replacement cost of your films. 
Please provide the replacement cost for the film that is least expensive to replace, 
the most expensive to replace, and the average of all films you carry. ``	
*/

SELECT 
	MIN(replacement_cost) AS least_expensive, 
    MAX(replacement_cost) AS most_expensive, 
    AVG(replacement_cost) AS average_replacement_cost
FROM film;

/*
--20.	We are interested in having you put payment monitoring systems and maximum payment 
processing restrictions in place in order to minimize the future risk of fraud by your staff. 
Please provide the average payment you process, as well as the maximum payment you have processed.
*/

SELECT
	AVG(amount) AS average_payment, 
    MAX(amount) AS max_payment
FROM payment;

/*
--21.	We would like to better understand what your customer base looks like. 
Please provide a list of all customer identification values, with a count of rentals 
they have made all-time, with your highest volume customers at the top of the list.
*/

SELECT 
	customer_id, 
    COUNT(rental_id) AS number_of_rentals
FROM rental
GROUP BY 
	customer_id
ORDER BY 
	COUNT(rental_id) DESC;
    Assignment: 22
Pull list of film title, description, store id along with there inventory id
*/

-- Solution: 22
SELECT
	inventory.inventory_id,
    inventory.store_id,
	film.title,
    film.description
FROM film
INNER JOIN inventory
	ON film.film_id = inventory.inventory_id;
    
/*
Assignment: 23
How many actors for each film -  top 5 films from the list
*/

-- Solution: 23
SELECT
	film.title,
    COUNT(film_actor.actor_id) AS number_of_actors
FROM film
LEFT JOIN film_actor
	ON film.film_id = film_actor.film_id
GROUP BY 1
ORDER BY 2 DESC;

/*
Assignment: 24
List of all actors with each title they appear in 
*/

-- Solution: 24
SELECT
	actor.first_name,
    actor.last_name,
    film.title
FROM actor 
INNER JOIN film_actor
	ON actor.actor_id = film_actor.actor_id
INNER JOIN film
	ON film_actor.film_id = film.film_id
ORDER BY 1,2;

/*
Assignment: 25
Unique titels and description available at store 2 inventory 
*/

-- Solution: 25
SELECT DISTINCT 
	film.title,
    film.description
FROM film
INNER JOIN inventory
	ON film.film_id = inventory.film_id
    AND inventory.store_id = 2;
    
/*
Assignment: 26
first_name and last_name of all staff memebers and advisors with there type
*/

-- Solution: 26
SELECT
	'advisor' AS type,
	first_name,
    last_name
FROM advisor

UNION

SELECT
	'staff' AS type,
	first_name,
    last_name
FROM staff;
/* 
27. My partner and I want to come by each of the stores in person and meet the managers. 
Please send over the managers’ names at each store, with the full address 
of each property (street address, district, city, and country please).  
*/ 

SELECT 
	staff.first_name AS manager_first_name, 
    staff.last_name AS manager_last_name,
    address.address, 
    address.district, 
    city.city, 
    country.country

FROM store
	LEFT JOIN staff ON store.manager_staff_id = staff.staff_id
    LEFT JOIN address ON store.address_id = address.address_id
    LEFT JOIN city ON address.city_id = city.city_id
    LEFT JOIN country ON city.country_id = country.country_id
;
	
/*
28.	I would like to get a better understanding of all of the inventory that would come along with the business. 
Please pull together a list of each inventory item you have stocked, including the store_id number, 
the inventory_id, the name of the film, the film’s rating, its rental rate and replacement cost. 
*/

SELECT 
	inventory.store_id, 
    inventory.inventory_id, 
    film.title, 
    film.rating, 
    film.rental_rate, 
    film.replacement_cost
FROM inventory
	LEFT JOIN film
		ON inventory.film_id = film.film_id
;

/* 
29.	From the same list of films you just pulled, please roll that data up and provide a summary level overview 
of your inventory. We would like to know how many inventory items you have with each rating at each store. 
*/

SELECT 
	inventory.store_id, 
    film.rating, 
    COUNT(inventory_id) AS inventory_items
FROM inventory
	LEFT JOIN film
		ON inventory.film_id = film.film_id
GROUP BY 
	inventory.store_id,
    film.rating
;

/* 
30. Similarly, we want to understand how diversified the inventory is in terms of replacement cost. We want to 
see how big of a hit it would be if a certain category of film became unpopular at a certain store.
We would like to see the number of films, as well as the average replacement cost, and total replacement cost, 
sliced by store and film category. 
*/ 

SELECT 
	store_id, 
    category.name AS category, 
	COUNT(inventory.inventory_id) AS films, 
    AVG(film.replacement_cost) AS avg_replacement_cost, 
    SUM(film.replacement_cost) AS total_replacement_cost
    
FROM inventory
	LEFT JOIN film
		ON inventory.film_id = film.film_id
	LEFT JOIN film_category
		ON film.film_id = film_category.film_id
	LEFT JOIN category
		ON category.category_id = film_category.category_id

GROUP BY 
	store_id, 
    category.name
    
ORDER BY 
	SUM(film.replacement_cost) DESC
;

/*
31	We want to make sure you folks have a good handle on who your customers are. Please provide a list 
of all customer names, which store they go to, whether or not they are currently active, 
and their full addresses – street address, city, and country. 
*/

SELECT 
	customer.first_name, 
    customer.last_name, 
    customer.store_id,
    customer.active, 
    address.address, 
    city.city, 
    country.country

FROM customer
	LEFT JOIN address ON customer.address_id = address.address_id
    LEFT JOIN city ON address.city_id = city.city_id
    LEFT JOIN country ON city.country_id = country.country_id
;

/*
32	We would like to understand how much your customers are spending with you, and also to know 
who your most valuable customers are. Please pull together a list of customer names, their total 
lifetime rentals, and the sum of all payments you have collected from them. It would be great to 
see this ordered on total lifetime value, with the most valuable customers at the top of the list. 
*/

SELECT 
	customer.first_name, 
    customer.last_name, 
    COUNT(rental.rental_id) AS total_rentals, 
    SUM(payment.amount) AS total_payment_amount

FROM customer
	LEFT JOIN rental ON customer.customer_id = rental.customer_id
    LEFT JOIN payment ON rental.rental_id = payment.rental_id

GROUP BY 
	customer.first_name,
    customer.last_name

ORDER BY 
	SUM(payment.amount) DESC
    ;
    
/*
33 My partner and I would like to get to know your board of advisors and any current investors.
Could you please provide a list of advisor and investor names in one table? 
Could you please note whether they are an investor or an advisor, and for the investors, 
it would be good to include which company they work with. 
*/

SELECT
	'investor' AS type, 
    first_name, 
    last_name, 
    company_name
FROM investor

UNION 

SELECT 
	'advisor' AS type, 
    first_name, 
    last_name, 
    NULL
FROM advisor;

/*
34. We're interested in how well you have covered the most-awarded actors. 
Of all the actors with three types of awards, for what % of them do we carry a film?
And how about for actors with two types of awards? Same questions. 
Finally, how about actors with just one award? 
*/

SELECT
	CASE 
		WHEN actor_award.awards = 'Emmy, Oscar, Tony ' THEN '3 awards'
        WHEN actor_award.awards IN ('Emmy, Oscar','Emmy, Tony', 'Oscar, Tony') THEN '2 awards'
		ELSE '1 award'
	END AS number_of_awards, 
    AVG(CASE WHEN actor_award.actor_id IS NULL THEN 0 ELSE 1 END) AS pct_w_one_film
	
FROM actor_award
	

GROUP BY 
	CASE 
		WHEN actor_award.awards = 'Emmy, Oscar, Tony ' THEN '3 awards'
        WHEN actor_award.awards IN ('Emmy, Oscar','Emmy, Tony', 'Oscar, Tony') THEN '2 awards'
		ELSE '1 award'
	END