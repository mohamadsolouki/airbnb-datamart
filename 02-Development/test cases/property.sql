SELECT p.id AS 'Property ID', p.address_id AS 'Address ID', owner_id AS 'Host ID', 
pt.type_name AS 'Property type', plt.type_name AS 'Plcae type', bed_count AS 'No. Beds', 
bedroom_count AS 'No. Bedrooms', bathroom_count AS 'No. Bathrooms', current_price AS 'Price', 
availabality AS 'Is available' FROM db.property AS p
JOIN db.property_type AS pt ON p.property_type_id = pt.id
JOIN db.place_type AS plt ON p.place_type_id = plt.id
WHERE p.availabality = 1 ORDER BY p.id;