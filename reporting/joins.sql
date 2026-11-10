-- B. JOINs – Business Relationships (8–15)


-- Display customer name, order number, and order amount.

SELECT * FROM customer_details;
SELECT * FROM order_details;

		SELECT 
			cust_name,
			od_no,
			od_sale_amt
		FROM
			customer_details 
		JOIN 
			order_details ON  cust_code = od_cust_code; 


-- Show item name along with total ordered quantity.

SELECT *  FROM item_details;
SELECT * FROM order_details;

	SELECT 
		id_item_name,
		sum(od_units) as total_order_qty
	FROM
		item_details
	JOIN
		order_details ON  id_item_code = od_item_code
	GROUP BY
		id_item_name;


-- Fetch orders handled by a specific salesman		

	SELECT * FROM salesman_details;
	SELECT * FROM order_details;


	SELECT
		sd_usrname,
		od_no,
		od_date,
		od_item,
		od_units,
		od_sale_amt
	FROM
		order_details
	JOIN
		salesman_details on od_sd_userid = sd_userid
	WHERE
		sd_userid = 1001;
	


-- Display customer name and payment details for completed payments.

	
	SELECT * FROM payment_details
	SELECT * FROM customer_details;


	SELECT
		C.cust_name,
		P.pd_payment_date,
		P.pd_order_amt
	FROM
		payment_details P
	JOIN
		customer_details C ON p.pd_cust_code = c.cust_code;
	



-- List purchase orders with supplier name.

	SELECT * FROM supplier_details;
	SELECT *  FROM po_details;
	
	SELECT 
		s.sp_name,
		p.po_po_no,
		p.po_po_date,
		p.po_po_item_name,
		p.po_po_qty,
		p.po_po_price,
		p.po_po_amt
	FROM
		po_details p
	JOIN
		supplier_details s ON  p.po_sup_code = s.sp_code; 


-- Display customers who have placed at least one order.

	SELECT * FROM customer_details;
	SELECT * FROM order_details;	

	SELECT 
		DISTINCT 
			C.cust_code,
			C.cust_name
	FROM
		customer_details C
	JOIN
		order_details O ON C.cust_code = O.od_cust_code;

-- Show suppliers who have never received a purchase order.

	SELECT * FROM supplier_details;
	SELECT * FROM po_details;

	SELECT
		sp_code,
		sp_name
	FROM
		supplier_details S
	LEFT JOIN
		po_details P ON sp_code = po_sup_code
	WHERE 
		p.po_sup_code IS NULL;	



	
	

















