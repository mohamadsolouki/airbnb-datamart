SELECT a.id AS 'Address ID', r.region_name AS 'Region', co.name AS 'Country',
 s.name AS 'State', ci.name AS 'City', a.street_address AS 'Address',
 a.zip AS 'Zip code', a.latitude AS' Latitude', a.longitude AS 'Longitude' FROM 
address AS a
JOIN region AS r ON a.region_id = r.id
JOIN country AS co ON a.country_id = co.id
JOIN state AS s ON a.state_id = s.id
JOIN city AS ci ON a.city_id = ci.id
LIMIT 10;