--24
SELECT s.* 
FROM Student s
JOIN Faculty f
ON s.StdFirstName=f.FacFirstName
AND s.StdLastName=f.FacLastName
AND s.StdZip=f.FacZipCode;

--25
SELECT f.FacNo, f.FacLastName, f.FacFirstName, f.FacSalary, s.FacNo, s.FacLastName, s.FacFirstName, s.FacSalary
FROM Faculty f INNER JOIN Faculty s
ON f.FacSupervisor=s.FacNo
WHERE f.FacSalary > s.FacSalary;

SELECT f.FacNo, f.FacLastName, f.FacFirstName, f.FacSalary, s.FacNo, s.FacLastName, s.FacFirstName, s.FacSalary
FROM Faculty f, Faculty s
WHERE f.FacSupervisor=s.FacNo
AND f.FacSalary > s.FacSalary;

--26
SELECT DISTINCT f.FacLastName, f.FacFirstName, o.CourseNo
FROM Faculty f, Offering o, Offering s
WHERE f.FacNo=o.FacNo
AND f.FacSupervisor=s.FacNo
AND o.CourseNo=s.CourseNo
AND o.OffYear=2009;

SELECT DISTINCT f.FacLastName, f.FacFirstName, o.CourseNo
FROM Faculty f, Offering o, Offering s
WHERE f.FacNo=o.FacNo
AND f.FacSupervisor=s.FacNo
AND o.CourseNo=s.CourseNo
AND o.OffYear=2010;

SELECT f.FacLastName, f.FacFirstName, o1.CourseNo
FROM (Faculty f INNER JOIN Offering o1
		ON f.FacNo=o1.FacNo)
INNER JOIN Offering o2
ON f.FacSupervisor=o2.FacNo
AND o1.CourseNo=o2.CourseNo
AND o1.OffYear=o2.OffYear
WHERE o1.OffYear=2010
ORDER BY 1,2,3;

--27
SELECT c.*, o.*
FROM Course c LEFT JOIN Offering o ON c.CourseNo=o.CourseNo
ORDER BY c.CourseNo, o.OfferNo;

--28
SELECT o.OffYear, o.OffTerm, o.CourseNo, o.OfferNo, f.FacLastName, f.FacFirstName
FROM Faculty f RIGHT JOIN Offering o ON o.FacNo=f.FacNo
ORDER BY f.FacNo, o.CourseNo, o.OfferNo;

--29
SELECT DISTINCT o.OfferNo, o.CourseNo, o.OffTerm, c.CrsDesc, f.FacNo, f.FacLastName, f.FacFirstName
FROM Enrollment e 
LEFT JOIN Offering o ON e.OfferNo=o.OfferNo
JOIN Course c ON o.CourseNo=c.CourseNo
JOIN Faculty f ON o.FacNo=f.FacNo
WHERE c.CourseNo LIKE 'IS%'
AND o.OffYear=2009;

SELECT DISTINCT o.OfferNo, o.CourseNo, o.OffTerm, c.CrsDesc, f.FacNo, f.FacLastName, f.FacFirstName
FROM ((Offering o LEFT JOIN Faculty f ON o.FacNo=f.FacNo)
		INNER JOIN Course c ON o.CourseNo=c.CourseNo)
INNER JOIN Enrollment e ON e.OfferNo=o.OfferNo
WHERE c.CourseNo LIKE 'IS%'
AND o.OffYear=2009
ORDER BY 1,2;

--30
SELECT f.FacNo, f.FacLastName, f.FacFirstName, f.FacCity, f.FacState
FROM Faculty f
UNION
SELECT s.StdNo, s.StdLastName, s.StdFirstName, s.StdCity, s.StdState
FROM Student s
ORDER BY f.FacNo;

SELECT f.FacNo, f.FacLastName, f.FacFirstName, f.FacCity, f.FacState
FROM Faculty f
UNION ALL
SELECT s.StdNo, s.StdLastName, s.StdFirstName, s.StdCity, s.StdState
FROM Student s
ORDER BY f.FacNo;

--31
SELECT s.StdLastName, s.StdFirstName, s.StdMajor
FROM Student s JOIN (	SELECT e.StdNo, e.EnrGrade
						FROM Enrollment e JOIN Offering o ON e.OfferNo=o.OfferNo
						WHERE o.OffTerm='FALL'
						AND o.OffYear=2009
						AND e.EnrGrade>=3.5) AS a ON s.StdNo=a.StdNo;
						
