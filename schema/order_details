

CREATE TABLE order_details
(
	od_no NUMERIC NOT NULL,
	od_date DATE,
	od_region VARCHAR(10),
	od_sd_userid NUMERIC NOT NULL,
	od_item VARCHAR(100) NOT NULL,
	od_cust_code VARCHAR(50) NOT NULL,
	od_units NUMERIC NOT NULL,
	od_unit_price NUMERIC (10,2),
	od_sale_amt NUMERIC(10,2)
);

SELECT * FROM order_details;

INSERT INTO order_details
(od_no, od_date, od_region, od_sd_userid, od_item, od_cust_code, od_units, od_unit_price, od_sale_amt
)
VALUES
(101,'2018-06-01' ,'East', 1001, 'Television', 'AA001',95,1198,113810),
(102,'2018-01-23','Central',1002,'Home Theater','AA002',50,500,25000),
(103,'2018-02-09','Central',1003,'Television','AA003',36,1198,43128),
(104,'2018-02-26','Central',1004,'Cell Phone','AA004',27,225,6075);



TRUNCATE TABLE order_details;
-- date format issue 




