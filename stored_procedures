-- Stored Procedures
-- Implemented procedures to handle core business operations:
-- Order creation and management 
-- Payment processing and status updates 
-- Purchase order handling for suppliers 
-- Salesman assignment to orders 


select * from customer_orders

select * from order_details


-- Order creation and management 

CREATE SEQUENCE IF NOT EXISTS co_no_seq START 144;

CREATE OR REPLACE PROCEDURE create_order_for_central_region(
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
    v_region VARCHAR(50) := 'Central'; -- Defaulted to 'Central' to fix your error
    v_new_order_no INT;
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

    -- 3. Fetch Salesman region 
    -- FIX: Check your column name here. If it's not 'sd_region', use the correct one.
    -- SELECT actual_column_name INTO v_region FROM salesman_details WHERE sd_userid = p_salesperson_id;

    v_new_order_no := nextval('co_no_seq');

    -- 5. Insert into customer_orders
    INSERT INTO customer_orders (
        co_no, co_oderdate, co_cust_code, co_qty, 
        co_item_price, co_amt, co_sd_userid
    )
    VALUES (
        v_new_order_no, CURRENT_DATE, p_customer_id, p_qty, 
        v_price, (v_price * p_qty), p_salesperson_id
    );

    -- 6. Insert into order_details
    INSERT INTO order_details (
        od_no, od_date, od_region, od_sd_userid, 
        od_item, od_cust_code, od_units, od_unit_price, 
        od_sale_amt, od_item_code
    )
    VALUES (
        v_new_order_no, CURRENT_DATE, v_region, p_salesperson_id, 
        v_item_name, p_customer_id, p_qty, v_price, 
        (v_price * p_qty), p_item_id
    );

    RAISE NOTICE 'Order % created successfully for %', v_new_order_no, v_cust_name;
END;
$$;


CALL create_order_for_central_region('AA002',10002,100,1001)



-- Payment processing and status updates



select * from payment_details

select * from payment_type


CREATE SEQUENCE IF NOT EXISTS payment_pd_no START 44;



CREATE OR REPLACE PROCEDURE update_customer_payment(

	pay_customer_id VARCHAR, 
    pay_order_no INT, 
    pay_code INT, 
    pay_amt NUMERIC
)

LANGUAGE plpgsql
AS $$
DECLARE
	customer_pay VARCHAR;
	tr_pay_code INT;
	new_pay_id INT;

BEGIN

	-- Fetch the customer id
	SELECT pd_cust_code
	INTO customer_pay
	FROM payment_details
	WHERE pd_cust_code = pay_customer_id
	LIMIT 1;

	-- Fetch the payment_type
	SELECT pt_code
	INTO tr_pay_code
	FROM payment_type
	WHERE pt_code = tr_pay_code;


	-- Create a new payment_id
	    new_pay_id := nextval('payment_pd_no');

	    -- 5. Insert into payment_details
    INSERT INTO payment_details (
       pd_no , pd_payment_date,pd_order_no, pd_order_amt, pd_pay_code , pd_cust_code
    )
    VALUES (
       new_pay_id , CURRENT_DATE , pay_order_no, pay_amt, pay_code , pay_customer_id
    );

	RAISE NOTICE 'Payment recorded successfully!';
END
$$


select * from payment_type
CALL update_customer_payment('AA002',144,2,50000);

select * from payment_details

-- when customer place a order the stock also minus from inventory



-- Purchase order handling for suppliers

SELECT * FROM po_details

select * from inventory_stocks

SELECT * FROM order_details 
od_userid
od_sd_userid

SELECT * from item_details 
id_item_code 

select * from salesman_details 
sd_userid



CREATE OR REPLACE FUNCTION stock_status(product_id NUMERIC)
RETURNS TABLE 
(
    id_item_name VARCHAR,
    actual_stock NUMERIC
)
AS 
$$
SELECT
    id.id_item_name,
    invs.invs_quantity - COALESCE(od.total_sold, 0) AS actual_stock
FROM item_details id
JOIN inventory_stocks invs
    ON id.id_item_code = invs.invs_item_id
LEFT JOIN (
    SELECT 
        od_item_code,
        SUM(od_units) AS total_sold
    FROM order_details
    GROUP BY od_item_code
) od
    ON id.id_item_code = od.od_item_code
WHERE id.id_item_code = od_item_code;
$$
LANGUAGE SQL;

select * from item_details

SELECT * FROM inventory_stocks

stock_qty_reamin
min_godown_stock




-- quantity_sold_per_product new function

SELECT (stock_status(10001)).*;

-- check stock_qty
-- if order_qty is less than stock advice to place a order 

-- to place a order check a min_stock_qty if the stk_qty is <= min qty we will place the order 

-- function for update stock_status for every order place ( stock_qty - order_qty)





