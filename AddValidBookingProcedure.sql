
DROP PROCEDURE IF EXISTS AddValidBooking;

DELIMITER //
CREATE PROCEDURE AddValidBooking (
  IN booking_date DATE,
  IN table_number INT
)
BEGIN
    #Declare the variable that will hold the count of bookings found	
  DECLARE booking_count INT;
  START TRANSACTION;
    #Check if a booking with the same date and table number exists and hold the count in the variable
  INSERT INTO bookings (booking_date, table_number)
  VALUES (booking_date, table_number);
    #If a booking with the same date and table number was found then rollup otherwise commit
  SELECT COUNT(*) INTO booking_count
  FROM bookings
  WHERE booking_date = booking_date AND table_number = table_number;
  IF booking_count > 1 THEN
    ROLLBACK;
  ELSE
    COMMIT;
  END IF;
END //
DELIMITER ;

  -- Call the procedure to test it
CALL AddValidBooking("2022-12-17", 6, 5);