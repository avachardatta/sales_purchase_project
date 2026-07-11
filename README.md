# Retail Engine Core: An Automated Supply Chain & Transaction Management System			
			
## 1. Project Overview			
			
### The Core Narrative			
This project simulates a high-concurrency **Inventory, Sales Order, and Payment Lifecycle Management System** built inside PostgreSQL. It moves beyond static data querying by enforcing transactional integrity, relational schema constraints, and business logic automation via custom PL/pgSQL Stored Procedures and Advanced Windowing Functions.			
			
### The Architecture Map			
To show how the database tables interact, look at how the constraints map out a clean, enterprise-grade relational architecture:			
			
```text			
  [Supplier Details]              [Customer Details] 			
          |                               |          			
          v (1:N)                         v (1:N)    			
    [PO Details]                  [Customer Orders] <-- [Salesman Details]			
          |                               |                      |			
          | (1:N)                         v (1:N)                | (1:N)			
          +-------------> [Item Details] <+                      |			
                                 ^                               |			
                                 | (1:1)                         v			
                         [Inventory Stocks] <------------ [Order Details]			
			
2. Project Objectives			
The core goal of this project is to transform a static relational database into an automated, self-validating business engine. The design focuses on three operational goals:			
Data Integrity & Relationship Enforcement: Build a solid relational schema using strict primary and foreign key constraints across customers, items, salesmen, suppliers, and stocks.			
Business Logic Automation (PL/pgSQL): Eliminate manual validation by shifting business rules (like multi-tier volume discounts, automated fulfillment state changes, and automated sequence generation) directly to database stored procedures.			
Enterprise-Level Reporting: Implement complex analytical matrices using subqueries, existential filters (NOT EXISTS), window rankings, and multi-dimensional aggregations (GROUPING SETS) to track real-time business health.			
			
3. Project Structure			
To maintain a clean, professional repository, the project scripts are decoupled and organized into logical files. This modular design isolates schema structural setup from procedural application logic and business reporting:			
			
├── schema/			
│   ├── 01_ddl_tables.sql         # Base tables, constraints, and data definitions			
│   └── 02_alterations_fks.sql     # Primary Keys, Foreign Keys, and schema tuning			
├── automation/			
│   ├── 01_sequences.sql          # Dedicated ID and document number sequences			
│   ├── 02_stored_procedures.sql  # Transactional engines (order creation, payments)			
│   └── 03_custom_functions.sql   # Inventory status engines & analytical summaries			
└── reporting/			
    ├── 01_basic_queries.sql      # Essential operational filtering and lookups			
    ├── 02_business_joins.sql     # Inter-table relational performance scripts			
    └── 03_advanced_analytics.sql # Subqueries, Window functions, and financial matrices			
			
4. Data Exploration & Cleaning			
			
Before deploying automation logic, data structures were audited, normalized, and refactored to support business operations:			
Column Schema Refactoring: Dropped redundant columns (od_status, co_status, etc.) from transactional tables and centralized status mutations through functional update queries.			
Data Type Tuning: Standardized pricing matrices across tables using explicit decimal precision fields (DECIMAL(10,2) / NUMERIC) instead of unconstrained numbers to prevent mathematical rounding drift during aggregation.			
Missing Reference Injections: Programmatically mapped raw legacy text product entries (e.g., 'Television', 'Home Theater') to dedicated inventory ID indices (10001, 10002) to stabilize relational performance before executing foreign key binds.			
			
5. Data Analysis & Findings			
The project's 35 analytical reporting blocks are categorized into 3 Operational Enterprise Pillars to drive strategic business insights. Click on any section below to view the exact business questions and SQL implementation scripts:			
Basic Operational Lookups			
			
Q1: Display all customers from a specific city (e.g., Mumbai).			
SELECT * FROM customer_details WHERE cust_city = 'Mumbai';			
			
Q2: List all items available in item_details.			
SELECT * FROM item_details;			
			
Q3: Fetch all orders placed by a particular customer code.			
SELECT * FROM order_details WHERE od_cust_code = 'AA001';			
			
Q4: Show all suppliers belonging to a specific state.			
SELECT * FROM supplier_details WHERE sp_state = 'Maharashtra';			
			
Q5: Display all godowns located in a given city.			
ELECT * FROM godown_details WHERE gd_godown_city = 'Mumbai';			
			
Q6: List all salesmen usernames from salesman_details.			
SELECT sd_usrname FROM salesman_details;			
			
Q7: Fetch orders where order quantity is greater than a given value.			
SELECT * FROM customer_orders WHERE co_qty > 50;			
			
Relational Business Joins			
			
Q8: Display customer name, order number, and order amount.			
SELECT c.cust_name, o.co_no, o.co_amt 			
FROM customer_orders o			
JOIN customer_details c ON o.co_cust_code = c.cust_code;			
			
Q9: Show item name along with total ordered quantity.			
SELECT id_item_name, SUM(co_qty) AS total_qty			
FROM customer_orders o			
JOIN item_details i ON o.co_item_code = i.id_item_code			
GROUP BY id_item_name;			
			
Q10: Fetch orders handled by a specific salesman.			
SELECT * FROM customer_orders WHERE co_sd_userid = 1001;			
			
Q11: Display customer name and payment details for completed payments.			
SELECT c.cust_name, p.* 			
FROM payment_details p			
JOIN customer_details c ON p.pd_cust_code = c.cust_code;			
			
Q12: List purchase orders with supplier name.			
SELECT po.*, s.sp_name 			
FROM po_details po			
JOIN supplier_details s ON po.po_sup_code = s.sp_code;			
			
Q13: Show purchase orders created by a specific user.			
SELECT * FROM po_details WHERE po_user = 'admin';			
			
Q14: Display customers who have placed at least one order.			
SELECT DISTINCT c.cust_name 			
FROM customer_details c			
JOIN customer_orders o ON c.cust_code = o.co_cust_code;			
			
Q15: Show suppliers who have never received a purchase order.			
SELECT * FROM supplier_details 			
WHERE sp_code NOT IN (SELECT po_sup_code FROM po_details);			
			
Volume & Distribution Analytics			
			
Q22: Show customers who placed more than 3 orders.			
SELECT co_cust_code, COUNT(co_no) 			
FROM customer_orders 			
GROUP BY co_cust_code HAVING COUNT(co_no) > 3;			
			
Q26: Display cities having more than 2 customers.			
SELECT cust_city, COUNT(cust_code) 			
FROM customer_details 			
GROUP BY cust_city HAVING COUNT(cust_code) > 2;			
			
Window Functions & Rankings			
Q31: Rank customers based on total sales amount.			
SELECT co_cust_code, SUM(co_amt),			
       RANK() OVER (ORDER BY SUM(co_amt) DESC) as customer_rank			
FROM customer_orders GROUP BY co_cust_code;			
			
Q32: Find the top 2 highest orders per customer.			
SELECT * FROM (			
    SELECT co_cust_code, co_no, co_amt,			
           ROW_NUMBER() OVER (PARTITION BY co_cust_code ORDER BY co_amt DESC) as rn			
    FROM customer_orders			
) t WHERE rn <= 2;			
Multi-Dimensional Aggregations			
			
Q16: Find total sales amount customer-wise.			
SELECT co_cust_code, SUM(co_amt) FROM customer_orders GROUP BY co_cust_code;			
			
Q17: Calculate total order quantity item-wise.			
SELECT od_item_code, SUM(od_units) FROM order_details GROUP BY od_item_code;			
			
Q18: Find total payment received per customer.			
SELECT pd_cust_code, SUM(pd_order_amt) FROM payment_details GROUP BY pd_cust_code;			
			
Q19: Display supplier-wise total purchase amount.			
SELECT po_sup_code, SUM(po_po_amt) FROM po_details GROUP BY po_sup_code;			
			
Q20: Find the highest order amount.			
SELECT MAX(co_amt) FROM customer_orders;			
			
Q21: Find average order value across all orders.			
SELECT AVG(co_amt) FROM customer_orders;			
			
Threshold Management (HAVING filters)			
			
Q23: Display items with total sales quantity greater than a given number.			
SELECT od_item, SUM(od_units) FROM order_details 			
GROUP BY od_item HAVING SUM(od_units) > 100;			
			
Q24: Find suppliers whose total purchase amount exceeds a limit.			
SELECT po_sup_code, SUM(po_po_amt) FROM po_details 			
GROUP BY po_sup_code HAVING SUM(po_po_amt) > 50000;			
			
Q25: Show salesmen who handled total orders above a threshold.			
SELECT co_sd_userid, SUM(co_amt) FROM customer_orders 			
GROUP BY co_sd_userid HAVING SUM(co_amt) > 100000;			
			
Structural Running Totals			
			
Q33: Show running total of payments ordered by payment date.			
SELECT pd_no, pd_payment_date, pd_order_amt,			
       SUM(pd_order_amt) OVER (ORDER BY pd_payment_date) as running_total			
FROM payment_details;			
			
Deep Business Subqueries			
Q27: Find customers who placed orders greater than the average order amount.			
SELECT co_cust_code, co_amt FROM customer_orders			
WHERE co_amt > (SELECT AVG(co_amt) FROM customer_orders);			
			
Q28: Display items that were never ordered.			
SELECT id_item_name FROM item_details			
WHERE id_item_name NOT IN (SELECT DISTINCT od_item FROM order_details WHERE od_item IS NOT NULL);			
			
Q29: Find customers who have not made any payment.			
SELECT cust_name FROM customer_details			
WHERE cust_code NOT IN (SELECT DISTINCT pd_cust_code FROM payment_details);			
			
Q30: Show suppliers whose purchase amount is greater than the average purchase amount.			
SELECT s.sp_name, SUM(p.po_po_amt) AS total_purchase_amt			
FROM po_details p			
JOIN supplier_details s ON p.po_sup_code = s.sp_code			
GROUP BY s.sp_name			
HAVING SUM(p.po_po_amt) > (			
    SELECT AVG(total_amt) FROM (			
        SELECT SUM(po_po_amt) AS total_amt FROM po_details GROUP BY po_sup_code			
    ) a			
);			
			
Advanced Business Scenarios			
			
Q34: Find pending payment amount for each customer (order amount − paid amount).			
SELECT o.od_cust_code,			
       COALESCE(SUM(o.od_sale_amt),0) - COALESCE(SUM(p.pd_order_amt),0) AS Bal_payment			
FROM order_details o			
JOIN payment_details p ON o.od_cust_code = p.pd_cust_code 			
GROUP BY o.od_cust_code;			
Q35: Identify customers who ordered but never completed payment.			
SELECT DISTINCT od_cust_code FROM order_details 			
WHERE NOT EXISTS (			
    SELECT 1 FROM payment_details WHERE pd_cust_code = od_cust_code			
);			
			
6. Strategic Business Insights			
By running analytical queries across the transactional schemas, several high-impact business realities were identified:			
Capital Risk & Exposure: The Aging Exposure Analysis revealed a significant gap between order confirmation amounts and settled financial balances. Multiple active accounts have placed consecutive volume orders without initiating a baseline transaction payment.			
Sales Optimization Channels: Sales performance tracking using programmatic grouping sets proved that revenue is heavily concentrated within specific regions (e.g., Central Region). This allows management to optimize regional marketing capital allocation.			
Procurement Triggers: The custom inventory evaluation function pinpointed specific SKU lines (e.g., Television, Home Theater) experiencing rapid sales velocities, which directly informs automated restock requests via the vendor pipeline.			
			
7. System Generated Reports			
The relational backend natively generates comprehensive operational reports without requiring external processing engines:			
Report Type	Purpose	Primary Functions / Features Used	Target Stakeholder
Sales Performance Audit	Provides multi-level corporate, individual salesperson, and SKU sales subtotals.	GROUPING SETS, COALESCE, Pl/pgSQL Functions	Sales Director
Cash Exposure Ledger	Isolates net total receivables outstanding and surfaces zero-payment accounts.	NOT EXISTS, SUM() - SUM(), Structural Inner/Left Joins	CFO / Risk Team
Fulfillment Integrity Tracker	Evaluates real-time inventory balances against active customer order volumes.	Custom stock_status Evaluation Function	Logistics Manager
			
8. Architectural Conclusion			
This project successfully proves that shifting core operational business rules directly to the database layer significantly improves transaction speed, reduces processing overhead, and guarantees strict data protection.			
By avoiding fragmented, external data tracking scripts and building an end-to-end relational model with primary keys, foreign keys, stored procedures, and analytical window functions, the system operates as a robust, production-grade enterprise engine capable of scaling alongside complex corporate requirements.			
