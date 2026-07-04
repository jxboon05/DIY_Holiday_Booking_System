-- Query 1: Retrieve Confirmed Customer Bookings Ordered by Package Price
SELECT c.customer_id, c.first_name, c.last_name,
b.booking_id, b.booking_date, tp.package_type, tp.package_price
FROM customer c JOIN booking b ON c.customer_id = b.customer_id 
JOIN tour_package tp ON b.package_id = tp.package_id
WHERE b.booking_status = 'Confirmed'
ORDER BY tp.package_price DESC;


-- Query 2: Get customers with Successful Payments
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
WHERE c.customer_id IN (
SELECT b.customer_id
FROM booking b
JOIN payment p ON b.booking_id = p.booking_id
WHERE p.payment_status = 'Success');