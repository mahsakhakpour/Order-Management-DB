CREATE DATABASE cus_orders;
GO
USE cus_orders;
GO

CREATE TABLE titles (
    title_id CHAR(3) PRIMARY KEY,
    description VARCHAR(35) NOT NULL
);

CREATE TABLE customers (
    customer_id CHAR(5) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    contact_name VARCHAR(30),
    title_id CHAR(3),
    address VARCHAR(50),
    city VARCHAR(20),
    region VARCHAR(15),
    country VARCHAR(15) DEFAULT 'Canada',
    phone VARCHAR(20),
    fax VARCHAR(20),
    active BIT DEFAULT 1,
    CONSTRAINT fk_customer_title FOREIGN KEY (title_id) REFERENCES titles(title_id)
);

CREATE TABLE suppliers (
    supplier_id INT IDENTITY PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    address VARCHAR(30),
    city VARCHAR(20),
    province CHAR(2) DEFAULT 'BC'
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    supplier_id INT NOT NULL,
    name VARCHAR(40) NOT NULL,
    unit_price DECIMAL(10,2),
    quantity_in_stock INT CHECK (quantity_in_stock <= 150),
    reorder_level INT CHECK (reorder_level >= 1),
    CONSTRAINT fk_products_suppliers FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

CREATE TABLE shippers (
    shipper_id INT IDENTITY PRIMARY KEY,
    name VARCHAR(20) NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id CHAR(5) NOT NULL,
    employee_id INT NOT NULL,
    shipper_id INT NOT NULL,
    order_date DATE,
    required_date DATE DEFAULT DATEADD(DAY, 10, GETDATE()),
    shipped_date DATE,
    CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_orders_shippers FOREIGN KEY (shipper_id) REFERENCES shippers(shipper_id)
);

CREATE TABLE order_details (
    order_id INT,
    product_id INT,
    quantity INT CHECK (quantity >= 1),
    CONSTRAINT pk_order_details PRIMARY KEY (order_id, product_id),
    CONSTRAINT fk_od_orders FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT fk_od_products FOREIGN KEY (product_id) REFERENCES products(product_id)
);