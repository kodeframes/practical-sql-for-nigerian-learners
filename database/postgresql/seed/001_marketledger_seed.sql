BEGIN;

INSERT INTO branches (branch_id, branch_code, branch_name, city, state, opened_date, is_active) VALUES
(1,'LOS-IKE','Ikeja Branch','Lagos','Lagos','2018-03-01',true),
(2,'ABJ-WUS','Wuse Branch','Abuja','FCT','2019-07-15',true),
(3,'IBA-DUG','Dugbe Branch','Ibadan','Oyo','2020-01-20',true),
(4,'ENU-NKW','New Haven Branch','Enugu','Enugu','2021-11-04',true),
(5,'KAN-CEN','Kano Central','Kano','Kano','2022-05-10',true),
(6,'PHC-GRA','Port Harcourt GRA','Port Harcourt','Rivers','2023-02-14',true);

INSERT INTO employees (employee_id, branch_id, first_name, last_name, job_title, hire_date, email, is_active) VALUES
(1,1,'Adaeze','Okafor','Sales Officer','2021-02-01','adaeze.okafor@example.invalid',true),
(2,1,'Tunde','Bakare','Branch Supervisor','2019-06-17','tunde.bakare@example.invalid',true),
(3,2,'Amina','Yusuf','Sales Officer','2022-03-14','amina.yusuf@example.invalid',true),
(4,3,'Kunle','Adebayo','Sales Officer','2020-09-07','kunle.adebayo@example.invalid',true),
(5,4,'Chiamaka','Eze','Sales Officer','2023-01-09','chiamaka.eze@example.invalid',true),
(6,5,'Bashir','Lawal','Branch Supervisor','2022-08-22','bashir.lawal@example.invalid',true),
(7,6,'Ibiye','George','Sales Officer','2024-02-05',NULL,true),
(8,2,'Mariam','Bello','Accounts Officer','2021-11-15','mariam.bello@example.invalid',false);

INSERT INTO customers (customer_id, customer_name, customer_type, city, state, phone, email, created_at, is_active) VALUES
(1,'Ngozi Adeyemi','individual','Lagos','Lagos',NULL,'ngozi.adeyemi@example.invalid','2025-01-05 10:00+01',true),
(2,'Bashir Lawal','individual','Abuja','FCT','08000000002',NULL,'2025-01-07 11:00+01',true),
(3,'Cedar Works Ltd','business','Ibadan','Oyo','08000000003','accounts@cedar.invalid','2025-01-10 09:15+01',true),
(4,'Chiamaka Eze','individual','Enugu','Enugu','08000000004','chiamaka.eze.customer@example.invalid','2025-01-12 16:20+01',true),
(5,'Northline Traders','business','Kano','Kano',NULL,'finance@northline.invalid','2025-01-15 12:00+01',true),
(6,'Ifeoma Nwosu','individual','Port Harcourt','Rivers','08000000006',NULL,'2025-01-18 14:00+01',true),
(7,'Tunde Bello','individual','Lagos','Lagos','08000000007','tunde.bello@example.invalid','2025-01-20 08:30+01',true),
(8,'Greenfield School','business','Abuja','FCT','08000000008','bursary@greenfield.invalid','2025-01-22 09:00+01',true),
(9,'Aisha Musa','individual','Kano','Kano',NULL,NULL,'2025-01-25 15:00+01',true),
(10,'Dormant Example Customer','individual','Ibadan','Oyo',NULL,NULL,'2024-11-01 10:00+01',false);

INSERT INTO suppliers (supplier_id, supplier_name, city, state, phone, email, is_active) VALUES
(1,'Savannah Foods Supply','Kano','Kano',NULL,'orders@savannah.invalid',true),
(2,'Atlantic Office Products','Lagos','Lagos','08000000102','sales@atlantic.invalid',true),
(3,'Eastern Home Goods','Enugu','Enugu',NULL,NULL,true),
(4,'Delta Electricals','Port Harcourt','Rivers','08000000104','trade@delta.invalid',true);

INSERT INTO categories (category_id, category_name) VALUES
(1,'Groceries'),(2,'Office'),(3,'Electricals'),(4,'Household');

