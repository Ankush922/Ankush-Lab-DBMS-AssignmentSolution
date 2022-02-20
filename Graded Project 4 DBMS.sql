/*3) How many females and how many male passengers travelled for a minimum distance of 
600 KM s?
*/
select Gender from passenger where Distance >= 600;

/*4) Find the minimum ticket price for Sleeper Bus. */
select min(Price) from price where Bus_Type = 'Sleeper';

/*5) Select passenger names whose names start with character 'S' */
select Passenger_name from passenger where Passenger_name LIKE 'S%';

/*9) List the distances from the "Passenger" table which are unique (non-repeated 
distances) in descending order*/
select distinct Distance from passenger order by Distance desc;