SELECT s.StdLastName, s.StdFirstName, s.StdMajor
FROM Student s 
INNER JOIN Enrollment e
ON s.StdNo=e.StdNo
WHERE e.EnrGrade>=3.5
AND e.OfferNo IN (
	SELECT o.OfferNo
	FROM Offering o
	WHERE o.OffTerm='FALL'
	AND o.OffYear=2009
)
ORDER BY 1,2;

--32
SELECT s.StdLastName, s.StdFirstName, s.StdMajor
FROM Student s JOIN (	SELECT e.StdNo, e.EnrGrade
						FROM Enrollment e JOIN (SELECT o.OfferNo, o.FacNo
												FROM Offering o JOIN Faculty f ON o.FacNo=f.FacNo
												WHERE f.FacNo != (SELECT f.FacNo FROM Faculty f WHERE f.FacFirstName='Leonard' AND f.FacLastName='Vince')
												AND o.OffTerm='WINTER'
												AND o.OffYear=2010
												) AS b ON e.OfferNo=b.OfferNo						 
						WHERE e.EnrGrade>=3.5) AS a ON s.StdNo=a.StdNo;
						
SELECT s.StdLastName, s.StdFirstName, s.StdMajor
FROM Student s 
INNER JOIN Enrollment e 
ON s.StdNo=e.StdNo
WHERE e.EnrGrade>=3.5
AND e.OfferNo IN (
	SELECT o.OfferNo
	FROM Offering o
	WHERE o.OffTerm='WINTER'
	AND o.OffYear=2010
	AND O.FacNo NOT IN (
		SELECT f.FacNo 
		FROM Faculty f 
		WHERE f.FacFirstName='Leonard' 
		AND f.FacLastName='Vince'
	)
)
ORDER BY 1,2;
					
--33
SELECT f.FacLastName, f.FacFirstName
FROM Faculty f
WHERE NOT EXISTS (	SELECT *
					FROM Student s
					WHERE s.StdNo=f.FacNo
					);
				
--34
SELECT f.FacLastName, f.FacFirstName
FROM Faculty f
WHERE f.FacNo IN (	SELECT o.FacNo
					FROM Offering o
					WHERE o.OffTerm='FALL'
					AND o.OffYear=2009
					AND o.CourseNo LIKE 'IS%'
					);

SELECT f.FacLastName, f.FacFirstName
FROM Faculty f
INNER JOIN Offering o
ON f.FacNo=o.Facno
WHERE o.OffTerm='FALL'
AND o.OffYear=2009
AND o.CourseNo LIKE 'IS%'
GROUP BY f.FacLastName, f.FacFirstName
HAVING COUNT(*)=(SELECT COUNT(*)
				 FROM Offering o1
				 WHERE o1.OffTerm='FALL'
				 AND o1.OffYear=2009
				 AND o1.CourseNo LIKE 'IS%')
ORDER BY 1,2;

--35
SELECT c.CourseNo, c.CrsDesc, COUNT(d.OfferNo) AS numberOfOfferings, SUM(d.countE)/COUNT(d.OfferNo) AS averageOfEnroll
INTO dbo.courseTemp
FROM Course c JOIN (SELECT CourseNo, o.OfferNo, a.countE
					FROM Offering o
					LEFT JOIN ( SELECT e.OfferNo, COUNT(e.StdNo) AS countE
								FROM Enrollment e
								GROUP BY e.OfferNo
		  					  ) AS a ON o.OfferNo=a.OfferNo
					) AS d ON c.CourseNo=d.CourseNo
GROUP BY c.CourseNo, c.CrsDesc
ORDER BY c.CourseNo;

SELECT t.CourseNo, t.CrsDesc, COUNT(*) AS NumOfferings, AVG(t.EnrollCount) AS AvgEnroll
FROM (
	SELECT c.CourseNo, C.CrsDesc, o.OfferNo, COUNT(*) AS EnrollCount
	FROM (	Course c
		 	INNER JOIN Offering o ON c.CourseNo=o.CourseNo
		)
	INNER JOIN Enrollment e ON o.OfferNo=e.OfferNo
	GROUP BY c.CourseNo, C.CrsDesc, o.OfferNo
	) t
GROUP BY t.CourseNo, t.CrsDesc
ORDER BY 1,2;

--ch10 1
--b
UPDATE PRODUCT 
SET PROD_QOH=PROD_QOH+1
WHERE PROD_CODE='ABC';

UPDATE PART 
SET PART_QOH=PART_QOH-1
WHERE PART_CODE='A'
OR PART_CODE='B'
OR PART_CODE='C';

