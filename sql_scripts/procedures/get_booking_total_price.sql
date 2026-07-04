CREATE OR REPLACE PROCEDURE get_booking_total_price (
p_booking_id IN booking.booking_id%TYPE
)
IS
v_total booking.total_price%TYPE;
BEGIN
SELECT total_price
INTO v_total
FROM booking
WHERE booking_id = p_booking_id;

DBMS_OUTPUT.PUT_LINE('Booking ID: ' || p_booking_id); DBMS_OUTPUT.PUT_LINE('Total Price: RM' ||TO_CHAR(v_total, '999,999.99'));

EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('Error: Booking not found.');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('Unexpected error occurred.');
END;
/