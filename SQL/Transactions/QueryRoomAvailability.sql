SET @DateToCheck = '2023-01-01';

SELECT
	hotel.hotel_name,
    room_type.room_type_name,
	room_type.room_type_id,
    COUNT(room_booking.room_booking_room_type_id) AS NumberBooked,
    (room_type.room_type_base_quantity - COUNT(room_booking.room_booking_room_type_id)) AS RemainingAvailable,
    room_type.room_type_base_quantity AS BaseQuantity
    FROM room_type
INNER JOIN room_booking ON room_type.room_type_id = room_booking.room_booking_room_type_id
INNER JOIN hotel ON hotel.hotel_id = room_type.room_type_hotel_id
INNER JOIN booking ON room_booking.room_booking_booking_id = booking.booking_id
WHERE hotel.hotel_id = 11
AND 
@DateToCheck BETWEEN booking.booking_start_date AND DATE_ADD(booking.booking_start_date, INTERVAL booking.booking_duration DAY)
GROUP BY room_booking.room_booking_room_type_id;