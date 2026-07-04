CREATE OR REPLACE PROCEDURE add_payment (
p_payment_id IN payment.payment_id%TYPE, p_booking_id IN payment.booking_id%TYPE, 
p_amount IN payment.payment_amount%TYPE, p_method IN payment.payment_method%TYPE, 
p_status IN payment.payment_status%TYPE
)
IS
v_count NUMBER;
BEGIN
-- Validation: Check if booking exists
SELECT COUNT(*)
INTO v_count
FROM booking
WHERE booking_id = p_booking_id;

IF v_count = 0 THEN
DBMS_OUTPUT.PUT_LINE('Error: Booking does not exist.');

--Validate payment method
ELSIF p_method NOT IN ('Credit Card', 'E-Wallet', 'Online Banking') THEN 
DBMS_OUTPUT.PUT_LINE('Error: Invalid payment method.');

-- Validate payment status
ELSIF p_status NOT IN ('Success','Pending','Refunded') THEN
DBMS_OUTPUT.PUT_LINE('Error: Invalid payment status.');

ELSE
INSERT INTO payment
VALUES (p_payment_id, p_booking_id, p_amount, p_method, SYSTIMESTAMP, p_status);

COMMIT;
DBMS_OUTPUT.PUT_LINE('Payment ' || p_payment_id || ' added successfully.');
END IF;

EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('Unexpected error occurred.');
END;
/