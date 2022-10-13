SELECT hl.host_id AS 'Host ID', l.language_name
FROM db.host_language AS hl
JOIN db.language AS l
ON hl.language_id = l.id
WHERE host_id >= 20 order by host_id;
