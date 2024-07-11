-- SORU 7 --
SELECT CT.CITY, COUNT(C.ID) AS CUSTOMERCOUNT
FROM CUSTOMERS C
INNER JOIN CITIES CT ON C.CITYID=CT.ID


SELECT CT.CITY, COUNT(C.ID) AS CUSTOMERCOUNT
FROM CUSTOMERS C
INNER JOIN CITIES CT ON C.CITYID=CT.ID
GROUP BY CT.CITY
ORDER BY CUSTOMERCOUNT


SELECT *,
	(SELECT COUNT(*) FROM CUSTOMERS C WHERE C.CITYID=CT.ID) AS CUSTOMERCOUNT
FROM CITIES CT
ORDER BY CUSTOMERCOUNT

SELECT CT.CITY, COUNT(C.ID) AS CUSTOMERCOUNT
FROM CUSTOMERS C
LEFT JOIN CITIES CT ON C.CITYID=CT.ID
GROUP BY CT.CITY
ORDER BY CUSTOMERCOUNT

SELECT CT.CITY, COUNT(C.ID) AS CUSTOMERCOUNT
FROM CUSTOMERS C
RIGHT JOIN CITIES CT ON C.CITYID=CT.ID
GROUP BY CT.CITY
ORDER BY CUSTOMERCOUNT

-- SORU 8 --
SELECT CT.CITY, COUNT(C.ID) AS CUSTOMERCOUNT
FROM CUSTOMERS C
INNER JOIN CITIES CT ON C.CITYID=CT.ID
GROUP BY CT.CITY
HAVING CUSTOMERCOUNT>10
ORDER BY CUSTOMERCOUNT DESC


SELECT CT.CITY, COUNT(C.ID) AS CUSTOMERCOUNT
FROM CUSTOMERS C
INNER JOIN CITIES CT ON C.CITYID=CT.ID
GROUP BY CT.CITY
HAVING COUNT(C.ID)>10
ORDER BY CUSTOMERCOUNT DESC

SELECT *,
(SELECT COUNT(*) FROM CUSTOMERS WHERE CITYID=C.ID) AS COUNTCUSTOMERS
FROM CITIES C
WHERE (SELECT COUNT(*) FROM CUSTOMERS WHERE CITYID=C.ID)>10
ORDER BY COUNTCUSTOMERS


SELECT *,
(SELECT COUNT(*) FROM CUSTOMERS WHERE CITYID=C.ID) AS COUNTCUSTOMERS
FROM CITIES C
WHERE (SELECT COUNT(*) FROM CUSTOMERS WHERE CITYID=C.ID)>10
ORDER BY 1 DESC

SELECT *,
(SELECT COUNT(*) FROM CUSTOMERS WHERE CITYID=C.ID) AS COUNTCUSTOMERS
FROM CITIES C
WHERE (SELECT COUNT(*) FROM CUSTOMERS WHERE CITYID=C.ID)>10
ORDER BY 2 DESC

SELECT *,
(SELECT COUNT(*) FROM CUSTOMERS WHERE CITYID=C.ID) AS COUNTCUSTOMERS
FROM CITIES C
WHERE (SELECT COUNT(*) FROM CUSTOMERS WHERE CITYID=C.ID)>10
ORDER BY 3 ASC


-- SORU 9 --
SELECT CT.CITY, C.GENDER, COUNT(C.ID) AS GENDERCOUNT
FROM CUSTOMERS C
INNER JOIN CITIES CT ON C.CITYID=CT.ID
GROUP BY CT.CITY, C.GENDER
ORDER BY CT.CITY, C.GENDER

-- SORU 10 --
SELECT CT.CITY, 
(SELECT COUNT(*) FROM CUSTOMERS C WHERE C.CITYID=CT.ID) AS CGENDER,
(SELECT COUNT(C.ID) FROM CUSTOMERS C WHERE C.CITYID=CT.ID
AND C.GENDER='E') AS CMEN,
(SELECT COUNT(C.ID) FROM CUSTOMERS C WHERE C.CITYID=CT.ID
AND C.GENDER='K') AS CWOMEN
FROM CITIES CT
ORDER BY CT.CITY

