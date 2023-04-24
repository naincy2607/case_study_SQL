-- Motion Pictures Data Analysis
/*description = The Motion Picture Association (MPA) is a movie rating system
 Sakila is a movie rental store with a vast collection of movies in DVDs and blue ray disc formats.
  The management wants to analyze the data to understand what kind of movies and actors are often
rented. This analysis would help them stock up the inventory of movies to improve their business*/ 

/*Task 1: The Sakila rental store management wants to know the names of all the actors in their movie collection. 
Display the first names, last names, actor IDs, and the details of the last updated column.*/
use sakila;
select * from actor;

/*Task 2: Many actors nave adopted attractive screen names, mostly at the behest of producers and directors. 
The management wants to know the following 
a. Display the full names of all .
b. Display the first names of actors along with the count of repeated first names
c. Display the last name of actors along with the count of repeated last names*/
select concat(first_name," " ,last_name) as actors_full_name from actor;
-- i have used concat func to display the full names of actor. 

select first_name , count(*) from actor group by first_name order by count(*) desc ;
-- intrp=there are some actors who have same first name rest of them are distinctt.

select last_name , count(*) from actor group by last_name order by count(*) desc;
-- intpr=there are some actors who have same last name rest of them are distinctt.

-- Task 3: Display the count of movies grouped by the ratings.Sample output: Rating Count of movies

select rating AS Rating, count(*) as "Count of movies"  from film group by RATING HAVING RATING = 'G' or RATING = 'R' ;
-- intrp= there are 178 movies comes under G rating and 195 im R. 

-- Task 4: Calculate and display the average rental rates basedon the movie ratings.

select rating as Rating , avg(rental_rate) as avg_rental_rate$ from film group by RATING HAVING RATING = 'PG-13' or RATING = 'G';
-- intrp= avg. rental rate for rating G and pg_13 are 2.8$ and 3.03$ resp. 

/*Task 5: The management wants the data about replacement cost of movies. Replacement cost is the amount of money
required to replace an existing asset (DVD/blue ray disc) with an equally valued or similar asset at the current market price.
a. Display the movie titles where the replacement cost is up to $9.*/ 
select title,replacement_cost from film where replacement_cost<9;
-- intrp= from above task i can see that there is no movie who had replacment cost upto $9. 

-- b. Display the movie titles where the replacement cost is between $15 and $20. 

select title,replacement_cost from film where replacement_cost between 15 and 20;
-- intrp=these movies have replacment cost between 15 and 20. 

-- c. Display the movie titles with the highest replacement cost and the lowest rental cost.

select title, replacement_cost as "highest replacment cost"  from film order by replacement_cost desc limit 1 ;
-- intrp=  arabia dogma is the having highest replacmnet cost.alter.alter

select title, rental_rate as "lowest rental rate"  from film order by  rental_rate limit 1 ;
-- intrp=  academy dinosaur is the movie having lowest rental rate


-- Task 6: The management needs to know the list all the movies along with the number of actors listed for each movie.
select title as movie,count(actor.actor_id) ,group_concat(concat(first_name ," ",last_name))
 from film join film_actor join actor on film.film_id=film_actor.film_id
 and film_actor.actor_id=actor.actor_id group by title;
 --  intrpr= i have used group concat func just to know the names actors too who were present in that movie along with count.
 
 
/* Task 7: The Music of Queen and Kris Kristofferson has seen an unlikely resurgence.
 As an unintended consequence, movies starting with the letters 'K' and 'Q' have also soared in popularity. 
 Display the movie titles starting with the letters 'K'and 'Q'&*/
 
 select title from film where title like "K%" OR TITLE LIKE "Q%";
 
-- intrp=there are total 15 num of movies with initial k and q as listed below.  
 
 
 
 
 -- Task 8: The movie 'AGENT TRUMAN' has been a great success. Display the first names and last names of all actors who are a part of this movie.

 select title as movie ,group_concat(concat(first_name ," ",last_name)) as "list of actors"
 from film join film_actor join actor on film.film_id=film_actor.film_id
 and film_actor.actor_id=actor.actor_id group by title HAVING TITLE ="AGENT TRUMAN";
 
 -- intrp= this the list list of actors who were there in agent truman movie
 
 --
/*Task 9: Sales has been down among the family audience with kids.
 The management wants to promote the movies that fall under the 'children' category. 
 Identify and display the names of the movies in the family category. */
 SELECT TITLE , name AS CATEGORY FROM category
 JOIN film_category JOIN film ON category.category_id=film_category.category_id AND film_category.film_id=film.film_id
 WHERE NAME="FAMILY";
 -- intrp= 69 movies falling in category family. 
 
 
 -- Task 10: Display the names of the most frequently rented movies in descending order, so that the management can maintain more copies of such movies

 SELECT f.title, COUNT(f.title) as rentals from film f 
JOIN 
	(SELECT r.rental_id, i.film_id FROM rental r 
    JOIN 
    inventory i ON i.inventory_id = r.inventory_id) a
    ON a.film_id = f.film_id GROUP BY f.title ORDER BY rentals DESC;
    
    
/*Task 11: Calculate and display the number of movie categories where the average difference
 between the movie replacement cost and the rental rate is greater than $15.*/    

SELECT name, COUNT(TITLE) as num_of_movies,avg(replacement_cost-rental_rate) as  avg_difference FROM film 
JOIN film_category JOIN category ON film.film_id=film_category.film_id AND film_category.category_id=category.category_id  group by name having avg(replacement_cost-rental_rate)>15;

/*Task 12: The management wants to identify all the genres that consist of 60-70 movies. 
The genre details are captured in the category column Display the names of these categories/genres 
and the number of movies per category/genre, sorted by the number of movies.*/

SELECT name AS GENRE,COUNT(title) AS "NO_OF_MOVIE"  FROM film 
JOIN film_category JOIN category ON film.film_id=film_category.film_id AND film_category.category_id=category.category_id GROUP BY NAME having 
COUNT(title) between 60 and 70;

-- intrp= num of movies fallling in each genre 