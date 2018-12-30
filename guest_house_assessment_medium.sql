-- 6. Ruth Cadbury. Show the total amount payable by guest Ruth Cadbury for her room bookings. You should JOIN to the rate table using room_type_requested and occupants.
SELECT SUM(b1.nights * r1.amount)
FROM booking b1
JOIN rate r1 ON r1.room_type = b1.room_type_requested AND r1.occupancy = b1.occupants
JOIN guest g1 ON b1.guest_id = g1.id
WHERE g1.id = (
  SELECT g2.id
  FROM guest g2
  WHERE g2.first_name = 'Ruth' AND g2.last_name = 'Cadbury'
)

-- 7. Including Extras. Calculate the total bill for booking 5346 including extras.
SELECT SUM(b1.nights * r1.amount) + (SELECT SUM(amount) FROM extra e1 WHERE e1.booking_id = 5346)
FROM booking b1
JOIN rate r1 ON b1.room_type_requested = r1.room_type AND b1.occupants = r1.occupancy
WHERE b1.booking_id = 5346

-- 8. Edinburgh Residents. For every guest who has the word “Edinburgh” in their
-- address show the total number of nights booked. Be sure to include 0 for those
-- guests who have never had a booking. Show last name, first name, address and number
-- of nights. Order by last name then first name.
SELECT g1.id, g1.first_name, g1.last_name, g1.address, COALESCE(SUM(b1.nights), '0') as nights
FROM guest g1
LEFT OUTER JOIN booking b1 ON g1.id = b1.guest_id
WHERE g1.address LIKE '%Edinburgh%'
GROUP BY g1.id, g1.first_name, g1.last_name, g1.address
ORDER BY g1.last_name, g1.first_name

-- 9. How busy are we? For each day of the week beginning 2016-11-25 show the number of
-- bookings starting that day. Be sure to show all the days of the week in the correct order.
SELECT b1.booking_date AS i, COUNT(b1.booking_id) AS arrivals FROM booking b1
WHERE b1.booking_date BETWEEN '2016-11-25' AND '2016-12-01'
GROUP BY b1.booking_date
ORDER BY b1.booking_date ASC

-- 10. How many guests? Show the number of guests in the hotel on the night of 2016-11-21. 
-- Include all occupants who checked in that day but not those who checked out.
SELECT SUM(b1.occupants) as FROM booking b1
WHERE DATE_ADD(b1.booking_date, INTERVAL b1.nights DAY) > '2016-11-21' AND b1.booking_date <= '2016-11-21'
