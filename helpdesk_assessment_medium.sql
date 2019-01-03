-- 6. List the Company name and the number of calls for those companies with more than 18 calls.

SELECT cu.Company_name, COUNT(iss.Call_ref) as cc FROM Issue iss
JOIN Caller ca ON iss.Caller_id = ca.Caller_id
JOIN Customer cu ON ca.Company_ref = cu.Company_ref
GROUP BY cu.Company_ref, cu.Company_name
HAVING COUNT(iss.Call_ref) > 18

-- 7. Find the callers who have never made a call. Show first name and last name
SELECT ca.First_name, ca.Last_name FROM Caller ca
LEFT OUTER JOIN Issue iss ON ca.Caller_id = iss.Caller_id
WHERE iss.Caller_id IS NULL

-- 8. For each customer show: Company name, contact name, number of calls where
-- the number of calls is fewer than 5
SELECT cu.Company_name, cu.Contact, COUNT(iss.Call_ref) as nc FROM Customer cu
JOIN Caller ca ON cu.Company_ref = ca.Company_ref
JOIN Issue iss ON ca.Caller_id = iss.Caller_id
GROUP BY cu.Company_ref, cu.Company_name, cu.Contact
HAVING COUNT(iss.Call_ref) < 5

-- 9. For each shift show the number of staff assigned. Beware that some roles
-- may be NULL and that the same person might have been assigned to multiple
-- roles (The roles are 'Manager', 'Operator', 'Engineer1', 'Engineer2').
SELECT s.Shift_date, s.Shift_type, COUNT(DISTINCT staff.Staff_code) AS cw FROM Shift s
JOIN Staff staff ON s.Manager = staff.Staff_code
  OR s.Operator = staff.Staff_code
  OR s.Engineer1 = staff.Staff_code
  OR s.Engineer2 = staff.Staff_code
GROUP BY s.Shift_date, s.Shift_type

-- 10. Caller 'Harry' claims that the operator who took his most recent call was
-- abusive and insulting. Find out who took the call (full name) and when.
SELECT s.First_name, s.Last_name, iss.Call_date FROM Caller ca
JOIN Issue iss ON ca.Caller_id = iss.Caller_id
JOIN Staff s ON iss.Assigned_to = s.Staff_code
WHERE ca.First_name = 'Harry' AND iss.Call_date = (
  SELECT MAX(iss.Call_date) FROM Caller ca
  JOIN Issue iss ON ca.Caller_id = iss.Caller_id
  WHERE ca.First_name = 'Harry'
)
