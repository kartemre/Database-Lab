USE BikeStores

-- Soru 1:
-- �r�nler tablosundan kategori kimli�i (category_id) 3 olan t�m �r�nlerin ad�n� ve liste fiyat�n� listelemek i�in bir SQL SELECT sorgusu yaz�n�z.

SELECT product_name, list_price
FROM production.products
WHERE category_id = 3;

--Soru 2:
--M��teriler tablosundaki t�m benzersiz �ehirleri, eyaleti 'California' olan m��terileri listeyiniz.

SELECT DISTINCT city
FROM sales.customers
WHERE state = 'CA';

--Soru 3:
--M��teriler aras�nda California (CA) eyaletinde oturan ama �Los Angeles� ve �Campbell� �ehirlerinde oturmayan t�m m��terilerin �ad�, soyad�, telefon numaras�, �ehri ve eyaletini listeleyiniz.

SELECT first_name, last_name, phone, city, state
FROM sales.customers
WHERE state = 'CA' AND city NOT IN ('Los Angeles', 'Campbell');

--Soru 4:
--M��teriler tablosuna yeni bir m��teri ekleyin. M��terinin ad� 'John Doe', e-posta adresi 'john.doe@email.com' ancak telefon numaras� ve adres bilgilerini tabloya ekleyiniz.

INSERT INTO sales.customers (first_name, last_name ,email)
VALUES ('John', 'Doe', 'john.doe@email.com');

SELECT * FROM sales.customers 
WHERE first_name = 'John' and last_name = 'Doe'

--Soru 5:
--a) M��teriler tablosuna eklenen m��teri ad� 'John Doe' olan ki�inin telefon numaras�n� '559-329-7915� olarak g�ncelleyiniz.

UPDATE sales.customers
SET phone = '559-329-7915'
WHERE first_name = 'John' AND last_name = 'Doe';

SELECT * FROM sales.customers 
WHERE first_name = 'John' and last_name = 'Doe'

--b) M��teri numaras� 1446 olan m��terinin baz� bilgileri eksik ya da yanl�� girilmi�, bu m��teri kayd�n�z siliniz ve John Doe isimli ki�inin bilgilerini SELECT sorgusu ile �ekiniz.

DELETE FROM sales.customers
WHERE customer_id = 1446;

SELECT *
FROM sales.customers
WHERE first_name = 'John' AND last_name�=�'Doe';