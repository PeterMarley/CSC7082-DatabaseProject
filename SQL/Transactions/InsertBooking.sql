START TRANSACTION;

/*
3 main sections
    personel
    flights
    hotel
*/
	/********************************
    -- GET IDS FOR USE
    ********************************/
    
	-- Get Countries
    SELECT @NorthernIreland := country.country_id FROM country INNER JOIN country.country_location_name_id = location_name.location_name_id WHERE location_name.location_name = 'Northern Ireland';
    SELECT @England := country.country_id FROM country INNER JOIN country.country_location_name_id = location_name.location_name_id WHERE location_name.location_name = 'England';
    
	-- Get Titles
    SELECT @Mr := title.title_abbreviation FROM title WHERE title.title_abbreviation = 'Mr';
    SELECT @Mrs := title.title_abbreviation FROM title WHERE title.title_abbreviation = 'Mrs';
    
    /********************************
    -- GET FLIGHT IDS
    ********************************/
    
    SET @TargetDateTime = '2023-01-01 12:45:00';

    -- get airport ids
    SELECT @HomeAirportId := airport.airport_id, airport.airport_name FROM airport WHERE airport.airport_name LIKE '%Belfast%';
    SELECT @DestAirportId := airport.airport_id, airport.airport_name FROM airport WHERE airport.airport_name LIKE '%Greece%';

    -- get route id
    SELECT @OutboundRouteId := route.route_id, route.route_name FROM route WHERE route.departure_airport_id = @HomeAirportId AND route.arrival_airport_id = @DestAirportId;
    SELECT @ReturnRouteId := route.route_id, route.route_name FROM route WHERE route.departure_airport_id = @DestAirportId AND route.arrival_airport_id = @HomeAirportId;

    -- get the outbound flight of interest
    SELECT @OutboundFlightId := flight.flight_id, route.route_name, route_price.route_price_gbp ,flight.flight_reference, flight.flight_checkin_utc_datetime, flight.departure_utc_datetime, flight.arrival_utc_datetime
    FROM flight 
    INNER JOIN route ON route.route_id = flight.route_id
    INNER JOIN route_price ON route_price.route_price_route_id = route.route_id
    WHERE 
        DATEDIFF(flight.departure_utc_datetime, @TargetDateTime) = 0  AND flight.route_id = @OutboundRouteId
    AND
        flight.departure_utc_datetime BETWEEN route_price.route_price_valid_from_datetime AND route_price.route_price_valid_to_datetime
    LIMIT 1; -- user potentially given option to select particular outbound flight time on website
        
    -- get the return flight of interest
    SELECT @ReturnFlightId := flight.flight_id, route.route_name, route_price.route_price_gbp ,flight.flight_reference, flight.flight_checkin_utc_datetime, flight.departure_utc_datetime, flight.arrival_utc_datetime
    FROM flight 
    INNER JOIN route ON route.route_id = flight.route_id
    INNER JOIN route_price ON route_price.route_price_route_id = route.route_id
    WHERE 
        DATEDIFF(flight.departure_utc_datetime, @TargetDateTime) = 0  AND flight.route_id = @ReturnRouteId
    AND
        flight.departure_utc_datetime BETWEEN route_price.route_price_valid_from_datetime AND route_price.route_price_valid_to_datetime
    LIMIT 1; -- user potentially given option to select particular return flight time on website
    
   	/********************************
    -- INSERT PASSENGERS AND THEIR DETAILS
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
    
    -- insert booking contact
    	-- insert email
        -- insert address
        -- insert 
	-- accomodation
	-- insert booking
   
   	INSERT INTO booking (booking.booking_reference, booking.booking_duration, booking.total_cost_gbp, booking.booking_contact_id, booking.outbound_flight_id, booking.return_flight_id)
    VALUES ('RANDREF123', 1, 0, )
COMMIT;