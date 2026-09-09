#!/usr/bin/env python3
from pathlib import Path
import csv, sqlite3
ROOT=Path(__file__).resolve().parents[1]
DATA=ROOT/'datasets/marketledger'
con=sqlite3.connect(':memory:')
con.execute('PRAGMA foreign_keys=ON')
schema=r'''
CREATE TABLE branches(branch_id INTEGER PRIMARY KEY,branch_code TEXT,branch_name TEXT,city TEXT,state TEXT,opened_date TEXT,is_active INTEGER);
CREATE TABLE employees(employee_id INTEGER PRIMARY KEY,branch_id INTEGER,first_name TEXT,last_name TEXT,job_title TEXT,hire_date TEXT,email TEXT,is_active INTEGER);
CREATE TABLE customers(customer_id INTEGER PRIMARY KEY,customer_name TEXT,customer_type TEXT,city TEXT,state TEXT,phone TEXT,email TEXT,created_at TEXT,is_active INTEGER);
CREATE TABLE suppliers(supplier_id INTEGER PRIMARY KEY,supplier_name TEXT,city TEXT,state TEXT,phone TEXT,email TEXT,is_active INTEGER);
CREATE TABLE categories(category_id INTEGER PRIMARY KEY,category_name TEXT);
CREATE TABLE products(product_id INTEGER PRIMARY KEY,category_id INTEGER,sku TEXT,product_name TEXT,unit_price NUMERIC,reorder_level INTEGER,is_active INTEGER);
CREATE TABLE supplier_products(supplier_id INTEGER,product_id INTEGER,supplier_unit_cost NUMERIC,lead_time_days INTEGER,is_preferred INTEGER);
CREATE TABLE orders(order_id INTEGER PRIMARY KEY,order_number TEXT,branch_id INTEGER,customer_id INTEGER,employee_id INTEGER,order_date TEXT,sales_channel TEXT,order_status TEXT,discount_amount NUMERIC,notes TEXT);
CREATE TABLE order_items(order_item_id INTEGER PRIMARY KEY,order_id INTEGER,product_id INTEGER,quantity INTEGER,unit_price NUMERIC,discount_amount NUMERIC);
CREATE TABLE payments(payment_id INTEGER PRIMARY KEY,order_id INTEGER,payment_date TEXT,amount NUMERIC,payment_method TEXT,payment_status TEXT,reference_code TEXT);
CREATE TABLE inventory_movements(movement_id INTEGER PRIMARY KEY,branch_id INTEGER,product_id INTEGER,movement_type TEXT,quantity_change INTEGER,movement_date TEXT,notes TEXT);
CREATE TABLE deliveries(delivery_id INTEGER PRIMARY KEY,order_id INTEGER,dispatch_date TEXT,delivered_at TEXT,delivery_status TEXT,delivery_city TEXT,delivery_state TEXT,delivery_fee NUMERIC);
CREATE TABLE returns(return_id INTEGER PRIMARY KEY,order_item_id INTEGER,return_date TEXT,quantity INTEGER,reason TEXT,return_status TEXT,refund_amount NUMERIC);
'''
con.executescript(schema)
bool_cols={'is_active','is_preferred'}
int_cols={'branch_id','employee_id','customer_id','supplier_id','category_id','product_id','order_id','order_item_id','payment_id','movement_id','delivery_id','return_id','quantity','reorder_level','lead_time_days','quantity_change'}
num_cols={'unit_price','supplier_unit_cost','discount_amount','amount','delivery_fee','refund_amount'}
for path in sorted(DATA.glob('*.csv')):
    table=path.stem
    with path.open(encoding='utf-8',newline='') as f:
        reader=csv.DictReader(f); rows=list(reader); cols=reader.fieldnames
    if not rows: continue
    vals=[]
    for r in rows:
        row=[]
        for c in cols:
            v=r[c]
            if v=='': v=None
            elif c in bool_cols: v=1 if v.lower() in ('true','1','t','yes') else 0
            elif c in int_cols: v=int(v)
            elif c in num_cols: v=float(v)
            row.append(v)
        vals.append(row)
    con.executemany(f"INSERT INTO {table} ({','.join(cols)}) VALUES ({','.join('?' for _ in cols)})",vals)
expected={'branches':6,'employees':8,'customers':10,'suppliers':4,'categories':4,'products':12,'supplier_products':12,'orders':12,'order_items':22,'payments':13,'inventory_movements':13,'deliveries':8,'returns':2}
for table,n in expected.items(): assert con.execute(f'SELECT COUNT(*) FROM {table}').fetchone()[0]==n,table
line_total=con.execute("SELECT SUM(oi.quantity*oi.unit_price-oi.discount_amount) FROM order_items oi JOIN orders o ON o.order_id=oi.order_id WHERE o.order_status='completed'").fetchone()[0]
assert round(line_total,2)==618150.00,line_total
net=con.execute("WITH lt AS (SELECT order_id,SUM(quantity*unit_price-discount_amount) line_total FROM order_items GROUP BY order_id) SELECT SUM(lt.line_total-o.discount_amount) FROM orders o JOIN lt ON lt.order_id=o.order_id WHERE o.order_status='completed'").fetchone()[0]
assert round(net,2)==614600.00,net
naive=con.execute("SELECT SUM(oi.quantity*oi.unit_price-oi.discount_amount) FROM orders o JOIN order_items oi ON oi.order_id=o.order_id JOIN payments p ON p.order_id=o.order_id WHERE o.order_status='completed' AND p.payment_status='successful'").fetchone()[0]
assert round(naive,2)==638750.00,naive
assert con.execute("SELECT COUNT(*) FROM customers c WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.customer_id=c.customer_id)").fetchone()[0]==1
assert con.execute("SELECT COUNT(*) FROM payments WHERE payment_status='failed'").fetchone()[0]==1
assert con.execute("SELECT COUNT(*) FROM deliveries WHERE delivery_status='delivered'").fetchone()[0]==6
assert round(con.execute("SELECT SUM(amount) FROM payments WHERE payment_status='successful'").fetchone()[0],2)==613800.00
print('SEMANTIC SMOKE: PASS (SQLite cross-check; not PostgreSQL runtime verification)')
print('completed_line_total=618150.00')
print('completed_net_order_value=614600.00')
print('naive_payment_join_value=638750.00')
