create procedure GetMaxQuantity()
select max(Qauntity) as 'Max Q. in Order'
from orders;





prepare GetOrderDetail 
from 
   ' select OrderID, Qauntity, TotalCost as OrderCost from orders where CustmerID = ?';
set @CustmerID=1;
execute GetOrderDetail using @CustomerID;



DELIMITER //

CREATE PROCEDURE CancelOrder(IN orderId INT)
BEGIN
    DELETE FROM Orders WHERE OrderID = orderId;
END //

DELIMITER ;

INSERT INTO bookings (BoockingID, TableNumber, BookingSlot, 
CustomerID)
VALUES
(1,5,'2022-10-10',1),
(2,3,'2022-11-12',3),
(3,2,'2022-10-11',2),
(4,2,'2022-10-13',4);


DELIMITER //

CREATE PROCEDURE CheckBooking(booking_date DATE, table_number INT)

BEGIN
 DECLARE bookedTable INT DEFAULT 0;
 SELECT COUNT(bookedTable)
    INTO bookedTable
    FROM bookings WHERE BookingSlot = booking_date and TableNumber = table_number;
    IF bookedTable > 0 THEN
      SELECT CONCAT( "Table", table_number, "is already booked") AS "Booking status";
      ELSE 
      SELECT CONCAT( "Table", table_number, "is not booked") AS "Booking status";
    END IF;
END //

DELIMITER ;




DELIMITER //

CREATE PROCEDURE AddValidBooking(
     bookingDate DATE,
     tableNumber INT)
BEGIN
   declare bookedTable INT default 0;

    SELECT COUNT(*) 
    INTO bookedTable
    FROM bookings
    WHERE BookingSlot = bookingDate AND TableNumber = tableNumber;

      -- Start a transaction
    START TRANSACTION;

    IF bookedTable > 0
    THEN
	
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Table is already booked for this date.';
    ELSE
        -- The table is available, so insert the new booking
        INSERT INTO Bookings ( TableNumber,BookingSlot)
        VALUES (bookingDate, tableNumber);

        -- Commit the transaction
        COMMIT;
    END IF;
END //

DELIMITER ;


DELIMITER //
create procedure AddBooking(
booking_id int,
table_numbre int,
booking_date date,
customer_id int)
begin
insert into bookings(
            BoockingID,
            TableNumber,
            BookingSlot,
            CustomerID) values(
            booking_id,
            table_numbre,
            booking_date,
            customer_id);
select "New booking added" as "Confirmation";
end //

DELIMITER 


CREATE DEFINER='admin1'@'%' PROCEDURE UpdateBooking(booking_id INT, booking_date DATE)
BEGIN
UPDATE bookings SET BookingSlot = booking_date WHERE BookingID = booking_id; 
SELECT CONCAT("Booking", booking_id, "updated") AS "Confirmation";
END;

-- DELIMITER //
create definer='admin1'@'%' PROCEDURE CancelBooking(booking_id INT)
BEGIN
delete from bookings
where BoockingID = booking_id; 
SELECT CONCAT("Booking", booking_id, "cancelled") AS "Confirmation";
end;

-- DELIMITER;