-- SORU 11 --
ALTER TABLE CUSTOMERS ADD AGEGROUP VARCHAR(50)

-- SORU 12 --
SELECT DATEDIFF(YEAR,BIRTHDATE,GETDATE()) AS YAS
FROM CUSTOMERS

UPDATE CUSTOMERS SET AGEGROUP='20-35 YAS'
WHERE DATEDIFF(YEAR,BIRTHDATE,GETDATE()) BETWEEN 20 AND 35

UPDATE CUSTOMERS SET AGEGROUP='36-45 YAS'
WHERE DATEDIFF(YEAR,BIRTHDATE,GETDATE()) BETWEEN 36 AND 45

UPDATE CUSTOMERS SET AGEGROUP='46-55 YAS'
WHERE DATEDIFF(YEAR,BIRTHDATE,GETDATE()) BETWEEN 46 AND 55

UPDATE CUSTOMERS SET AGEGROUP='55-65 YAS'
WHERE DATEDIFF(YEAR,BIRTHDATE,GETDATE()) BETWEEN 55 AND 65

UPDATE CUSTOMERS SET AGEGROUP='65 USTU'
WHERE DATEDIFF(YEAR,BIRTHDATE,GETDATE())>65


-- SORU 13 --
SELECT AGEGROUP, COUNT(*) AS CNT
FROM CUSTOMERS
GROUP BY AGEGROUP
ORDER BY AGEGROUP

SELECT AGEGROUP,GENDER, COUNT(*) AS CNT
FROM CUSTOMERS
GROUP BY AGEGROUP,GENDER
ORDER BY AGEGROUP

SELECT *, DATEDIFF(YEAR, BIRTHDATE, GETDATE()) AS AGE,
CASE 
	WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 20 AND 35 THEN '20-35 YAS ARASI'
	WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 36 AND 45 THEN '36-45 YAS ARASI'
	WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 46 AND 55 THEN '46-55 YAS ARASI'
	WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 56 AND 65 THEN '56-65 YAS ARASI'
	WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) > 65 THEN '65 YAS USTU'
END AGEGROUP2
FROM CUSTOMERS


SELECT 
CASE 
	WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 20 AND 35 THEN '20-35 YAS ARASI'
	WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 36 AND 45 THEN '36-45 YAS ARASI'
	WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 46 AND 55 THEN '46-55 YAS ARASI'
	WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 56 AND 65 THEN '56-65 YAS ARASI'
	WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) > 65 THEN '65 YAS USTU'
END AGEGROUP2, COUNT(*) AS CCOUNT
FROM CUSTOMERS
GROUP BY CASE 
	WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 20 AND 35 THEN '20-35 YAS ARASI'
	WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 36 AND 45 THEN '36-45 YAS ARASI'
	WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 46 AND 55 THEN '46-55 YAS ARASI'
	WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 56 AND 65 THEN '56-65 YAS ARASI'
	WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) > 65 THEN '65 YAS USTU'
END

-- D�NAM�K V�EW
SELECT AGEGROUP2, COUNT(TMP.ID) AS CCOUNT FROM
(SELECT *,
CASE 
	WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 20 AND 35 THEN '20-35 YAS ARASI'
	WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 36 AND 45 THEN '36-45 YAS ARASI'
	WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 46 AND 55 THEN '46-55 YAS ARASI'
	WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 56 AND 65 THEN '56-65 YAS ARASI'
	WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) > 65 THEN '65 YAS USTU'
END AGEGROUP2
FROM CUSTOMERS) TMP
GROUP BY AGEGROUP2
ORDER BY AGEGROUP2


