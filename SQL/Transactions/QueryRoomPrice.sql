-- dont copy paste
SET @TargetDate = '2023-01-01';
SET @HolidayNightsDuration = 1;
-- -----------

SELECT @HotelId := hotel.hotel_id, hotel.hotel_name FROM hotel WHERE hotel.hotel_name = 'Spanish Hotel 1';

-- get room type date/time based price

SELECT @HotelRoomType1Id := room_type.room_type_id FROM room_type WHERE room_type.room_type_hotel_id = @HotelId AND room_type.room_type_name = 'Double or Twin room';
SELECT @HotelRoomType2Id := room_type.room_type_id FROM room_type WHERE room_type.room_type_hotel_id = @HotelId AND room_type.room_type_name = 'Double or Twin room - Sleeps up to 3';
SELECT @HotelRoomType3Id := room_type.room_type_id FROM room_type WHERE room_type.room_type_hotel_id = @HotelId AND room_type.room_type_name = 'Double or Twin room with Pool room';

SELECT room_type_price.room_type_price_gbp FROM room_type_price WHERE @TargetDate BETWEEN room_type_price.room_type_price_valid_from__date AND room_type_price.room_type_price_valid_to_date AND room_type_price.room_type_id = @HotelRoomType1Id;

-- get board cost

SELECT @BoardType1Id := board_type.board_type_id FROM board_type WHERE board_type.board_type_name = 'All Inclusive';
SELECT @BoardType2Id := board_type.board_type_id FROM board_type WHERE board_type.board_type_name = 'Bed And Breakfast';

SELECT @HotelBoardType1Id := hotel_board_type.hotel_board_type_id, @HotelBoardType1Cost := hotel_board_type.hotel_board_fee_gbp FROM hotel_board_type WHERE hotel_board_type.hotel_id = @HotelId AND hotel_board_type.board_type_id = @BoardType1Id;
SELECT @HotelBoardType2Id := hotel_board_type.hotel_board_type_id, @HotelBoardType2Cost := hotel_board_type.hotel_board_fee_gbp FROM hotel_board_type WHERE hotel_board_type.hotel_id = @HotelId AND hotel_board_type.board_type_id = @BoardType2Id;

