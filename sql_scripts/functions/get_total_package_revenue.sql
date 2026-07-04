CREATE OR REPLACE FUNCTION get_total_package_revenue (
p_package_id IN tour_package.package_id%TYPE
)
RETURN NUMBER
IS
v_total NUMBER(10,2);
BEGIN
SELECT SUM(p.payment_amount)
INTO v_total
FROM payment p
JOIN booking b ON p.booking_id = b.booking_id
WHERE b.package_id = p_package_id
AND p.payment_status = 'Success';

RETURN NVL(v_total, 0);
END;
/