Dataset Creation

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    signup_date DATE,
    region VARCHAR(50),
    acquisition_channel VARCHAR(50)
);

INSERT INTO customers (signup_date, region, acquisition_channel)

SELECT
    DATE '2024-01-01' + (RANDOM() * 365)::INT AS signup_date,
    
    CASE
        WHEN RANDOM() < 0.25 THEN 'North'
        WHEN RANDOM() < 0.50 THEN 'South'
        WHEN RANDOM() < 0.75 THEN 'East'
        ELSE 'West'
    END AS region,
    
    CASE
        WHEN RANDOM() < 0.3 THEN 'Google Ads'
        WHEN RANDOM() < 0.6 THEN 'Instagram'
        WHEN RANDOM() < 0.8 THEN 'Referral'
        ELSE 'Organic'
    END AS acquisition_channel

FROM generate_series(1, 1000);


CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    category VARCHAR(50),
    brand VARCHAR(50),
    COST NUMERIC(10,2)
);

INSERT INTO products (category, brand, COST)

SELECT
    CASE
        WHEN RANDOM() < 0.2 THEN 'Electronics'
        WHEN RANDOM() < 0.4 THEN 'Clothing'
        WHEN RANDOM() < 0.6 THEN 'Home'
        WHEN RANDOM() < 0.8 THEN 'Sports'
        ELSE 'Beauty'
    END AS category,
    
    'Brand_' || (RANDOM() * 10)::INT AS brand,
    
    ROUND((RANDOM() * 500 + 50)::NUMERIC, 2) AS COST

FROM generate_series(1, 100);

CREATE TABLE sales (
    order_id SERIAL PRIMARY KEY,
    order_date DATE,
    customer_id INT REFERENCES customers(customer_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    selling_price NUMERIC(10,2),
    discount NUMERIC(5,2)
);

INSERT INTO sales (order_date, customer_id, product_id, quantity, selling_price, discount)

SELECT
    DATE '2025-01-01' + (RANDOM() * 180)::INT AS order_date,
    (RANDOM() * 999)::INT + 1 AS customer_id,
    (RANDOM() * 99)::INT + 1 AS product_id,
    (RANDOM() * 4)::INT + 1 AS quantity,
    ROUND((RANDOM() * 800 + 100)::NUMERIC, 2) AS selling_price,
    ROUND((RANDOM() * 0.3)::NUMERIC, 2) AS discount

FROM generate_series(1, 10000);

CREATE TABLE RETURNS (
    return_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES sales(order_id),
    return_date DATE,
    reason VARCHAR(100)
);

INSERT INTO RETURNS (order_id, return_date, reason)

SELECT
    order_id,
    order_date + ((RANDOM() * 10)::INT),
    
    CASE
        WHEN RANDOM() < 0.4 THEN 'Damaged'
        WHEN RANDOM() < 0.7 THEN 'Wrong Item'
        ELSE 'Not Satisfied'
    END

FROM sales
WHERE RANDOM() < 0.1;
