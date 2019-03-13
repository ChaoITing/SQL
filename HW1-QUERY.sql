SELECT * FROM Student;
SELECT * FROM Faculty;
SELECT * FROM Offering;
SELECT * FROM Course;
SELECT * FROM Enrollment;

SELECT s.StdNo, s.StdFirstName, s.StdLastName 
FROM Student s
ORDER BY s.StdLastName ASC, s.StdFirstName ASC;

SELECT s.StdNo, s.StdFirstName, s.StdLastName 
FROM Student s
ORDER BY s.StdLastName, s.StdFirstName;

SELECT s.StdLastName, s.StdFirstName, s.StdGPA
FROM Student s
ORDER BY s.StdGPA DESC, s.StdLastName, s.StdFirstName;

SELECT s.StdLastName, s.StdFirstName, s.StdGPA
FROM Student s
ORDER BY 3 DESC, 1, 2;

SELECT s.StdCity, s.StdClass, count(*)
FROM Student s
GROUP BY s.StdCity, s.StdClass
HAVING count(*) > 1
ORDER BY s.StdCity, s.StdClass;

SELECT s.StdCity, count(*)
FROM Student s
GROUP BY s.StdCity
HAVING count(*) > 1
ORDER BY s.StdCity;

SELECT s.StdClass, count(*)
FROM Student s
GROUP BY s.StdClass
HAVING count(*) > 1
ORDER BY s.StdClass;

SELECT s.StdCity, s.StdClass, count(*)
FROM Student s
GROUP BY s.StdCity, s.StdClass
HAVING count(*) = 1
ORDER BY s.StdCity, s.StdClass;

SELECT s.StdCity, count(*)
FROM Student s
GROUP BY s.StdCity
HAVING count(*) = 1
ORDER BY s.StdCity;

SELECT s.StdClass, count(*)
FROM Student s
GROUP BY s.StdClass
HAVING count(*) = 1
ORDER BY s.StdClass;

SELECT s.StdLastName, s.StdFirstName, s.StdGPA
FROM Student s
WHERE s.StdGPA > 3.2
ORDER BY s.StdGPA DESC, s.StdLastName, s.StdFirstName;

SELECT s.StdLastName, s.StdFirstName, s.StdGPA
FROM Student s
WHERE s.StdGPA BETWEEN 2.3 AND 2.6 OR s.StdGPA BETWEEN 3.3 AND 3.7
ORDER BY s.StdGPA DESC, s.StdLastName, s.StdFirstName;

SELECT s.StdLastName, s.StdFirstName, s.StdGPA
FROM Student s
WHERE s.StdGPA BETWEEN 2.7 AND 3.2
ORDER BY s.StdGPA DESC, s.StdLastName, s.StdFirstName;

SELECT o.OfferNo, o.CourseNo, o.OffYear, o.FacNo
FROM Offering o
WHERE o.FacNo IS NULL
ORDER BY o.OfferNo;

SELECT o.OfferNo, o.CourseNo, o.OffYear, o.FacNo
FROM Offering o
WHERE o.FacNo IS NOT NULL
ORDER BY o.OfferNo;