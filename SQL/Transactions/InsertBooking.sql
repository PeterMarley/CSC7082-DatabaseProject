START TRANSACTION;

	/********************************
    -- GET COUNTRY AND TITLE IDS FOR USE
    ********************************/
    
	-- Get Countries
    SELECT @NorthernIreland := country.country_id FROM country INNER JOIN country.country_location_name_id = location_name.location_name_id WHERE location_name.location_name = 'Northern Ireland';
    SELECT @England := country.country_id FROM country INNER JOIN country.country_location_name_id = location_name.location_name_id WHERE location_name.location_name = 'England';
    
	-- Get Titles
    SELECT @Mr := title.title_abbreviation FROM title WHERE title.title_abbreviation = 'Mr';
    SELECT @Mrs := title.title_abbreviation FROM title WHERE title.title_abbreviation = 'Mrs';
    
    /********************************
    -- FLIGHTS
    ********************************/
    
    SET @TargetDateTime = '2023-01-01 12:45:00';

    -- get airport ids
    SELECT @HomeAirportId := airport.airport_id, airport.airport_name FROM airport WHERE airport.airport_name LIKE '%Belfast%';
    SELECT @DestAirportId := airport.airport_id, airport.airport_name FROM airport WHERE airport.airport_name LIKE '%Greece%';

    -- get route id
    SELECT @OutboundRouteId := route.route_id, route.route_name FROM route WHERE route.departure_airport_id = @HomeAirportId AND route.arrival_airport_id = @DestAirportId;
    SELECT @ReturnRouteId := route.route_id, route.route_name FROM route WHERE route.departure_airport_id = @DestAirportId AND route.arrival_airport_id = @HomeAirportId;

    -- get the outbound flight of interest
    SELECT @OutboundFlightId := flight.flight_id, route.route_name, @OutboundFlightPrice := route_price.route_price_gbp ,flight.flight_reference, flight.flight_checkin_utc_datetime, flight.departure_utc_datetime, flight.arrival_utc_datetime
    FROM flight 
    INNER JOIN route ON route.route_id = flight.route_id
    INNER JOIN route_price ON route_price.route_price_route_id = route.route_id
    WHERE DATEDIFF(flight.departure_utc_datetime, @TargetDateTime) = 0  
    AND flight.route_id = @OutboundRouteId
    AND flight.departure_utc_datetime BETWEEN route_price.route_price_valid_from_datetime AND route_price.route_price_valid_to_datetime
    LIMIT 1; -- user potentially given option to select particular outbound flight time on website
        
    -- get the return flight of interest
    SELECT @ReturnFlightId := flight.flight_id, route.route_name, @ReturnFlightPrice := route_price.route_price_gbp ,flight.flight_reference, flight.flight_checkin_utc_datetime, flight.departure_utc_datetime, flight.arrival_utc_datetime
    FROM flight 
    INNER JOIN route ON route.route_id = flight.route_id
    INNER JOIN route_price ON route_price.route_price_route_id = route.route_id
    WHERE DATEDIFF(flight.departure_utc_datetime, @TargetDateTime) = 0  
    AND flight.route_id = @ReturnRouteId
    AND flight.departure_utc_datetime BETWEEN route_price.route_price_valid_from_datetime AND route_price.route_price_valid_to_datetime
    LIMIT 1; -- user potentially given option to select particular return flight time on website
    
   	/********************************
    -- PERSONEL
    ********************************/
    
    -- insert passports
    INSERT INTO passport (passport.passport_number, passport.passport_expiry_date, passport.passport_country_id)
    VALUES ('PSP1234', '2025-11-22', @NorthernIreland);
    SET @Passport1 = LAST_INSERT_ID();
    
    INSERT INTO passport (passport.passport_number, passport.passport_expiry_date, passport.passport_country_id)
    VALUES ('PSP9874', '2030-03-03', @England);
    SET @Passport2 = LAST_INSERT_ID();
    
    INSERT INTO passport (passport.passport_number, passport.passport_expiry_date, passport.passport_country_id)
    VALUES ('5415454545', '2024-02-02', @England);
    SET @Passport3 = LAST_INSERT_ID();
    
    -- insert passengers
    INSERT INTO passenger (passenger.passenger_title_id, passenger.passenger_first_name, passenger.passenger_last_name, passenger.passenger_date_of_birth, passenger.passenger_passport_id)
    VALUES (@Mr, 'DemoPassenger1Fname', 'DemoPassenger1Sname', '1988-03-19', @Passport1);
    SET @Passenger1 = LAST_INSERT_ID();
    
    INSERT INTO passenger (passenger.passenger_title_id, passenger.passenger_first_name, passenger.passenger_last_name, passenger.passenger_date_of_birth, passenger.passenger_passport_id)
    VALUES (@Mrs, 'DemoPassenger2Fname', 'DemoPassenger2Sname', '1987-02-18', @Passport2);
    SET @Passenger2 = LAST_INSERT_ID();
    
    INSERT INTO passenger (passenger.passenger_title_id, passenger.passenger_first_name, passenger.passenger_last_name, passenger.passenger_date_of_birth, passenger.passenger_passport_id)
    VALUES (@Mrs, 'DemoPassenger3Fname', 'DemoPassenger3Sname', '1986-01-17', @Passport3);
    SET @Passenger3= LAST_INSERT_ID();
    
    -- assign booking contact (& insert their additional details)
    SELECT @Belfast := town_city.town_city_id FROM town_city WHERE town_city.town_city_name = 'Belfast';
    
    INSERT INTO address (address.address_line_1,address.address_line_2,address.postcode,address.county,address.town_city_id)
    VALUES ('BookContactAddressLine1', NULL, 'BTXX ZLZ', NULL, @Belfast);
    SET @BookingContactAddress = LAST_INSERT_ID();
    
    INSERT INTO email (email.email_address) VALUES ('booking@contact.mock');
    SET @BookingContactEmail = LAST_INSERT_ID();
    
	INSERT INTO booking_contact (booking_contact.booking_contact_address_id, booking_contact.booking_contact_passenger_id, booking_contact.booking_contact_email_id)
    VALUES (@BookingContactAddress, @Passenger1, @BookingContactEmail);
    SET @BookingContactId = LAST_INSERT_ID();
    
   	/********************************
    -- BOOKING
    ********************************/
    
    SET @HolidayNightsDuration = 1;
    
    -- insert booking
   	INSERT INTO booking (booking.booking_reference, booking.booking_duration, booking.total_cost_gbp, booking.booking_contact_id, booking.outbound_flight_id, booking.return_flight_id)
    VALUES ('RANDREF123', 1, 0, @BookingContactId, @OutboundFlightId, @ReturnFlightId);
    SET @BookingId = LAST_INSERT_ID();
    
    -- insert booking line items
    SELECT @LineItemHotelId := booking_line_item_type.booking_line_item_type_id FROM booking_line_item_type WHERE booking_line_item_type.booking_line_item_type_name = 'hotel';
    SELECT @LineItemOutboundFlightId := booking_line_item_type.booking_line_item_type_id FROM booking_line_item_type WHERE booking_line_item_type.booking_line_item_type_name = 'outbound flight';
    SELECT @LineItemReturnFlightId := booking_line_item_type.booking_line_item_type_id FROM booking_line_item_type WHERE booking_line_item_type.booking_line_item_type_name = 'return flight';

    INSERT INTO booking_line_item (booking_line_item.booking_line_item_price_gbp, booking_line_item.booking_line_item_type_id, booking_line_item.booking_line_item_booking_id)
    VALUES (NULL, @HotelId, @LineItemHotelId, @BookingId);
    
    SELECT @HotelId := hotel.hotel_id, hotel.hotel_name FROM hotel WHERE hotel.hotel_name = 'Spanish Hotel 1';

    -- get room type date/time based price

    SELECT @HotelRoomType1Id := room_type.room_type_id FROM room_type WHERE room_type.room_type_hotel_id = @HotelId AND room_type.room_type_name = 'Double or Twin room';
    SELECT @HotelRoomType2Id := room_type.room_type_id FROM room_type WHERE room_type.room_type_hotel_id = @HotelId AND room_type.room_type_name = 'Double or Twin room - Sleeps up to 3';
    SELECT @HotelRoomType3Id := room_type.room_type_id FROM room_type WHERE room_type.room_type_hotel_id = @HotelId AND room_type.room_type_name = 'Double or Twin room with Pool room';

    SELECT @HotelRoomType1Cost := room_type_price.room_type_price_gbp FROM room_type_price WHERE DATE(@TargetDateTime) BETWEEN room_type_price.room_type_price_valid_from__date AND room_type_price.room_type_price_valid_to_date AND room_type_price.room_type_id = @HotelRoomType1Id; -- passengers 1 and 2 to share

    SELECT @HotelRoomType2Cost := room_type_price.room_type_price_gbp FROM room_type_price WHERE DATE(@TargetDateTime) BETWEEN room_type_price.room_type_price_valid_from__date AND room_type_price.room_type_price_valid_to_date AND room_type_price.room_type_id = @HotelRoomType2Id; -- passenger 3

    -- get board cost

    SELECT @BoardType1Id := board_type.board_type_id FROM board_type WHERE board_type.board_type_name = 'All Inclusive';
    SELECT @BoardType2Id := board_type.board_type_id FROM board_type WHERE board_type.board_type_name = 'Bed And Breakfast';

    SELECT @HotelBoardType1Id := hotel_board_type.hotel_board_type_id, @HotelBoardType1Cost := hotel_board_type.hotel_board_fee_gbp FROM hotel_board_type WHERE hotel_board_type.hotel_id = @HotelId AND hotel_board_type.board_type_id = @BoardType1Id;
    SELECT @HotelBoardType2Id := hotel_board_type.hotel_board_type_id, @HotelBoardType2Cost := hotel_board_type.hotel_board_fee_gbp FROM hotel_board_type WHERE hotel_board_type.hotel_id = @HotelId AND hotel_board_type.board_type_id = @BoardType2Id;

    -- insert room_bookings
    INSERT INTO room_booking (room_booking.room_booking_room_type_id, room_booking.room_booking_booking_id)
    VALUES (@HotelRoomType1Id, @BookingId);

    INSERT INTO room_booking (room_booking.room_booking_room_type_id, room_booking.room_booking_booking_id)
    VALUES (@HotelRoomType2Id, @BookingId);
	
    /********************************
    -- BOOKING LINE ITEMS
    ********************************/
    -- hotel rooms (2 for this booking)
    INSERT INTO booking_line_item (booking_line_item.booking_line_item_price_gbp, booking_line_item.booking_line_item_type_id, booking_line_item.booking_line_item_booking_id)
    VALUES (@HotelRoomType1Cost, @LineItemHotelId, @HotelRoomType1Cost, @BookingId);
    
    INSERT INTO booking_line_item (booking_line_item.booking_line_item_price_gbp, booking_line_item.booking_line_item_type_id, booking_line_item.booking_line_item_booking_id)
    VALUES (@HotelRoomType2Cost, @LineItemHotelId, @HotelRoomType2Cost, @BookingId);
    
    -- flights, outbound and return for each passenger
    INSERT INTO booking_line_item (booking_line_item.booking_line_item_price_gbp, booking_line_item.booking_line_item_type_id, booking_line_item.booking_line_item_booking_id)
    VALUES 
        (@HotelRoomType1Cost,@LineItemHotelId,  @BookingId), -- hotel room 1 (including board cost)
        (@HotelRoomType2Cost, @LineItemHotelId, @BookingId), -- hotel room 2 (including board cost)
        (@OutboundFlightPrice, @LineItemOutboundFlightId, @BookingId), -- passenger 1 outbound flight
        (@OutboundFlightPrice, @LineItemOutboundFlightId, @BookingId), -- passenger 2 outbound flight
        (@OutboundFlightPrice, @LineItemOutboundFlightId, @BookingId), -- passenger 3 outbound flight
        (@OutboundFlightPrice, @LineItemReturnFlightId, @BookingId), -- passenger 1 return flight
        (@OutboundFlightPrice, @LineItemReturnFlightId, @BookingId), -- passenger 2 return flight
        (@OutboundFlightPrice, @LineItemReturnFlightId, @BookingId); -- passenger 3 return flight

	/********************************
    -- UPDATE BOOKING TOTAL PRICE
    ********************************/
    
    UPDATE 
    -- insert line items DONE
    -- insert booking contact DONE
    -- flights (stored via booking) DONE
	-- accomodation (stored via room_booking) DONE
	-- insert booking DONE
    -- update booking cost
COMMIT;