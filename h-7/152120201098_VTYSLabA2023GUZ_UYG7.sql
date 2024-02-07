use BikeStores


--Soru 1: Bir müşterinin tüm siparişlerini ve siparişlerin detaylarını listeleyen bir saklı yordamı yazınız.
--Yordam, müşteri kimliğini parametre olarak almalıdır. Exec komutu ile yordamı çağırınız. (15p)

Alter PROCEDURE CustomerOrdersDetailss
    @CustomerID INT
AS
BEGIN
    SELECT o.order_id, o.order_date, p.product_name, oi.quantity, oi.list_price
    FROM sales.orders o
    INNER JOIN sales.order_items oi ON o.order_id = oi.order_id
    INNER JOIN production.products p ON oi.product_id = p.product_id
    WHERE o.customer_id = @CustomerID;
END;

EXEC CustomerOrdersDetailss @CustomerID = 1;


--Soru 2: Oluşturulan saklı yordamı güncelleyerek; müşteri adı X olan kişinin en yüksek 
--siparişini getirmesini sağlayan saklı yordamı yazınız. Exec komutu ile yordamı çağırınız. (15p)

ALTER PROCEDURE CustomerOrdersDetailss
    @CustomerName NVARCHAR(100)
AS
BEGIN
    SELECT TOP 1 o.order_id, o.order_date, p.product_name, oi.quantity, oi.list_price
    FROM sales.orders o
    INNER JOIN sales.order_items oi ON o.order_id = oi.order_id
    INNER JOIN production.products p ON oi.product_id = p.product_id
    INNER JOIN sales.customers c ON o.customer_id = c.customer_id
    WHERE c.first_name = @CustomerName
    ORDER BY oi.list_price DESC;
END;


EXEC CustomerOrdersDetails @CustomerName = "Debra";


--Soru 3: Belirli bir müşteriye ait tüm siparişlerin mağazalara göre toplam değerini hesaplayan bir saklı 
--yordam yazın. Yordam, müşteri kimliğini parametre olarak almalıdır. Exec komutu ile yordamı çağırınız. (20p)

CREATE PROCEDURE TotalOrderValueByStore
    @CustomerID INT
AS
BEGIN
    SELECT s.store_id, SUM(oi.quantity * oi.list_price) AS TotalValue
    FROM sales.orders o
    INNER JOIN sales.order_items oi ON o.order_id = oi.order_id
    INNER JOIN sales.stores s ON o.store_id = s.store_id
    WHERE o.customer_id = @CustomerID
    GROUP BY s.store_id;
END;

EXEC TotalOrderValueByStore @CustomerID = 2;


--Soru 4: Ürünler (products) tablosundaki en yüksek ve en düşük fiyatlı ürünlerin detaylarını 
--(ürün adı, marka, kategori, fiyat) gösteren bir saklı yordam yazınız. Bu yordam, markalar 
--ve kategorilerle karmaşık sorguları içermelidir. Exec komutu ile yordamı çağırınız. (20p)

CREATE PROCEDURE MaxMinProductDetails
AS
BEGIN
    SELECT 'Max' AS Type, p.product_name, b.brand_name, c.category_name, MAX(p.list_price) AS Price
    FROM production.products p
    INNER JOIN production.brands b ON p.brand_id = b.brand_id
    INNER JOIN production.categories c ON p.category_id = c.category_id
    WHERE p.list_price = (SELECT MAX(list_price) FROM production.products)
    GROUP BY p.product_name, b.brand_name, c.category_name

    UNION ALL

    SELECT 'Min' AS Type, p.product_name, b.brand_name, c.category_name, MIN(p.list_price) AS Price
    FROM production.products p
    INNER JOIN production.brands b ON p.brand_id = b.brand_id
    INNER JOIN production.categories c ON p.category_id = c.category_id
    WHERE p.list_price = (SELECT MIN(list_price) FROM production.products)
    GROUP BY p.product_name, b.brand_name, c.category_name;
END;

EXEC MaxMinProductDetails;


--Soru 5: Belirli bir kategoriye ait ürünlerin sayısını ve bu ürünlerin ortalama fiyatını hesaplayan
--bir saklı yordam yazınız. Yordam, kategori ID'sini parametre olarak almalıdır. Exec komutu ile yordamı çağırınız. (20p)

CREATE PROCEDURE CategoryProductStats
    @CategoryID INT
AS
BEGIN
    SELECT COUNT(product_id) AS ProductCount, AVG(list_price) AS AvgPrice
    FROM production.products
    WHERE category_id = @CategoryID;
END;

EXEC CategoryProductStats @CategoryID = 3;


--Soru 6: Oluşturulan son saklı yordamı siliniz. (10p)

DROP PROCEDURE CategoryProductStats;

