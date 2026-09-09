# MarketLedger Data Dictionary

All records are synthetic. PostgreSQL schema definitions are authoritative.

## `branches`

- `branch_id` — INTEGER; primary key
- `branch_code` — TEXT; NOT NULL
- `branch_name` — TEXT; NOT NULL
- `city` — TEXT; NOT NULL
- `state` — TEXT; NOT NULL
- `opened_date` — date; NOT NULL
- `is_active` — INTEGER; NOT NULL, default `true`

## `employees`

- `employee_id` — INTEGER; primary key
- `branch_id` — INTEGER; NOT NULL
- `first_name` — TEXT; NOT NULL
- `last_name` — TEXT; NOT NULL
- `job_title` — TEXT; NOT NULL
- `hire_date` — date; NOT NULL
- `email` — TEXT; nullable/constraint details: see PostgreSQL schema
- `is_active` — INTEGER; NOT NULL, default `true`

## `customers`

- `customer_id` — INTEGER; primary key
- `customer_name` — TEXT; NOT NULL
- `customer_type` — TEXT; NOT NULL
- `city` — TEXT; nullable/constraint details: see PostgreSQL schema
- `state` — TEXT; nullable/constraint details: see PostgreSQL schema
- `phone` — TEXT; nullable/constraint details: see PostgreSQL schema
- `email` — TEXT; nullable/constraint details: see PostgreSQL schema
- `created_at` — TEXT; NOT NULL, default `CURRENT_TIMESTAMP`
- `is_active` — INTEGER; NOT NULL, default `true`

## `suppliers`

- `supplier_id` — INTEGER; primary key
- `supplier_name` — TEXT; NOT NULL
- `city` — TEXT; nullable/constraint details: see PostgreSQL schema
- `state` — TEXT; nullable/constraint details: see PostgreSQL schema
- `phone` — TEXT; nullable/constraint details: see PostgreSQL schema
- `email` — TEXT; nullable/constraint details: see PostgreSQL schema
- `is_active` — INTEGER; NOT NULL, default `true`

## `categories`

- `category_id` — INTEGER; primary key
- `category_name` — TEXT; NOT NULL

## `products`

- `product_id` — INTEGER; primary key
- `category_id` — INTEGER; NOT NULL
- `sku` — TEXT; NOT NULL
- `product_name` — TEXT; NOT NULL
- `unit_price` — numeric(12,2); NOT NULL
- `reorder_level` — INTEGER; NOT NULL, default `0`
- `is_active` — INTEGER; NOT NULL, default `true`

## `supplier_products`

- `supplier_id` — INTEGER; primary key, NOT NULL
- `product_id` — INTEGER; primary key, NOT NULL
- `supplier_unit_cost` — numeric(12,2); NOT NULL
- `lead_time_days` — INTEGER; nullable/constraint details: see PostgreSQL schema
- `is_preferred` — INTEGER; NOT NULL, default `false`

## `orders`

- `order_id` — INTEGER; primary key
- `order_number` — TEXT; NOT NULL
- `branch_id` — INTEGER; NOT NULL
- `customer_id` — INTEGER; nullable/constraint details: see PostgreSQL schema
- `employee_id` — INTEGER; NOT NULL
- `order_date` — date; NOT NULL
- `sales_channel` — TEXT; NOT NULL
- `order_status` — TEXT; NOT NULL
- `discount_amount` — numeric(12,2); NOT NULL, default `0`
- `notes` — TEXT; nullable/constraint details: see PostgreSQL schema

## `order_items`

- `order_item_id` — INTEGER; primary key
- `order_id` — INTEGER; NOT NULL
- `product_id` — INTEGER; NOT NULL
- `quantity` — INTEGER; NOT NULL
- `unit_price` — numeric(12,2); NOT NULL
- `discount_amount` — numeric(12,2); NOT NULL, default `0`

## `payments`

- `payment_id` — INTEGER; primary key
- `order_id` — INTEGER; NOT NULL
- `payment_date` — TEXT; NOT NULL
- `amount` — numeric(12,2); NOT NULL
- `payment_method` — TEXT; NOT NULL
- `payment_status` — TEXT; NOT NULL
- `reference_code` — TEXT; nullable/constraint details: see PostgreSQL schema

## `inventory_movements`

- `movement_id` — INTEGER; primary key
- `branch_id` — INTEGER; NOT NULL
- `product_id` — INTEGER; NOT NULL
- `movement_type` — TEXT; NOT NULL
- `quantity_change` — INTEGER; NOT NULL
- `movement_date` — TEXT; NOT NULL
- `notes` — TEXT; nullable/constraint details: see PostgreSQL schema

## `deliveries`

- `delivery_id` — INTEGER; primary key
- `order_id` — INTEGER; NOT NULL
- `dispatch_date` — date; nullable/constraint details: see PostgreSQL schema
- `delivered_at` — TEXT; nullable/constraint details: see PostgreSQL schema
- `delivery_status` — TEXT; NOT NULL
- `delivery_city` — TEXT; nullable/constraint details: see PostgreSQL schema
- `delivery_state` — TEXT; nullable/constraint details: see PostgreSQL schema
- `delivery_fee` — numeric(12,2); NOT NULL, default `0`

## `returns`

- `return_id` — INTEGER; primary key
- `order_item_id` — INTEGER; NOT NULL
- `return_date` — date; NOT NULL
- `quantity` — INTEGER; NOT NULL
- `reason` — TEXT; nullable/constraint details: see PostgreSQL schema
- `return_status` — TEXT; NOT NULL
- `refund_amount` — numeric(12,2); NOT NULL, default `0`

