-- Find total sales amount customer-wise.

SELECT * FROM order_details;

SELECT
	od_cust_code,
	SUM(od_sale_amt) AS total_sale_amt
FROM
	order_details
GROUP BY
	od_cust_code;


-- Calculate total order quantity item-wise.

SELECT * FROM order_details;

SELECT
	od_item,
	SUM(od_units) as total_qty
FROM
	order_details
GROUP BY
	od_item;
	
-- Find total payment received per customer.

SELECT * FROM payment_details;

SELECT
	pd_cust_code,
	SUM(pd_order_amt) AS total_pay
FROM
	payment_details
GROUP BY
	pd_cust_code;

-- Display supplier-wise total purchase amount.

SELECT * FROM po_details;

SELECT
	po_sup_code,
	sum(po_po_amt) as purchase_amt
FROM
	po_details
GROUP BY
	po_sup_code;

-- Find the highest order amount.


SELECT * FROM order_details;

SELECT
	MAX(od_sale_amt) AS highest_order_amt
FROM
	order_details;


SELECT * FROM customer_orders;

SELECT
	max(co_amt) as highest_order_amt
FROM
	customer_orders;




-- Find average order value across all orders.


SELECT * FROM order_details;


SELECT
	ROUND(AVG(od_sale_amt),2) as avg_order_amt
FROM
	order_details;


