START TRANSACTION;

	/********************************
    -- GET COUNTRY AND TITLE IDS FOR USE
    ********************************/
    
	-- Get Countries
    SELECT @UnitedKingdom := country.country_id FROM country INNER JOIN location_name ON country.country_location_name_id = location_name.location_name_id WHERE location_name.location_name = 'United Kingdom';
    
	-- Get Titles
    SELECT @Mr := title.title_id FROM title WHERE title.title_abbreviation = 'Mr';
    SELECT @Mrs := title.title_id FROM title WHERE title.title_abbreviation = 'Mrs';
    
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
    VALUES ('DemoPPNumber1', '2025-11-22', @UnitedKingdom);
    SET @Passport1 = LAST_INSERT_ID();
    
    INSERT INTO passport (passport.passport_number, passport.passport_expiry_date, passport.passport_country_id)
    VALUES ('DemoPPNumber2', '2030-03-03', @UnitedKingdom);
    SET @Passport2 = LAST_INSERT_ID();
    
    INSERT INTO passport (passport.passport_number, passport.passport_expiry_date, passport.passport_country_id)
    VALUES ('DemoPPNumber3', '2024-02-02', @UnitedKingdom);
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
    
    SELECT @TelephoneTypeHomeOfficeId := telephone_type.telephone_type_id FROM telephone_type WHERE telephone_type.telephone_type_name = 'Home/ Office';
    SELECT @TelephoneTypeMobileId := telephone_type.telephone_type_id FROM telephone_type WHERE telephone_type.telephone_type_name = 'Mobile';
    SELECT @TelephoneTypeEmergencyId := telephone_type.telephone_type_id FROM telephone_type WHERE telephone_type.telephone_type_name = 'Emergency';

    INSERT INTO telephone (telephone.telephone_number, telephone.telephone_type_id) VALUES ('1234578', @TelephoneTypeHomeOfficeId);
    SET @Telephone1 = LAST_INSERT_ID();

    INSERT INTO telephone (telephone.telephone_number, telephone.telephone_type_id) VALUES ('+44 098765412', @TelephoneTypeMobileId);
    SET @Telephone2 = LAST_INSERT_ID();

    INSERT INTO telephone (telephone.telephone_number, telephone.telephone_type_id) VALUES ('0-800-emergency', @TelephoneTypeEmergencyId);
    SET @Telephone3 = LAST_INSERT_ID();

    INSERT INTO booking_contact_telephone (booking_contact_telephone.booking_contact_telephone_booking_contact_id, booking_contact_telephone.booking_contact_telephone_telephone_id)
    VALUES 
        (@BookingContactId, @Telephone1),
        (@BookingContactId, @Telephone2),
        (@BookingContactId, @Telephone3);

    -- booking passenger payment card
    SET @PaymentCardSecret = 'JoeSatrianiIsTheBest'; -- weak secret, for demo purposes
    SELECT @CardVendorId := card_vendor.card_vendor_id FROM card_vendor WHERE card_vendor.card_vendor_name = 'visa'; 

    INSERT INTO payment_card (payment_card.payment_card_long_number, payment_card.payment_card_expiry_date, payment_card.booking_contact_id, payment_card.card_vendor_id)
    VALUES (AES_ENCRYPT('1234 1234 5678 5678', @PaymentCardSecret), AES_ENCRYPT('2030-01-01', @PaymentCardSecret), @BookingContactId, @CardVendorId);
    SET @PaymentCardId = LAST_INSERT_ID();

   	/********************************
    -- BOOKING
    ********************************/
    
    SET @HolidayNightsDuration = 1;
    
    -- insert booking
   	INSERT INTO booking 
        (
            booking.booking_reference,
            booking.booking_start_date,
            booking.booking_duration,
            booking.total_cost_gbp,
            booking.booking_contact_id,
            booking.outbound_flight_id,
            booking.return_flight_id
        )
    VALUES ('RANDREF123', DATE(@TargetDateTime), 1, 0, @BookingContactId, @OutboundFlightId, @ReturnFlightId);
    SET @BookingId = LAST_INSERT_ID();
    
    -- insert booking line items
    SELECT @LineItemHotelId := booking_line_item_type.booking_line_item_type_id FROM booking_line_item_type WHERE booking_line_item_type.booking_line_item_type_name = 'hotel';
    SELECT @LineItemOutboundFlightId := booking_line_item_type.booking_line_item_type_id FROM booking_line_item_type WHERE booking_line_item_type.booking_line_item_type_name = 'outbound flight';
    SELECT @LineItemReturnFlightId := booking_line_item_type.booking_line_item_type_id FROM booking_line_item_type WHERE booking_line_item_type.booking_line_item_type_name = 'return flight';
    SELECT @LineItemHotelBoardId := booking_line_item_type.booking_line_item_type_id FROM booking_line_item_type WHERE booking_line_item_type.booking_line_item_type_name = 'board';
    
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
    INSERT INTO room_booking (room_booking.room_booking_room_type_id, room_booking.room_booking_booking_id, room_booking.room_booking_hotel_board_type_id)
    VALUES (@HotelRoomType1Id, @BookingId, @HotelBoardType1Id);

    INSERT INTO room_booking (room_booking.room_booking_room_type_id, room_booking.room_booking_booking_id, room_booking.room_booking_hotel_board_type_id)
    VALUES (@HotelRoomType2Id, @BookingId, @HotelBoardType2Id);

    INSERT INTO booking_passenger (booking_passenger.booking_passenger_booking_id, booking_passenger.booking_passenger_passenger_id)
    VALUES 
        (@BookingId, @Passenger1),
        (@BookingId, @Passenger2),
        (@BookingId, @Passenger3);
	
    /********************************
    -- BOOKING LINE ITEMS
    ********************************/

    -- flights, outbound and return for each passenger
    INSERT INTO booking_line_item (booking_line_item.booking_line_item_price_gbp, booking_line_item.booking_line_item_type_id, booking_line_item.booking_line_item_booking_id)
    VALUES 
        (@HotelRoomType1Cost,@LineItemHotelId,  @BookingId), -- hotel room 1 (excluding board cost)
        (@HotelRoomType2Cost, @LineItemHotelId, @BookingId), -- hotel room 2 (excluding board cost)
        (@HotelBoardType1Cost, @LineItemHotelBoardId, @BookingId), -- hotel room 1 board cost
        (@HotelBoardType2Cost, @LineItemHotelBoardId, @BookingId), -- hotel room 2 board cost
        (@OutboundFlightPrice, @LineItemOutboundFlightId, @BookingId), -- passenger 1 outbound flight cost
        (@OutboundFlightPrice, @LineItemOutboundFlightId, @BookingId), -- passenger 2 outbound flight cost
        (@OutboundFlightPrice, @LineItemOutboundFlightId, @BookingId), -- passenger 3 outbound flight cost
        (@ReturnFlightPrice, @LineItemReturnFlightId, @BookingId), -- passenger 1 return flight cost
        (@ReturnFlightPrice, @LineItemReturnFlightId, @BookingId), -- passenger 2 return flight cost
        (@ReturnFlightPrice, @LineItemReturnFlightId, @BookingId); -- passenger 3 return flight cost

	/********************************
    -- UPDATE BOOKING TOTAL PRICE
    ********************************/

    -- gather total cost from line items
    SELECT @BookingTotalCost := SUM(booking_line_item.booking_line_item_price_gbp) FROM booking_line_item WHERE booking_line_item.booking_line_item_booking_id = @BookingId;
    
    UPDATE booking SET booking.total_cost_gbp = @BookingTotalCost WHERE booking.booking_id = @BookingId;
    -- insert line items DONE
    -- insert booking contact DONE
    -- flights (stored via booking) DONE
	-- accomodation (stored via room_booking) DONE
	-- insert booking DONE
    -- update booking cost


    /********************************
    -- LEAVE A REVIEW (likely done post-holiday)
    ********************************/

    SELECT @ReviewRatingId := review_rating.review_rating_id FROM review_rating WHERE review_rating.review_rating = 3;

    INSERT INTO review (review.review_content, review.reviewer_id, review.review_rating_id)
    VALUES ('Was Ok. Crocodiles were a tad bitey.', @BookingContactId, @ReviewRatingId);

    /********************************
    -- LEAVE A REVIEW (likely done post-holiday)
    ********************************/

    INSERT INTO payment (payment.payment_amount_gbp, payment.booking_id, payment.payment_card_id) 
    VALUES ('1000', @BookingId, @PaymentCardId);
COMMIT;