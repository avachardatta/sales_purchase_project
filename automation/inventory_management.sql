-- we can check the hw many stock are remain per product

CREATE OR REPLACE FUNCTION stock_status(product_id NUMERIC)
RETURNS TABLE 
(
    id_item_name VARCHAR,
    actual_stock NUMERIC
)
AS 
$$

-- Count the current stock Total_stock - sale_qty

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

SELECT (stock_status(10001)).*;
