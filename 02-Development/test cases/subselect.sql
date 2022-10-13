SELECT CONCAT(u.first_name, ' ' ,u.last_name) AS 'Guest name', p.owner_id AS 'Host ID', 
subs.tax AS 'Tax', subs.service_fee AS 'Service fee', subs.Booking_price AS 'Booking price', 
subs.total_price AS 'Total price' FROM (
SELECT t.booking_id, b.guest_id, b.property_id, t.tax,
t.service_fee, (b.price_per_night * DATEDIFF(b.check_out,b.check_in)) AS 'booking_price', 
t.total_price, t.is_refund
FROM db.transaction AS t JOIN db.booking AS b ON t.booking_id = b.id 
LEFT JOIN db.promo AS p ON t.promo_id = p.id 
WHERE t.is_refund = 1 ) AS subs
JOIN db.user AS u ON u.id = subs.guest_id
JOIN db.property AS p ON p.id = subs.property_id;