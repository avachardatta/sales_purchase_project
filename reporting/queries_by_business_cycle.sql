
-- Basic SELECT & WHERE


-- Display all customers from a specific city

		SELECT *
		FROM customer_details
		WHERE 
			cust_city = 'Mumbai';			
			
-- Display all godowns located in a given city

	SELECT *
		FROM godown_details
	WHERE 
		godown_details.gd_godown_city = 'Mumbai';

-- - List all items available in item_details

	SELECT *
		FROM item_details;
		
ALTER TABLE order_details ADD COLUMN od_item_code INT 


-- UPDATE order_details 
-- 	SET od_item_code = 
-- 		CASE 
-- 			WHEN od_item = 'Television' THEN 10001
-- 			WHEN od_item = 'Home Theater' THEN 10002
-- 			WHEN od_item = 'Cell Phone' THEN 10003
-- 			WHEN od_item = 'Desk' THEN 10004
-- 			WHEN od_item = 'Video Games' THEN 10005
-- 		ELSE
-- 			0
-- 		END;



-- Fetch all orders placed by a particular customer code.

	SELECT * 
		FROM  order_details 
	WHERE order_details.od_cust_code = 'AA001';


-- List all salesmen usernames from

	SELECT sd_usrname
		FROM salesman_details
		
-- Show all suppliers belonging to a specific state

		SELECT * 
			FROM supplier_details	
		WHERE 
			sp_state = 'Maharashtra';
			
select * from item_details;

-- ALTER TABLE item_details ADD COLUMN id_item_price INT 

-- ALTER TABLE item_details ALTER id_item_price TYPE DECIMAL (10,2) 

-- UPDATE item_details 
-- SET id_item_price = 
-- CASE
-- 	WHEN id_item_name = 'Television' THEN 1198
-- 	WHEN id_item_name = 'Home Theater' THEN 500
-- 	WHEN id_item_name = 'Cell Phone' THEN 125
-- 	WHEN id_item_name = 'Desk' THEN 58.5
-- 	WHEN id_item_name = 'Video Games' THEN 225
-- ELSE 0
-- END ;


-- UPDATE item_details SET id_item_price = 58.5
-- WHERE id_item_code = 10004;

-- tel 1198
-- hm 500
-- desk 125
-- video gam 58.5
-- cell 225




