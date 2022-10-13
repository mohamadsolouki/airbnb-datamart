SELECT i.property_id AS 'Property ID', CONCAT(u.first_name, ' ' ,u.last_name) AS 'Uploaded by',
i.image_name AS 'Image title', i.file_location AS 'URL', i.created_at 'Uploaded at' 
FROM db.image AS i JOIN db.user AS u ON i.by_user = u.id
ORDER BY property_id LIMIT 20;