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
DELETE FROM sales.customers
WHERE customer_id = 1

-- Soru 2: Bir sipariş kalemi eklenirken ilgili ürünün stok miktarının otomatik olarak azaltılmasını
-- sağlayarak sipariş işlemi gerçekleştiğinde stok seviyelerini gerçek zamanlı olarak güncelleyen
-- tetikleyici kodunu yazınız (20p). İlgili tetikleyici kodunu test eden SQL sorgularını yazınız.

CREATE TRIGGER trg21
ON sales.order_items
AFTER INSERT
AS
BEGIN
    UPDATE production.stocks
    SET quantity = quantity - (SELECT quantity FROM INSERTED)
    WHERE product_id IN (SELECT product_id FROM INSERTED)
END

--Code to test the trigger 
INSERT INTO sales.order_items (order_id, item_id, product_id, quantity, list_price, discount)


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
DELETE FROM production.products
WHERE product_id = 1

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
INSERT INTO production.products (product_name, brand_id, category_id, model_year, list_price)

-- Soru 5: Bir kategori silindiğinde, silinen kategoriye ait ürünlerin kategori bilgilerini NULL
-- olarak güncelleyen tetikleyici kodunu yazınız (20p). İlgili tetikleyici kodunu test eden SQL
-- sorgularını yazınız.

CREATE TRIGGER trg51
ON production.categories
AFTER DELETE
AS
BEGIN
    UPDATE production.products
    SET category_id = NULL
    WHERE category_id IN (SELECT category_id FROM DELETED)
END

--Code to test the trigger
DELETE FROM production.categories
WHERE category_id = 1