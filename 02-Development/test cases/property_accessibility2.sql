SELECT COUNT(p.property_id) AS 'Number of properties',
a.feature_name
FROM db.property_accessibility AS p
JOIN db.accessibility AS a 
ON p.accessibility_id = a.id
WHERE a.id = 1;