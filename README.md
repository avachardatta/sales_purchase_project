# Sales & Purchase Database: Order-to-Cash and Procure-to-Pay in PostgreSQL

A PostgreSQL database for a small electronics distributor in Mumbai, built so the owner can track purchases, stock, customer orders and payments in one place, and answer daily business questions with SQL.

## 1. Business problem

**Who is asking:** the owner / operations manager of an electronics distributor (TVs, home theaters, phones, desks, video games).

**Problem:** purchases, warehouse stock, customer orders and payments were tracked separately, so nobody could quickly answer "what is in stock?", "who still owes us money?" or "which salesperson and product sell most?". The owner needs one database that keeps the data consistent and answers these questions with SQL.

**Business questions the database answers:**
1. How much have we bought from each supplier, and of which items?
2. How much stock is left per item after sales?
3. Which customers have pending payments, and how much?
4. Which salespeople, items and regions bring in the most sales?
5. Which customers or items have no orders or no payments?

## 2. The two business cycles

```
Procure-to-pay:  Supplier → Purchase order → Stock in godown (warehouse)
Order-to-cash:   Customer → Order (by a salesperson) → Stock goes down → Payment
```

| Table | What it holds |
| --- | --- |
| `supplier_details` | suppliers |
| `po_details` | purchase orders to suppliers (item, qty, price, amount) |
| `item_details` | products |
| `godown_details` | warehouses |
| `inventory_stocks` | stock per item per warehouse (cannot go below 0) |
| `customer_details` | customers |
| `salesman_details` | salespeople |
| `customer_orders`, `order_details` | customer orders (qty, price, amount, region, salesperson) |
| `payment_details` | payments received against orders |
| `payment_type` | payment modes (cheque, cash, RTGS, NEFT, credit/debit note) |

Primary and foreign keys link the tables (see `automation/normalisation_steps.sql`), so an order can't point to a customer, item or salesperson that doesn't exist.

## 3. How I worked (7 steps)

1. **Define:** listed the business questions above.
2. **Collect:** designed the tables and loaded sample data for 2018 (5 items, 10 purchase orders, 10 salespeople).
3. **Clean and model:** added primary and foreign keys, removed a duplicated column (customer name in orders), fixed date formats.
4. **Explore:** basic SELECT / WHERE checks per table.
5. **Analyze:** JOINs, GROUP BY / HAVING, subqueries, NOT EXISTS, window functions (RANK, ROW_NUMBER, running totals), GROUPING SETS.
6. **Automate:** stored procedures and functions for daily operations (below).
7. **Communicate:** this README.

## 4. Automation (PL/pgSQL)

| Object | What it does | File |
| --- | --- | --- |
| `create_order` | creates a customer order with a new order number and a volume discount (5% / 10% / 15% by quantity) | `automation/order_management.sql` |
| `create_order_for_central_region` | creates an order for the Central region | `automation/stored_procedures.sql` |
| `update_customer_payment` | records a payment against an order with a new payment number | `automation/payment_management.sql` |
| `stock_status(item)` | stock left = stock received − units sold | `automation/inventory_management.sql` |
| `total_sales_per_salesperson(id)` | sales per salesperson and product with subtotals and a grand total (GROUPING SETS) | `reporting/analytics_functions.sql` |

## 5. What the sample data shows

From the 10 purchase orders in `schema/po_details.sql`:

| Item | Units bought | Purchase amount |
| --- | --- | --- |
| Television | 2,800 | 28,00,000 |
| Home Theater | 2,400 | 8,40,000 |
| Cell Phone | 2,675 | 4,68,125 |
| Desk | 2,700 | 2,70,000 |
| Video Games | 4,500 | 2,02,500 |
| **Total** | **15,075** | **45,80,625** |

- **Televisions are 61% of purchase spend** (28.0 lakh of 45.8 lakh) but only 19% of units. Most cash is tied up in one item, so TV stock should be watched most closely.
- **Video Games are the most units (4,500) but only 4% of spend**: cheap, high-volume stock.

These are sample figures to test the design, not real company results.

## 6. Recommendations (how the owner would use it)

| Use | Query / object |
| --- | --- |
| Weekly "who owes us" list, chase the largest balances first | pending balance query in `reporting/business_scenarios.sql` |
| Re-order alert when an item's stock drops below a set level | `stock_status(item)` |
| Monthly salesperson and product review | `total_sales_per_salesperson(id)`, RANK queries |
| Track high-value stock (TVs = 61% of purchase spend) more often | purchase and stock queries |

## 7. Files

```
schema/       # CREATE TABLE + sample INSERTs, one file per table
automation/   # keys and constraints, stored procedures, functions
reporting/    # analysis queries: joins, aggregates, GROUP BY/HAVING, subqueries, window functions, business scenarios
```

**Run order:** `schema/` files (item, godown, supplier, salesman, customer first; then orders, payments, purchase orders, inventory) → `automation/normalisation_steps.sql` → other `automation/` files → `reporting/`.

## 8. What I fixed and what's next

- **Fixed a wrong pending-payment query.** Joining raw orders to raw payments on customer repeated each order once per payment and inflated the balance. The query now totals orders and payments separately, then joins them.
- **Known issue:** the discount rule in `create_order` gives 0% for quantities 101–149 (gap between the 5% and 10% bands); the intended bands need confirming.
- **In progress:** `Order_Validation` (block an order when stock is too low) is not finished yet.
- **Next:** load a larger realistic dataset, then add monthly sales trend, customer payment delay (days to pay) and stock turnover.

**Tools:** PostgreSQL, PL/pgSQL, pgAdmin.
