SELECT o.OfferNo, o.CourseNo, o.OffLocation, o.OffYear, o.FacNo 
FROM Offering o
WHERE o.OffLocation = 'BLM302';

SELECT o.OfferNo, o.CourseNo, o.OffLocation, o.OffYear, o.FacNo 
FROM Offering o
WHERE o.OffLocation LIKE 'BLM3%';

SELECT *
FROM (
	SELECT s.StdLastName, s.StdFirstName, (s.StdGPA*(1.1)) AS StdGPAplus
	FROM Student s
) s
WHERE s.StdGPAplus > 3
ORDER BY s.StdLastName, s.StdFirstName, s.StdGPAplus;

SELECT 
    TABLE_NAME, 
    TABLE_ROWS 
FROM 
    `information_schema`.`tables` 
WHERE 
    `table_schema` = 'HW2';
   

SELECT COUNT(*) 
FROM Faculty f;

SELECT COUNT(f.FacSupervisor) 
FROM Faculty f;

SELECT COUNT(f.FacSupervisor), COUNT(*)
FROM Faculty f;

SELECT AVG(s.StdGPA)
FROM Student s;

SELECT MIN(s.StdGPA), MAX(s.StdGPA), AVG(s.StdGPA), AVG(s.StdGPA*(1.1))
FROM Student s
WHERE s.StdClass = 'FR';

SELECT c.CrsDesc, MIN(e.EnrGrade), MAX(e.EnrGrade), AVG(e.EnrGrade), AVG(e.EnrGrade*(1.1))
FROM Enrollment e
INNER JOIN Offering o
ON e.OfferNo = o.OfferNo
INNER JOIN Course c
ON o.CourseNo = c.CourseNo
GROUP BY o.CourseNo
ORDER by c.CrsDesc;

SELECT c.CrsDesc, MIN(e.EnrGrade), MAX(e.EnrGrade), AVG(e.EnrGrade), AVG(e.EnrGrade*(1.1))
FROM Enrollment e
INNER JOIN Offering o
ON e.OfferNo = o.OfferNo
INNER JOIN Course c
ON o.CourseNo = c.CourseNo
WHERE o.CourseNo NOT LIKE 'IS%'
GROUP BY o.CourseNo
ORDER by c.CrsDesc;