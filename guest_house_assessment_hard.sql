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


-- 13. Free rooms? List the rooms that are free on the day 25th Nov 2016.
SELECT DISTINCT b2.room_no FROM booking b2
WHERE b2.room_no NOT IN (
  SELECT DISTINCT b1.room_no FROM booking b1
  WHERE b1.booking_date <= '2016-11-25' AND DATE_ADD(b1.booking_date, INTERVAL b1.nights DAY) > '2016-11-25'
)

-- 14. Single room for three nights required. A customer wants a single room for
-- three consecutive nights. Find the first available date in December 2016.
SELECT b1.room_no, b1.booking_date, DATE_ADD(b1.booking_date, INTERVAL b1.nights DAY) as booking_date_end
FROM booking b1
JOIN room r1 ON b1.room_no = r1.id
JOIN (SELECT b1.room_no, b1.booking_date, DATE_ADD(b1.booking_date, INTERVAL b1.nights DAY) as booking_date_end FROM booking b1
  JOIN room r1 ON b1.room_no = r1.id WHERE r1.room_type = 'single')
  as temp_b_r 0N temp_b_r.room_no = b1.room_no AND temp_b_r.booking_date
WHERE r1.room_type = 'single'


-- 15. Gross income by week. Money is collected from guests when they leave. For each Thursday in November and December 2016,
-- show the total amount of money collected from the previous Friday to that day, inclusive.
SELECT DATE_ADD(MAKEDATE(2016, 7), INTERVAL WEEK(DATE_ADD(b1.booking_date, INTERVAL b1.nights - 5 DAY), 0) WEEK) AS i,
SUM(rate1.amount*b1.nights) + SUM(e.amount) AS Total
FROM booking b1
JOIN room r1 ON b1.room_no = r1.id
LEFT JOIN rate rate1 ON r1.room_type = rate1.room_type AND b1.occupants = rate1.occupancy
LEFT JOIN (
    SELECT
      booking_id,
      SUM(amount) as amount
    FROM
      extra
    group by
      booking_id
  )
  AS e
  ON (e.booking_id = b1.booking_id)
GROUP BY i
