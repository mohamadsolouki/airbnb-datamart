SELECT p.property_id AS 'Property ID',
a.feature_name AS 'Feature name'
FROM db.property_accessibility AS p
JOIN db.accessibility AS a 
ON p.accessibility_id = a.id
WHERE p.property_id = 9;

