SELECT r.id AS 'Review ID', CONCAT(u.first_name, ' ' ,u.last_name) AS 'Review by',
r.booking_id AS 'Booking ID', r.rating AS 'Rating', r.review_body AS 'Text'
FROM db.review AS r JOIN db.user AS u
ON r.review_by_user = u.id
WHERE r.review_status = 1
ORDER BY r.booking_id;