SELECT t.id AS 'Tx ID', t.booking_id AS 'Booking ID', p.code AS 'Promo code', t.tax AS 'Tax', 
t.service_fee AS 'Fee', (b.price_per_night * DATEDIFF(b.check_out,b.check_in)) AS 'Booking price', 
t.total_price AS 'Total price', t.transaction_status AS 'Tx status', 
t.is_refund AS 'Refund status', t.transfer_on AS 'Tx time'
FROM db.transaction AS t JOIN db.booking AS b ON t.booking_id = b.id 
LEFT JOIN db.promo AS p ON t.promo_id = p.id ORDER BY t.transfer_on DESC LIMIT 20;