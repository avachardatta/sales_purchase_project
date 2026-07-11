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

