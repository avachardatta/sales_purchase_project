select * from customer_orders

alter table customer_orders 
drop column co_cust_name



-- 1. customer_details
ALTER TABLE customer_details ADD PRIMARY KEY (cust_code);

-- 2. Items
ALTER TABLE item_details ADD PRIMARY KEY (id_item_code);

-- 3. Salesmen
ALTER TABLE salesman_details ADD PRIMARY KEY (sd_userid);

-- 4. Suppliers
ALTER TABLE supplier_details ADD PRIMARY KEY (sp_code);

-- 5. Godowns
ALTER TABLE godown_details ADD PRIMARY KEY (gd_godown_code);





ALTER TABLE customer_orders 
ADD CONSTRAINT fk_co_customer 
FOREIGN KEY (co_cust_code) REFERENCES customer_details(cust_code);

-- Link Orders to Salesmen
ALTER TABLE customer_orders 
ADD CONSTRAINT fk_co_salesman 
FOREIGN KEY (co_sd_userid) REFERENCES salesman_details(sd_userid);

-- Link Purchase Orders to Items
ALTER TABLE po_details 
ADD CONSTRAINT fk_po_item 
FOREIGN KEY (po_po_item_code) REFERENCES item_details(id_item_code);

-- Link Purchase Orders to Suppliers
ALTER TABLE po_details 
ADD CONSTRAINT fk_po_supplier 
FOREIGN KEY (po_sup_code) REFERENCES supplier_details(sp_code);
