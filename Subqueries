-- E. Subqueries (27–30)

-- Find customers who placed orders greater than the average order amount.

	SELECT * FROM customer_orders;

	SELECT 
		co_cust_name
	FROM customer_orders
	WHERE
		co_amt > 
			(SELECT 
				AVG(co_amt)
			FROM customer_orders );

-- Display items that were never ordered.


	SELECT * FROM order_details;
	SELECT * FROM item_details;
	
	SELECT
		od_item
	FROM order_details
	WHERE 
		od_item NOT IN 
				(SELECT 
					id_item_name 
				 FROM item_details	
				 WHERE 
				 	id_item_code = od_item_code);
	
	
-- Find customers who have not made any payment.

	SELECT * FROM payment_details;
	SELECT * FROM customer_details;
	SELECT * FROM order_details;
	

	SELECT
		cust_name
	FROM customer_details
	JOIN order_details
		ON od_cust_code = cust_code
	WHERE
	 	od_cust_code NOT IN 
				(SELECT
					pd_cust_code
				FROM payment_details
				WHERE 
					pd_cust_code = od_cust_code);

-- Show suppliers whose purchase amount is greater than the average purchase amount.


	SELECT * FROM po_details;

	SELECT * FROM supplier_details
	
	SELECT
	    s.sp_name,
	    SUM(p.po_po_amt) AS total_purchase_amt
	FROM po_details p
	JOIN supplier_details s
	    ON p.po_sup_code = s.sp_code
	GROUP BY
	    s.sp_name
	HAVING
	    SUM(p.po_po_amt) >
	    ( SELECT AVG(total_amt)
	        FROM (
	            SELECT SUM(po_po_amt) AS total_amt
	            FROM po_details
	            GROUP BY po_sup_code) a
	    );

