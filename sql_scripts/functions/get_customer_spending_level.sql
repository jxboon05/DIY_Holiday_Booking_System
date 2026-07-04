CREATE OR REPLACE FUNCTION get_customer_spending_level (
p_customer_id IN customer.customer_id%TYPE
)
RETURN VARCHAR2
IS
v_total NUMBER;
BEGIN
SELECT SUM(p.payment_amount)
INTO v_total
FROM payment p
JOIN booking b ON p.booking_id = b.booking_id
WHERE b.customer_id = p_customer_id
AND p.payment_status = 'Success';

IF v_total IS NULL OR v_total = 0 THEN
RETURN 'No Spending';

ELSIF v_total < 1000 THEN
RETURN 'Low Spender';

ELSIF v_total <= 3000 THEN
RETURN 'Medium Spender';

ELSE
RETURN 'High Spender';
END IF;
END;
/