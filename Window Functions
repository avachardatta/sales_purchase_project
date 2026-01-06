-- F. Window Functions (31–33)

-- Rank customers based on total sales amount.


	SELECT * FROM order_details;

	SELECT
		od_cust_code,
		RANK() OVER(ORDER BY od_sale_amt desc ) as r_n
	FROM order_details;
	

-- Find the top 2 highest orders per customer.

SELECT * FROM order_details;

 SELECT * 
	FROM (
		SELECT
			od_no,
			od_cust_code,
			od_item,
			od_sale_amt,
			ROW_NUMBER() OVER(PARTITION BY od_cust_code ORDER BY od_sale_amt desc ) as r_n
		FROM order_details
	) a
 WHERE
	r_n <=2;

-- Show running total of payments ordered by payment date.

	-- SELECT * FROM order_details;

	SELECT
		od_date,
		od_sale_amt,
		SUM(od_sale_amt) OVER(ORDER BY od_date) AS running_total
	FROM order_details;
	

