CREATE TABLE inventory_stocks (
    invs_stock_id INT PRIMARY KEY,
    invs_item_id NUMERIC REFERENCES item_details(id_item_code),
    invs_godown_id VARCHAR REFERENCES godown_details(gd_godown_code), 
    invs_quantity NUMERIC CHECK (invs_quantity >= 0) 
);


INSERT INTO inventory_stocks (invs_stock_id, invs_item_id, invs_godown_id, invs_quantity)
VALUES 
(1, 10001, 'GD001', 2800), -- Combined PO001 (2000) and PO006 (800)
(2, 10002, 'GD001', 2400), -- Combined PO002 (1500) and PO007 (900)
(3, 10003, 'GD001', 2675), -- Combined PO003 (1800) and PO008 (875)
(4, 10004, 'GD001', 2700), -- Combined PO004 (1800) and PO009 (900)
(5, 10005, 'GD001', 4500); -- Combined PO005 (3500) and PO010 (1000)
