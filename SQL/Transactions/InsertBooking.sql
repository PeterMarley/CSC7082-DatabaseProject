/*************************
INSERT PASSENGERS
*************************/

-- passenger data
SET @PassengerTitle = 'Mr.';
SET @PassengerFirstName = 'John';
SET @PassengerLastName = 'Wayne';
SET @PassengerDateOfBirth = '01/10/1935';
SET @PassengerPassportCountry = 'Northern Ireland';
SET @PassengerPassportNumber = 'ABC123456789'; 
SET @PassengerPassportExpiry = '25/12/2030';
SELECT @PassengerTitleId := title.title_id FROM title WHERE title.title_abbreviation = @PassengerTitle; 
SELECT @PassengerAreaId := area.area_id FROM area WHERE area.area_name = @PassengerPassportCountry;

-- insert passport into database & retrieve Passport Id
INSERT INTO passport (passport.passport_number, passport.passport_expiry_date, passport.passport_area_id)
VALUES (@PassengerPassportNumber, @PassengerPassportExpiry, @PassengerAreaId);
SET @PassengerPassportId = LAST_INSERT_ID();

-- insert passenger
INSERT INTO passenger (passenger.passenger_first_name, passenger.passenger_last_name, passenger.passenger_date_of_birth, passenger.passenger_title_id, passenger.passenger_passport_id)
VALUES (@PassengerFirstName, @PassengerLastName, @PassengerDateOfBirth, @PassengerTitleId, @PassengerPassportId);


/*************************
INSERT BOOKING CONTACT  
*************************/

-- get booking contacts town city id
SELECT @BookingContactTownCityId := town_city.town_city_id FROM town_city
WHERE town_city.town_city_name = 'Bookcontact City';

-- insert booking contact address and retrieve key
INSERT INTO address (address.address_line_1, address.address_line_2, address.postcode, address.town_city_id)
VALUES ('1 Street Lane', 'VilleStreet', 'BTXX XYZ', @BookingContactTownCityId);
SET @BookingContactAddressId = LAST_INSERT_ID();

-- insert booking contact email address and retrieve key
INSERT INTO email (email.email_address) VALUES ('booking@contact.mock');
SET @BookingContactEmailId = LAST_INSERT_ID();

INSERT INTO booking_contact (booking_contact.booking_contact_address_id, booking_contact.booking_contact_passenger_id, booking_contact.booking_contact_email_id)
VALUES (@BookingContactAddressId, @BookingContactPassengerId, @BookingContactEmailId);

SET @BookingContactId = LAST_INSERT_ID();

/*************************
-- INSERT BOOKING
*************************/

SET @BookingReference = 'JT2134';
SET @TotalBookingCost = CALCULATE THIS;
SET @BookingContactId = SELECT THIS;
SET @ReturnFlightId = SELECT THIS;
SET @OutboundFlightId = SELECT THIS;

INSERT INTO booking 
	(booking.booking_reference,
     booking.total_cost_gbp,
     booking.booking_contact_id,
     booking.return_flight_id,
     booking.outbound_flight_id)
VALUES 
	(@BookingReference,
     @TotalBookingCost,
     @BookingContactId, --
     @ReturnFlightId,
     @OutboundFlightId);
     

        