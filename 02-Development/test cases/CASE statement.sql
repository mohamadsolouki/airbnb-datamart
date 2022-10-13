SELECT id AS 'Property ID', current_price AS 'Property price',
CASE
	WHEN current_price > 300 THEN 'Expensive'
    WHEN current_price > 100 THEN 'Affordable'
    ELSE 'Cheap'
END AS 'Price'
FROM db.property WHERE availabality = 1;