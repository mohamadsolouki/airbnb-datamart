SELECT b.id AS 'Booking ID', CONCAT(u.first_name, ' ' ,u.last_name) AS 'Guest name',
DATEDIFF(b.check_out,b.check_in) AS 'No. of nights', b.price_per_night AS 'Price per night',  
(b.price_per_night * DATEDIFF(b.check_out,b.check_in)) AS 'Total price',
b.adult_num AS 'No. of adults', b.child_num AS 'No. of guests', b.created_at AS 'Reserved in'
FROM db.booking AS b JOIN db.user AS u
ON b.guest_id = u.id LIMIT 20;