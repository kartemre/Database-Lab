-- Soru 1: Bir müşteri silindiğinde bu müşteriye ait tüm siparişlerin otomatik olarak silinmesini
-- sağlayan tetikleyici kodunu yazınız (20p). İlgili tetikleyici kodunu test eden SQL sorgularını
-- yazınız.

CREATE TRIGGER trg1
ON sales.customers
AFTER DELETE
AS
BEGIN
    DELETE FROM sales.orders
    WHERE customer_id IN (SELECT customer_id FROM DELETED)
END

--Code to test the trigger
INSERT INTO sales.customers (first_name, last_name, email) VALUES ('emre', 'kart', 'emr123@gmail.com');

INSERT INTO sales.orders (customer_id, order_status, order_date, required_date, store_id, staff_id)
VALUES ((SELECT customer_id FROM sales.customers WHERE first_name = 'emre' AND last_name = 'kart'), 1, GETDATE(), GETDATE(), 1, 1);

DELETE FROM sales.customers WHERE first_name = 'emre' AND last_name = 'kart';

SELECT * FROM sales.customers WHERE first_name = 'emre';

SELECT * FROM sales.orders WHERE customer_id = 1452;

DELETE FROM sales.customers WHERE customer_id = 1












-- Soru 2: Bir sipariş kalemi eklenirken ilgili ürünün stok miktarının otomatik olarak azaltılmasını
-- sağlayarak sipariş işlemi gerçekleştiğinde stok seviyelerini gerçek zamanlı olarak güncelleyen
-- tetikleyici kodunu yazınız (20p). İlgili tetikleyici kodunu test eden SQL sorgularını yazınız.

CREATE TRIGGER trg2
ON sales.order_items
AFTER INSERT
AS
BEGIN
    UPDATE production.stocks
    SET quantity = quantity - (SELECT quantity FROM INSERTED)
    WHERE product_id IN (SELECT product_id FROM INSERTED)
END

--Code to test the trigger 
SELECT * FROM production.stocks;

INSERT INTO sales.order_items (order_id, item_id, product_id, quantity, list_price, discount)
VALUES (1, 1, 1, 5, 10.00, 0.00);

















-- Soru 3: Bir ürün silindiğinde bu ürüne ait stok bilgilerinin de otomatik olarak silinmesini
-- sağlayan tetikleyici kodunu yazınız (20p). İlgili tetikleyici kodunu test eden SQL sorgularını
-- yazınız.

CREATE TRIGGER trg3
ON production.products
AFTER DELETE
AS
BEGIN
    DELETE FROM production.stocks
    WHERE product_id IN (SELECT product_id FROM DELETED)
END

--Code to test the trigger
SELECT * FROM production.stocks;

DELETE FROM production.products WHERE product_id = 2;
SELECT * FROM production.stocks WHERE product_id = 2;














-- Soru 4: Yeni bir ürün eklediğinizde tüm mağazalarda stok kaydı oluşturan tetikleyici kodunu
-- yazınız (20p). İlgili tetikleyici kodunu test eden SQL sorgularını yazınız.

CREATE TRIGGER trg4
ON production.products
AFTER INSERT
AS
BEGIN
    INSERT INTO production.stocks (store_id, product_id, quantity)
    SELECT store_id, product_id, 0
    FROM sales.stores, inserted
END


--Code to test the trigger
INSERT INTO production.products (product_name, brand_id, category_id, model_year, list_price) VALUES ('New Product 2', 2, 2, 2018, 500);

SELECT * FROM production.stocks WHERE product_id = (SELECT MAX(product_id) FROM production.products);














-- Soru 5: Bir kategori silindiğinde, silinen kategoriye ait ürünlerin kategori bilgilerini NULL
-- olarak güncelleyen tetikleyici kodunu yazınız (20p). İlgili tetikleyici kodunu test eden SQL
-- sorgularını yazınız.

CREATE TRIGGER trg5
ON production.categories
AFTER DELETE
AS
BEGIN
    UPDATE production.products
    SET category_id = NULL
    WHERE category_id IN (SELECT category_id FROM DELETED)
END

--Code to test the trigger

DELETE FROM production.categories WHERE category_id = 1;

SELECT * FROM production.products WHERE category_id = 1;

INSERT INTO production.categories (category_name) VALUES ( 'Kategori 1');
SELECT * FROM production.categories WHERE category_name = 'Katagori 1'; 

INSERT INTO production.products (product_name, category_id) VALUES ('Ürün 3', 1);
SELECT * FROM production.products WHERE category_id = 1;