--c
BEGIN TRANSACTION;
UPDATE PRODUCT 
SET PROD_QOH=PROD_QOH+1
WHERE PROD_CODE='ABC';
UPDATE PART 
SET PART_QOH=PART_QOH-1
WHERE PART_CODE='A'
OR PART_CODE='B'
OR PART_CODE='C';
COMMIT TRANSACTION;

--e
CREATE TABLE PRODUCT (
  PROD_CODE  CHAR(3)   NULL,
  PROD_QOH	NUMERIC NULL
);
INSERT INTO PRODUCT VALUES ('ABC', 1205);

CREATE TABLE PART (
  PART_CODE  CHAR(1)   NULL,
  PART_QOH	NUMERIC NULL
);
INSERT INTO PART VALUES ('A', 567);
INSERT INTO PART VALUES ('B', 98);
INSERT INTO PART VALUES ('C', 549);

--ch8
--1
CREATE TABLE CUSTOMER (
  CUST_NUM	CHAR(4)	NOT NULL,
  CUST_LNAME	VARCHAR(20)	NOT NULL,
  CUST_FNAME	VARCHAR(20)	NOT NULL,
  CUST_BALANCE	NUMERIC(6,2) NOT NULL,
  CONSTRAINT CUSTOMERPK PRIMARY KEY (CUST_NUM)
);

CREATE TABLE CUSTOMER_2 (
  CUST_NUM	CHAR(4)	NOT NULL,
  CUST_LNAME	VARCHAR(20)	NOT NULL,
  CUST_FNAME	VARCHAR(20)	NOT NULL,
  CONSTRAINT CUSTOMER_2PK PRIMARY KEY (CUST_NUM)
);

CREATE TABLE INVOICE (
  INV_NUM	CHAR(4)	NOT NULL,
  CUST_NUM	CHAR(4)	NOT NULL,
  INV_DATE	DATE	NOT NULL,
  INV_AMOUNT	NUMERIC(6,2) NOT NULL,
  CONSTRAINT INVOICEPK PRIMARY KEY (INV_NUM),
  CONSTRAINT INVOICEFK FOREIGN KEY (CUST_NUM) REFERENCES CUSTOMER (CUST_NUM)
);

--2
INSERT INTO CUSTOMER VALUES ('1000', 'Smith', 'Jeanne', 1050.11);
INSERT INTO CUSTOMER VALUES ('1001', 'Ortega', 'Juan', 840.92);

INSERT INTO CUSTOMER_2 VALUES ('2000', 'McPherson', 'Anne');
INSERT INTO CUSTOMER_2 VALUES ('2001', 'Ortega', 'Juan');
INSERT INTO CUSTOMER_2 VALUES ('2002', 'Kowalski', 'Jan');
INSERT INTO CUSTOMER_2 VALUES ('2003', 'Chen', 'George');

INSERT INTO INVOICE VALUES ('8000', '1000', '23-Mar-14', 235.89);
INSERT INTO INVOICE VALUES ('8001', '1001', '23-Mar-14', 312.82);
INSERT INTO INVOICE VALUES ('8002', '1001', '30-Mar-14', 528.10);
INSERT INTO INVOICE VALUES ('8003', '1000', '12-Apr-14', 194.78);
INSERT INTO INVOICE VALUES ('8004', '1000', '23-Apr-14', 619.44);

--3
SELECT c.CUST_LNAME, c.CUST_FNAME
FROM CUSTOMER c
UNION
SELECT c2.CUST_LNAME, c2.CUST_FNAME
FROM CUSTOMER_2 c2;

--4
SELECT c.CUST_LNAME, c.CUST_FNAME
FROM CUSTOMER c
UNION ALL
SELECT c2.CUST_LNAME, c2.CUST_FNAME
FROM CUSTOMER_2 c2;

--5
SELECT c.CUST_LNAME, c.CUST_FNAME
FROM CUSTOMER c
INTERSECT
SELECT c2.CUST_LNAME, c2.CUST_FNAME
FROM CUSTOMER_2 c2;

--6
SELECT c2.CUST_LNAME, c2.CUST_FNAME
FROM CUSTOMER_2 c2
EXCEPT
SELECT c.CUST_LNAME, c.CUST_FNAME
FROM CUSTOMER c;

--7
SELECT i.INV_NUM, i.CUST_NUM, a.CUST_LNAME, a.CUST_FNAME, i.INV_DATE, i.INV_AMOUNT
FROM INVOICE i 
LEFT JOIN (	SELECT c.CUST_NUM, c.CUST_LNAME, c.CUST_FNAME, c.CUST_BALANCE
			FROM CUSTOMER c
			) AS a ON i.CUST_NUM=a.CUST_NUM
WHERE a.CUST_BALANCE>=1000;