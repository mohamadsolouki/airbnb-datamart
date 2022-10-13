SELECT p.property_id AS 'Property ID',
a.name AS 'Amenity name'
FROM db.property_amenities AS p
JOIN db.amenity AS a 
ON p.amenity_id = a.id
WHERE p.property_id = 2;