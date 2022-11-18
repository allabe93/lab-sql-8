-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
select title, length, 
rank() over (order by length asc) as ranking
from sakila.film
where length is not null and length != 0;

-- 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.
select title, length, rating,
dense_rank() over (order by rating asc) as ranking
from sakila.film
where length is not null and length != 0;

-- 3. How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
select s1.category_id, count(s2.film_id) as number_of_films, s1.name as category_name
from category as s1
inner join film_category as s2
on s1.category_id = s2.category_id
group by category_id;

-- 4. Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
select x1.actor_id, x1.first_name, count(x2.actor_id)
from actor as x1
inner join film_actor as x2
on x1.actor_id = x2.actor_id
group by first_name
order by count(x2.actor_id) desc;

-- 5. Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
select a1.customer_id, a1.first_name, count(b2.customer_id)
from customer as a1
inner join rental as b2
on a1.customer_id = b2.customer_id
group by first_name
order by count(b2.customer_id) desc;

-- BONUS. Which is the most rented film? (The answer is Bucket Brotherhood). This query might require using more than one join statement. Give it a try. We will talk about queries with multiple join statements later in the lessons. Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.
select a.film_id, a.title, b.inventory_id, count(c.rental_id)
from film as a
join inventory as b on a.film_id = b.film_id
join rental as c on b.inventory_id = c.inventory_id
group by title
order by count(c.rental_id) desc;

-- For the exercises #4, #5 and BONUS I could have used "limit 1;" at the end to show in the output only the exact result that the exercises are asking for. 