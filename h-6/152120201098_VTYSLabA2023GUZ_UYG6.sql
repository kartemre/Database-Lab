use BikeStores
-- 4 92 0 2 11 426

--1)Her bir yöneticinin (manager) kimliği (staff_id), adı (first_name), soyadı (last_name) ve
--yönettiği çalışanların (staff) sayısını içeren sorguyu yazınız ( 2 5 p).

SELECT m.staff_id AS ManagerID, m.first_name AS ManagerFirstName, m.last_name AS ManagerLastName,
    COUNT(s.staff_id) AS NumberOfSubStaff
FROM sales.staffs m
JOIN sales.staffs AS s ON m.staff_id = s.manager_id
GROUP BY m.staff_id, m.first_name, m.last_name
ORDER BY NumberOfSubStaff DESC;



--2)Belirli bir mağazada (stores) stokta (stocks) bulunan miktarı quantity) 26’dan fazla olan
--ürünlerin (products) isimlerini (product_name) listeleyiniz 15p). ANY kullanarak yapınız!

SELECT production.products.product_name
FROM production.products
WHERE EXISTS ( 
	SELECT 1
    FROM production.stocks
    WHERE stocks.product_id = products.product_id
    AND stocks.quantity > 26
    AND stocks.store_id = ANY (SELECT store_id FROM sales.stores)
);



--3)Belirli bir mağazada (stores) stokta (stocks) bulunan ve stok miktarı ( tam olarak
--26 olan tüm ürünlerin (products) isimlerini (product_name) listeleyiniz (15p).
--ALL kullanarak yapınız!

SELECT DISTINCT p.product_name
FROM production.products p
JOIN production.stocks s ON p.product_id = s.product_id
WHERE s.quantity = 26
AND s.store_id = ALL (SELECT store_id FROM sales.stores);



--4) Stok ta (Stocks) miktarı (quantity) tam olarak 30 olan ve aynı zamanda ürün (products) fiyatı
--(list_price) 3000 den yüksek olan en az bir ürünün (products) bulunduğu mağazaların
--(stores) isimlerini (store_name) listeleyiniz (15p) EXISTS kullanarak yapınız!

SELECT DISTINCT s.store_name
FROM sales.stores s
WHERE EXISTS (
    SELECT 1
    FROM production.stocks stok
    INNER JOIN production.products p ON stok.product_id = p.product_id
    WHERE stok.store_id = s.store_id
    AND stok.quantity = 30
    AND p.list_price > 3000
);



--5)Santa Cruz Bikes adlı mağazadan (stores) alış veriş (orders) yapan her bir şehirdeki (city)
--müşteri (customers) sayısını Müşteri ( sayısı 10 dan fazla olan
--şehirleri (city) seçiniz ve bu şehirleri ( müşteri (customers) sayısına göre azalan sırayla
--listele yiniz 15 p). HAVING kullanarak yapınız!

SELECT c.city, COUNT(c.customer_id) AS customer_count
FROM sales.customers c
INNER JOIN sales.orders o ON c.customer_id = o.customer_id
INNER JOIN sales.stores s ON o.store_id = s.store_id
WHERE s.store_name = 'Santa Cruz Bikes'
GROUP BY c.city
HAVING COUNT(c.customer_id) > 10
ORDER BY COUNT(c.customer_id) DESC;



--6) Baldwin Bikes adlı mağazadan (stores) sipariş (orders) vermeyen müşterilerin
--(customers) isimlerini (first_name) ve soyisimlerini (last_name) listeleyiniz (15p).
--EXCEPT kullanarak yapınız!

SELECT first_name, last_name
FROM sales.customers
EXCEPT
SELECT c.first_name, c.last_name
FROM sales.customers c
INNER JOIN sales.orders o ON c.customer_id = o.customer_id
INNER JOIN sales.stores s ON o.store_id = s.store_id
WHERE s.store_name = 'Baldwin Bikes';