-- HATALI KOD
SELECT AGEGROUP, COUNT(TMP.ID) AS CCOUNT FROM
(SELECT *,
CASE 
	WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 20 AND 35 THEN '20-35 YAS ARASI'
	WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 36 AND 45 THEN '36-45 YAS ARASI'
	WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 46 AND 55 THEN '46-55 YAS ARASI'
	WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 56 AND 65 THEN '56-65 YAS ARASI'
	WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) > 65 THEN '65 YAS USTU'
END AGEGROUP
FROM CUSTOMERS) TMP
GROUP BY AGEGROUP
ORDER BY AGEGROUP


-- SORU 14 --
SELECT *
FROM CUSTOMERS C
INNER JOIN CITIES CI ON C.CITYID=CI.ID
INNER JOIN DISTRICTS D ON C.DISTRICTID=D.ID
WHERE CI.CITY='�STANBUL' AND D.DISTRICT='KADIK�Y'

SELECT *
FROM CUSTOMERS C
INNER JOIN CITIES CI ON C.CITYID=CI.ID
INNER JOIN DISTRICTS D ON C.DISTRICTID=D.ID
WHERE CI.CITY='�STANBUL' AND D.DISTRICT<>'KADIK�Y'

SELECT *
FROM CUSTOMERS C
INNER JOIN CITIES CI ON C.CITYID=CI.ID
INNER JOIN DISTRICTS D ON C.DISTRICTID=D.ID
WHERE CI.CITY='�STANBUL' AND D.DISTRICT NOT LIKE 'KADIK�Y'


SELECT *
FROM CUSTOMERS C
INNER JOIN CITIES CI ON C.CITYID=CI.ID
INNER JOIN DISTRICTS D ON C.DISTRICTID=D.ID
WHERE CI.CITY='�STANBUL' AND D.DISTRICT NOT IN('KADIK�Y')

SELECT *
FROM CUSTOMERS C
INNER JOIN CITIES CI ON C.CITYID=CI.ID
INNER JOIN DISTRICTS D ON C.DISTRICTID=D.ID
WHERE CI.CITY='�STANBUL' AND NOT D.DISTRICT IN ('KADIK�Y')

SELECT *
FROM CUSTOMERS C
WHERE C.CITYID IN(SELECT CI.ID FROM CITIES CI WHERE CI.CITY='�STANBUL')
AND C.DISTRICTID NOT IN (SELECT D.ID FROM DISTRICTS D WHERE D.DISTRICT='KADIK�Y')



-- SORU 15 --
DELETE FROM CITIES WHERE CITY='ANKARA'
DELETE FROM CITIES WHERE CITY='�STANBUL'

SELECT * FROM CUSTOMERS C
INNER JOIN CITIES CI ON C.CITYID=CI.ID
WHERE CI.CITY='ANKARA'

SELECT * FROM CUSTOMERS C
LEFT JOIN CITIES CI ON C.CITYID=CI.ID
WHERE CI.CITY='ANKARA'

-- ANKARA �EHR� L�STEDEN S�L�ND�KTEN SONRA
SELECT * FROM CUSTOMERS C
LEFT JOIN CITIES CI ON C.CITYID=CI.ID
WHERE CI.CITY IS NULL


SELECT * FROM CUSTOMERS --ORDER BY C.CITYID
WHERE CITYID NOT IN (SELECT ID FROM CITIES)


-- SORU 16 --
SELECT * FROM CITIES

INSERT INTO CITIES(ID, CITY)
VALUES(6, 'ANKARA')

INSERT INTO CITIES(CITY)
VALUES('ANKARA')

DELETE FROM CITIES WHERE CITY='ANKARA'

SET IDENTITY_INSERT CITIES ON --53 NUMARALI BA�LANTI ���N AKT�F
INSERT INTO CITIES(ID, CITY)
VALUES(6, 'ANKARA')

INSERT INTO CITIES(ID, CITY)
VALUES(34, 'ISTANBUL')


SET IDENTITY_INDER CITIES OFF -- YA DA YEN� B�R QUERY PENCERES� A�ILIRSA BU BA�LANTI �PTAL OLUR