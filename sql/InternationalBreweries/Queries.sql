-- SQL CAPSTONE PROJECT

-- SECTION A PROFIT ANALYSIS

-- Question 1.	
/*Within the space of the last three years, what was the profit worth of the breweries, 
inclusive of the anglophone and the francophone territories?*/

SELECT SUM (profit)
FROM sales_record
WHERE years IN ('2017', '2018', '2019');

-- Question 2.	
/* Compare the total profit between these two territories in order for the 
territory manager, Mr. Stone made a strategic decision that will aid 
profit maximization in 2020. */

SELECT CASE WHEN countries IN ('Nigeria', 'Ghana') THEN 'Anglophone'
		ELSE 'Francophone' END AS Territories,
		SUM(profit)
FROM sales_record
GROUP BY 1;


-- Question 3.	
/* Country that generated the highest profit in 2019. */

SELECT countries, SUM (profit) AS highest_profit
FROM sales_record
WHERE years = '2019'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

-- Question 4.	
/* Help him find the year with the highest profit.. */

SELECT years, SUM (profit) AS highest_profit
FROM sales_record
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

-- Question 5.	
/* Which month in the three years was the least profit generated */

SELECT months, SUM (profit) AS least_profit
FROM sales_record
GROUP BY 1
ORDER BY 2
LIMIT 1;

-- Question 6.	
/* What was the minimum profit in the month of December 2018 */

SELECT MIN (profit) AS min_profit_in_Dec_2018
FROM sales_record
WHERE years = '2018' AND months = 'December';

-- Question 7.	
/* Compare the profit in percentage for each of the month in 2019 */

SELECT months, LEFT(Percentage::varchar, 4)||'%' as percent_profit
FROM
	(SELECT months, profit*100.0/cost AS Percentage
	FROM
		(SELECT months, SUM(profit) AS profit, SUM (cost) AS cost
		FROM sales_record
		WHERE years = '2019'
		GROUP BY 1
		ORDER BY 2 DESC) AS sub1
	ORDER BY 1) AS sub2;

-- Question 8.	
/* Which particular brand generated the highest profit in Senegal */

SELECT brands, SUM(profit) AS highest_profit
FROM sales_record
WHERE countries = 'Senegal'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;


-- SECTION B BRAND ANALYSIS

-- Question 1.	
/* Within the last two years, the brand manager wants to know the top three brands 
consumed in the francophone countries*/

SELECT brands AS Top_brands, SUM (quantity) AS quantity_consumed
FROM sales_record
WHERE years IN ('2018', '2019') AND countries IN ('Senegal', 'Togo', 'Benin')
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;

-- Question 2.	
/* Find out the top two choice of consumer brands in Ghana */

SELECT brands AS Top_choice, SUM (quantity) AS quantity_consumed
FROM sales_record
WHERE countries = 'Ghana' 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 2;

-- Question 3.	
/* Find out the details of beers consumed in the past three years 
in the most oil reached country in West Africa. */

SELECT brands AS Beer, SUM (quantity) AS quantity_consumed, 
					   SUM (plant_cost) AS plant_cost,
					   SUM (cost) AS cost,
					   SUM (profit) AS profit
FROM sales_record
WHERE brands NOT LIKE '%malt' AND years IN ('2017', '2018', '2019') AND countries = 'Nigeria' 
GROUP BY 1
ORDER BY 2 DESC;

-- Question 4.	
/* Favorites malt brand in Anglophone region between 2018 and 2019 */

SELECT brands AS Malt_Brand, SUM (quantity) AS quantity_consumed
FROM sales_record
WHERE brands LIKE '%malt' AND years IN ('2018', '2019') AND countries IN ('Nigeria', 'Ghana') 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

-- Question 5.	
/* Which brands sold the highest in 2019 in Nigeria */

SELECT brands, SUM (quantity) AS highest_quantity_sold
FROM sales_record
WHERE years = '2019' AND countries = 'Nigeria' 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

-- Question 6.	
/* Favorites brand in South_South region in Nigeria */

SELECT brands, SUM (quantity) AS quantity_consumed
FROM sales_record
WHERE countries = 'Nigeria' AND region = 'southsouth' 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

-- Question 7.	
/* Beer consumption in Nigeria */

SELECT brands AS Beer, region, SUM (quantity) AS quantity_consumed
FROM sales_record
WHERE brands NOT LIKE '%malt' AND countries = 'Nigeria' 
GROUP BY 1,2
ORDER BY 3 DESC;

-- Question 8.	
/* Level of consumption of Budweiser in the regions in Nigeria */

SELECT region, SUM (quantity) AS quantity_consumed
FROM sales_record
WHERE brands = 'budweiser' AND countries = 'Nigeria' 
GROUP BY 1
ORDER BY 2 DESC;

-- Question 8.	
/* Level of consumption of Budweiser in the regions in Nigeria in 2019 (Decision on Promo)   */

SELECT region, SUM (quantity) AS quantity_consumed
FROM sales_record
WHERE brands = 'budweiser' AND countries = 'Nigeria' AND years = '2019'
GROUP BY 1
ORDER BY 2 DESC;


-- SECTION C COUNTRY ANALYSIS

-- Question 1.	
/* Country with the highest consumption of beer*/

SELECT countries, SUM (quantity) AS highest_beer_consumed
FROM sales_record
WHERE brands NOT LIKE '%malt' 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

-- Question 2.	
/* Highest sales personnel of Budweiser in Senegal*/


SELECT sales_rep, SUM (quantity) AS quantity_Sold
FROM sales_record
WHERE brands = 'budweiser' AND countries = 'Senegal' 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

-- Question 3.	
/* Country with the highest profit of the fourth quarter in 2019*/

SELECT countries, SUM (profit) AS highest_profit
FROM sales_record
WHERE years = '2019' AND months IN ('October', 'November', 'December')
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;



