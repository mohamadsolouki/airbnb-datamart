SELECT u.id AS 'User ID', ut.type_name AS 'User type', first_name AS 'First name', 
last_name AS 'Last name', email AS 'E-mail', DOB AS 'Date of Birth' 
FROM db.user AS u JOIN db.user_type AS ut
ON u.user_type = ut.id
WHERE user_type = 1 ORDER BY DOB ASC;