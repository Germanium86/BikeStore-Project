-- Query to generate sales information
SELECT
	o.order_id,
	o.order_date,
	TRIM(CONCAT(c.first_name, ' ', c.last_name)) as customer_name,
	c.state AS state,
	s.store_name,
	p.product_name,
	oi.discount,
	oi.list_price,
	oi.quantity,
	cat.category_name,
	TRIM(CONCAT(sta.first_name, ' ', sta.last_name)) AS 'sales_rep',
	(SUM(oi.quantity * oi.list_price) - (oi.discount * (oi.quantity * oi.list_price))) AS revenue
FROM sales.orders AS o
JOIN sales.customers AS c
ON o.customer_id = c.customer_id
JOIN sales.stores AS s
ON o.store_id = s.store_id
JOIN sales.order_items as oi
ON o.order_id = oi.order_id
JOIN production.products AS p
ON oi.product_id = p.product_id
JOIN production.categories AS cat
ON p.category_id = cat.category_id
JOIN sales.staffs AS sta
ON o.staff_id = sta.staff_id
GROUP BY
	o.order_id,
	o.order_date,
	TRIM(CONCAT(c.first_name, ' ', c.last_name)),
	c.state,
	s.store_name,
	p.product_name,
	oi.discount,
	oi.list_price,
	oi.quantity,
	cat.category_name,
	TRIM(CONCAT(sta.first_name, ' ', sta.last_name));