INSERT INTO products (product_id, category_id, sku, product_name, unit_price, reorder_level, is_active) VALUES
(1,1,'GRC-RICE-05','Rice 5kg Bag',8500.00,20,true),
(2,1,'GRC-OIL-02','Vegetable Oil 2L',4200.00,15,true),
(3,1,'GRC-SUG-01','Refined Sugar 1kg',950.00,25,true),
(4,2,'OFF-CHR-01','Office Chair',35000.00,5,true),
(5,2,'OFF-PPR-A4','A4 Paper Ream',7800.00,20,true),
(6,3,'ELC-BLB-09','LED Bulb 9W',1200.00,30,true),
(7,3,'ELC-EXT-04','Extension Socket 4-Way',3100.00,12,true),
(8,4,'HOU-DET-05','Laundry Detergent 5kg',6900.00,10,true),
(9,4,'HOU-BKT-20','Plastic Bucket 20L',2800.00,15,true),
(10,2,'OFF-USB-64','USB Flash Drive 64GB',4500.00,8,true),
(11,3,'ELC-FAN-16','Standing Fan 16in',24500.00,6,true),
(12,4,'HOU-OLD-01','Legacy Storage Box',5400.00,3,false);

INSERT INTO supplier_products (supplier_id, product_id, supplier_unit_cost, lead_time_days, is_preferred) VALUES
(1,1,7200.00,4,true),(1,2,3500.00,5,true),(1,3,760.00,4,true),
(2,4,29000.00,7,true),(2,5,6200.00,5,true),(2,10,3600.00,6,true),
(3,8,5400.00,6,true),(3,9,2100.00,7,true),(3,12,4100.00,8,false),
(4,6,850.00,5,true),(4,7,2400.00,5,true),(4,11,19500.00,9,true);

INSERT INTO orders (order_id, order_number, branch_id, customer_id, employee_id, order_date, sales_channel, order_status, discount_amount, notes) VALUES
(1,'ML-2026-0001',1,1,1,'2026-01-05','web','completed',500.00,NULL),
(2,'ML-2026-0002',1,NULL,2,'2026-01-06','walk_in','completed',0.00,'Anonymous walk-in'),
(3,'ML-2026-0003',2,2,3,'2026-01-08','phone','completed',0.00,NULL),
(4,'ML-2026-0004',3,3,4,'2026-01-12','business','completed',1000.00,NULL),
(5,'ML-2026-0005',4,4,5,'2026-01-15','web','cancelled',0.00,NULL),
(6,'ML-2026-0006',5,5,6,'2026-01-18','business','completed',250.00,NULL),
(7,'ML-2026-0007',6,6,7,'2026-02-02','web','pending',0.00,NULL),
(8,'ML-2026-0008',1,7,1,'2026-02-05','phone','completed',0.00,NULL),
(9,'ML-2026-0009',2,8,3,'2026-02-10','business','completed',1500.00,'School supply order'),
(10,'ML-2026-0010',5,9,6,'2026-02-14','walk_in','completed',0.00,NULL),
(11,'ML-2026-0011',3,1,4,'2026-03-01','web','completed',0.00,NULL),
(12,'ML-2026-0012',6,6,7,'2026-03-03','web','completed',300.00,NULL);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount_amount) VALUES
(1,1,1,2,8300.00,0.00),(2,1,2,1,4200.00,200.00),
(3,2,6,4,1200.00,0.00),(4,2,7,1,3100.00,0.00),
(5,3,4,1,35000.00,0.00),(6,3,5,2,7800.00,600.00),
(7,4,5,10,7600.00,1000.00),(8,4,10,5,4400.00,0.00),
(9,5,8,1,6900.00,0.00),
(10,6,1,5,8200.00,500.00),(11,6,3,10,900.00,0.00),
(12,7,11,1,24500.00,0.00),
(13,8,10,2,4500.00,0.00),(14,8,7,2,3000.00,0.00),
(15,9,4,4,34000.00,2000.00),(16,9,5,20,7500.00,2500.00),
(17,10,2,2,4100.00,0.00),(18,10,3,5,950.00,0.00),
(19,11,8,3,6800.00,300.00),(20,11,9,2,2800.00,0.00),
(21,12,11,2,24000.00,1000.00),(22,12,6,10,1100.00,0.00);

INSERT INTO payments (payment_id, order_id, payment_date, amount, payment_method, payment_status, reference_code) VALUES
(1,1,'2026-01-05 12:10+01',15000.00,'transfer','successful','TRX-0001'),
(2,1,'2026-01-05 12:12+01',4800.00,'card','successful','CARD-0001'),
(3,2,'2026-01-06 16:00+01',7900.00,'cash','successful',NULL),
(4,3,'2026-01-08 10:05+01',50000.00,'transfer','successful','TRX-0003'),
(5,3,'2026-01-08 10:02+01',1200.00,'card','failed','CARD-FAIL-1'),
(6,4,'2026-01-13 09:00+01',96000.00,'transfer','successful','TRX-0004'),
(7,6,'2026-01-18 13:00+01',48750.00,'transfer','successful','TRX-0006'),
(8,7,'2026-02-02 14:00+01',24500.00,'card','pending','CARD-PEND-1'),
(9,8,'2026-02-05 12:30+01',15000.00,'pos','successful','POS-0008'),
(10,9,'2026-02-11 09:30+01',280000.00,'transfer','successful','TRX-0009'),
(11,10,'2026-02-14 11:00+01',12950.00,'cash','successful',NULL),
(12,11,'2026-03-01 17:00+01',25700.00,'transfer','successful','TRX-0011'),
(13,12,'2026-03-03 15:00+01',57700.00,'pos','successful','POS-0012');

