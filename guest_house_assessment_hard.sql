-- 11. Coincidence. Have two guests with the same surname ever stayed in the hotel
-- on the evening? Show the last name and both first names. Do not include duplicates.
SELECT DISTINCT g1.last_name, g1.first_name, temp_b_g.first_name FROM booking b1
JOIN guest g1 ON b1.guest_id = g1.id
JOIN (SELECT * FROM booking b2
  JOIN guest g2 ON b2.guest_id = g2.id) as temp_b_g ON g1.last_name = temp_b_g.last_name AND g1.first_name > temp_b_g.first_name
WHERE temp_b_g.booking_date BETWEEN b1.booking_date AND DATE_ADD(b1.booking_date, INTERVAL b1.nights - 1 DAY)
AND g1.id != temp_b_g.id
GROUP BY g1.last_name, g1.first_name, temp_b_g.first_name

-- 12. Check out per floor. The first digit of the room number indicates the floor –
-- e.g. room 201 is on the 2nd floor. For each day of the week beginning 2016-11-14 show
-- how many rooms are being vacated that day by floor number. Show all days in the correct order.
