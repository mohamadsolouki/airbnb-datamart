SELECT ssv.Host, ssv.type_name AS 'Place_type', ssv.Property_type, co.name AS 'Country', ci.name AS 'City', a.street_address AS 'Address', a.zip AS 'Zip code'
FROM (
SELECT p.address_id,
CONCAT(u.first_name, ' ' ,u.last_name) AS 'Host', plt.type_name, prt.type_name AS 'Property_type'
FROM db.property AS p JOIN db.user as u ON p.owner_id = u.id
JOIN db.place_type AS plt ON p.place_type_id = plt.id
JOIN db.property_type AS prt ON p.property_type_id = prt.id
)
AS ssv JOIN db.address as a ON ssv.address_id = a.id
JOIN country AS co ON a.country_id = co.id
JOIN city AS ci ON a.city_id = ci.id
ORDER BY ssv.Property_type ASC;