INSERT INTO inventory_movements (movement_id, branch_id, product_id, movement_type, quantity_change, movement_date, notes) VALUES
(1,1,1,'opening',50,'2026-01-01 08:00+01',NULL),(2,1,1,'sale',-2,'2026-01-05 12:00+01',NULL),
(3,1,6,'opening',40,'2026-01-01 08:00+01',NULL),(4,1,6,'sale',-4,'2026-01-06 16:00+01',NULL),
(5,2,4,'opening',10,'2026-01-01 08:00+01',NULL),(6,2,4,'sale',-1,'2026-01-08 10:00+01',NULL),
(7,3,5,'opening',60,'2026-01-01 08:00+01',NULL),(8,3,5,'sale',-10,'2026-01-12 10:00+01',NULL),
(9,5,1,'opening',30,'2026-01-01 08:00+01',NULL),(10,5,1,'sale',-5,'2026-01-18 12:00+01',NULL),
(11,6,11,'opening',8,'2026-01-01 08:00+01',NULL),(12,6,11,'sale',-2,'2026-03-03 14:00+01',NULL),
(13,6,11,'return_in',1,'2026-03-06 10:00+01','Customer return received');

INSERT INTO deliveries (delivery_id, order_id, dispatch_date, delivered_at, delivery_status, delivery_city, delivery_state, delivery_fee) VALUES
(1,1,'2026-01-06','2026-01-07 15:30+01','delivered','Lagos','Lagos',1500.00),
(2,3,'2026-01-09','2026-01-11 10:00+01','delivered','Abuja','FCT',1200.00),
(3,4,'2026-01-13','2026-01-16 17:45+01','delivered','Ibadan','Oyo',2500.00),
(4,6,'2026-01-19','2026-01-21 13:00+01','delivered','Kano','Kano',1800.00),
(5,7,'2026-02-03',NULL,'failed','Port Harcourt','Rivers',2000.00),
(6,9,'2026-02-11','2026-02-13 12:00+01','delivered','Abuja','FCT',3000.00),
(7,11,'2026-03-02',NULL,'dispatched','Lagos','Lagos',1800.00),
(8,12,'2026-03-04','2026-03-05 18:20+01','delivered','Port Harcourt','Rivers',2200.00);

INSERT INTO returns (return_id, order_item_id, return_date, quantity, reason, return_status, refund_amount) VALUES
(1,22,'2026-03-06',1,'One bulb damaged on arrival','completed',1100.00),
(2,16,'2026-02-18',2,'Unopened surplus paper','approved',15000.00);

SELECT setval(pg_get_serial_sequence('branches','branch_id'), (SELECT max(branch_id) FROM branches));
SELECT setval(pg_get_serial_sequence('employees','employee_id'), (SELECT max(employee_id) FROM employees));
SELECT setval(pg_get_serial_sequence('customers','customer_id'), (SELECT max(customer_id) FROM customers));
SELECT setval(pg_get_serial_sequence('suppliers','supplier_id'), (SELECT max(supplier_id) FROM suppliers));
SELECT setval(pg_get_serial_sequence('categories','category_id'), (SELECT max(category_id) FROM categories));
SELECT setval(pg_get_serial_sequence('products','product_id'), (SELECT max(product_id) FROM products));
SELECT setval(pg_get_serial_sequence('orders','order_id'), (SELECT max(order_id) FROM orders));
SELECT setval(pg_get_serial_sequence('order_items','order_item_id'), (SELECT max(order_item_id) FROM order_items));
SELECT setval(pg_get_serial_sequence('payments','payment_id'), (SELECT max(payment_id) FROM payments));
SELECT setval(pg_get_serial_sequence('inventory_movements','movement_id'), (SELECT max(movement_id) FROM inventory_movements));
SELECT setval(pg_get_serial_sequence('deliveries','delivery_id'), (SELECT max(delivery_id) FROM deliveries));
SELECT setval(pg_get_serial_sequence('returns','return_id'), (SELECT max(return_id) FROM returns));

COMMIT;
