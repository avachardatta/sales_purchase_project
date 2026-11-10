
-- ALTER TABLE order_details DROP COLUMN od_status VARCHAR(20) DEFAULT 'Pending';
-- ALTER TABLE order_details DROP COLUMN od_discount NUMERIC DEFAULT 0;
-- ALTER TABLE order_details DROP COLUMN od_final_amt NUMERIC;


-- ALTER TABLE customer_orders DROP COLUMN co_status VARCHAR(20) DEFAULT 'Pending';
-- ALTER TABLE customer_orders DROP COLUMN co_discount NUMERIC DEFAULT 0;
-- ALTER TABLE customer_orders DROP COLUMN co_final_amt NUMERIC;


-- select * from customer_orders

-- select * from order_details

-- UPDATE order_details 
-- SET od_status = 'Delivered', od_discount = 0, od_final_amt = od_sale_amt;

-- UPDATE customer_orders 
-- SET co_status = 'Delivered', co_discount = 0, co_final_amt = co_amt;



-- Order creation and management 

CREATE SEQUENCE IF NOT EXISTS co_no_seq START 145;

-- DROP SEQUENCE co_no_seq


-- Customer Order "Request

-- update a customer_order table 
-- status : Pending
-- co_dicount login 
--  if the product qty is greter than 100 then 5 % discount
--  if product qty is > 150 then 10 % 
--  if product qty is > 200 then 15%
--  else 0

select * from salesman_details
select * from item_details

SELECT * FROM customer_orders

CREATE OR REPLACE PROCEDURE create_order(
    p_customer_id VARCHAR, 
    p_item_id INT, 
    p_qty INT, 
    p_salesperson_id INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_price NUMERIC;
    v_item_name VARCHAR(100);
    v_cust_name VARCHAR(100);
    v_new_order_no INT; 
	v_discount_percent NUMERIC;
    v_cust_discount NUMERIC;
    v_gross_amt NUMERIC;
BEGIN
    -- 1. Fetch Item details
    SELECT id_item_price, id_item_name 
    INTO v_price, v_item_name
    FROM item_details 
    WHERE id_item_code = p_item_id; 

    -- 2. Fetch Customer name
    SELECT cust_name INTO v_cust_name
    FROM customer_details
    WHERE cust_code = p_customer_id;

    --  4. calculate gross amt
		v_gross_amt := v_price * p_qty;
  

    -- 4. Discount logic
	
	IF p_qty BETWEEN 50 AND 100 THEN 
		v_discount_percent := 5;
	ELSEIF p_qty BETWEEN 150 AND 200 THEN 
		v_discount_percent := 10;
	ELSEIF p_qty > 200 THEN 
		v_discount_percent := 15;
	ELSE 
		v_discount_percent := 0;	
	END IF;

	v_cust_discount := (v_price * p_qty) * (v_discount_percent / 100.0);	
 	v_new_order_no := nextval('co_no_seq'); 

    -- 5. Insert into customer_orders
    INSERT INTO customer_orders (
        co_no, co_oderdate, co_cust_code, co_qty, 
        co_item_price, co_amt, co_sd_userid, co_status , co_discount, co_final_amt
    )
    VALUES (
        v_new_order_no, CURRENT_DATE, p_customer_id, p_qty, 
        v_price, (v_price * p_qty), p_salesperson_id , 'Pending' , v_discount_percent , ROUND((v_gross_amt - v_cust_discount),2)
    );


    RAISE NOTICE 'Order % created for %. Discount: %', v_new_order_no, v_cust_name, ROUND(v_cust_discount,2);
END;
$$;


CALL create_order('AA002',10005,30,1001)



-- The Order Validation & Stock Fulfillment


-- Logic Step A (Check): Call your stock_status function for the requested item_id.
-- Logic Step B (Branching/If-Else):
-- IF Stock is Enough:
-- Insert the row into order_details.
-- Update the status in customer_orders to 'Confirmed'.
-- ELSE (Stock is Low):
-- Do NOT insert into order_details yet.
-- New Action: Insert a record into a purchase_orders table (this is your "restock request").
-- Update the status in customer_orders to 'Awaiting Purchase'.


SELECT (stock_status(10001)).*;



CREATE OR REPLACE PROCEDURE Order_Validation(


)
LANGUAGE plpgsql
AS $$
DECLARE




	


BEGIN

	stock_status


	RAISE NOTICE
END; 
$$








