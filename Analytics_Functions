-- total qty sold per sales_person


select * from order_details
od_sd_userid

SELECT * FROM salesman_details
sd_userid


CREATE OR REPLACE FUNCTION total_sales_per_salesperson (p_salesman_id INT) RETURNS
TABLE 
(
	salesman_name VARCHAR,
	product_name VARCHAR,
	total_qty_sold NUMERIC,
	total_sales NUMERIC
)
AS
$$
BEGIN
	RETURN QUERY
	SELECT
	    COALESCE(sd.sd_usrname, 'GRAND TOTAL') AS salesman_name,
	    COALESCE(od.od_item, 'ALL PRODUCTS') AS product_name,
	    SUM(od.od_units) AS total_qty_sold,
	    SUM(od.od_sale_amt) AS total_sales
	FROM order_details od
	JOIN salesman_details sd
	    ON od.od_sd_userid = sd.sd_userid
	WHERE
		sd.sd_userid = p_salesman_id
	GROUP BY
	    GROUPING SETS (
	        (sd.sd_usrname, od.od_item, sd.sd_userid, od.od_item_code), -- Detail Level
	        (sd.sd_usrname, sd.sd_userid),                             -- Salesperson Subtotal
	        ()                                                        -- Grand Total
	    )
	ORDER BY
	    sd.sd_usrname NULLS LAST;

END;
$$
LANGUAGE plpgsql

SELECT * FROM total_sales_per_salesperson(1002);








