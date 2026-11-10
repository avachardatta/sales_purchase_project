-- . Real Business Scenarios (34–35)

-- Find pending payment amount for each customer (order amount − paid amount).


	SELECT * FROM order_details;

	SELECT * FROM payment_details;

	-- Pending balance per customer = total ordered - total paid.
	-- Aggregate each table first, then join, so rows are not multiplied
	-- (joining raw orders to raw payments on customer repeats each order
	-- once per payment and inflates both sums).
	WITH orders AS (
		SELECT od_cust_code, SUM(od_sale_amt) AS total_ordered
		FROM order_details
		GROUP BY od_cust_code
	),
	payments AS (
		SELECT pd_cust_code, SUM(pd_order_amt) AS total_paid
		FROM payment_details
		GROUP BY pd_cust_code
	)
	SELECT
		o.od_cust_code,
		o.total_ordered,
		COALESCE(p.total_paid, 0) AS total_paid,
		o.total_ordered - COALESCE(p.total_paid, 0) AS bal_payment
	FROM orders o
	LEFT JOIN payments p
		ON o.od_cust_code = p.pd_cust_code
	ORDER BY bal_payment DESC;
	


-- Identify customers who ordered but never completed payment


-- SELECT * FROM order_details;

-- SELECT * FROM payment_details;


	
	SELECT
		DISTINCT od_cust_code
	FROM order_details	
	WHERE 
		 NOT EXISTS
		(SELECT
				pd_cust_code
			FROM payment_details 
			WHERE 
				pd_cust_code = od_cust_code
		);



