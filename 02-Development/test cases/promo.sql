SELECT title AS 'Promo title', discount AS 'Discount percent',
code AS 'Promo Code', promo_status AS 'Code status'
FROM db.promo 
WHERE promo_status = 1 AND discount>30 ORDER BY discount;