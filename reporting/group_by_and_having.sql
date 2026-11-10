-- D. GROUP BY & HAVING (22–26)

-- Show customers who placed more than 3 orders.
	
	SELECT * FROM order_details;
	
		
	SELECT
		od_cust_code
	FROM order_details	
	GROUP BY
		od_cust_code
	HAVING
		COUNT(*) > 3;    ------------------ this will include null values



	SELECT
		od_cust_code
	FROM order_details	
	GROUP BY
		od_cust_code
	HAVING
		COUNT(od_no) > 3;    ------------------ this will not include the null values

		

-- Display items with total sales quantity greater than a given number.

-- no : - 100

	SELECT * FROM order_details;

	SELECT
		od_item,
		SUM(od_units) AS total_units
	FROM order_details
	GROUP BY
		od_item
	HAVING
		SUM(od_units) > 100;


	SELECT * FROM order_details;

	SELECT * FROM item_details;

	SELECT
		i.id_item_name,	
		SUM(o.od_units) AS total_units
	FROM order_details o
	JOIN item_details i 
		on o.od_item_code = i.id_item_code
	GROUP BY
		i.id_item_name
	HAVING
		sum(o.od_units) > 100;



-- Find suppliers whose total purchase amount exceeds a limit.

-- LIMIT : 200000

SELECT * FROM po_details;

	SELECT
		po_sup_code,
		SUM(po_po_amt) as total_purchase
	FROM po_details
	GROUP BY
		po_sup_code
	HAVING
		SUM(po_po_amt) > 200000;

-- Show salesmen who handled total orders above a threshold.( above average_order)

	SELECT * FROM order_details;

	SELECT * FROM salesman_details;


	SELECT
		sd.sd_usrname,
		SUM(od.od_sale_amt) AS total_sales
	FROM order_details od
	JOIN salesman_details sd
	 	ON od.od_sd_userid = sd.sd_userid
	GROUP BY
		sd.sd_usrname
	HAVING 
		SUM(od.od_sale_amt) > 
				(SELECT ROUND(AVG(total_sales),2)
				FROM
					(SELECT 
						SUM(od_sale_amt) AS total_sales 
					FROM order_details					
					GROUP BY od_sd_userid) a ) ;	-------------------- do not use od_sale_amt in averge if it will return more row error

-- Display cities having more than 2 customers.

SELECT * FROM customer_details;

	SELECT
		cust_city
	FROM customer_details
	GROUP BY 	
		cust_city
	HAVING 
		COUNT(cust_city) > 2;


		
