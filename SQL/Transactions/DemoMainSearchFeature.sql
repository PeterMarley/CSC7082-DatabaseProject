-- params needed
-- ---------------
-- departure airport
-- location
-- 		destination
-- 		region 
-- 		resort
-- departure date
-- nights
-- rooms
-- passengers
-- 		adults
-- 		children

-- the search feature requests a selection from departure airports so we shall query all UK airports to represent the list choices
SELECT airport.airport_id, airport.airport_name AS uk_airport FROM airport 
INNER JOIN address ON address.address_id = airport.airport_address_id
INNER JOIN town_city ON town_city.town_city_id = address.town_city_id
INNER JOIN country ON country.country_id = town_city.town_city_country_id
INNER JOIN location_name ON location_name.location_name_id = country.country_location_name_id
WHERE location_name.location_name = 'United Kingdom';

-- we shall simulate the airport selection of belfast international airport / id = 5 and resort selection of Benidorm and Calpe (in destination spain)
/*CREATE TEMPORARY TABLE resort_selection (resort_id int(11), resort_name varchar(255)); 
INSERT INTO resort_selection (SELECT resort.resort_id, resort.resort_name FROM resort
WHERE resort.resort_name LIKE '%Benidorm%' OR resort.resort_name LIKE '%Calpe%');
SELECT * FROM resort_selection;*/

-- simulate the main search destination drop down selections
SELECT destination_location.location_name AS destination_name, region.region_name, COUNT(DISTINCT resort.resort_name) AS number_of_resorts
FROM resort
INNER JOIN hotel ON hotel.hotel_resort_id = resort.resort_id
INNER JOIN region ON resort.resort_region_id = region.region_id
INNER JOIN destination ON region.region_destination_id = destination.destination_id
INNER JOIN location_name AS destination_location ON destination.destination_location_name_id = destination_location.location_name_id
GROUP BY region.region_id; -- note there is only 1 test hotel added at each location, aside from calpe, which has 2 for demonstration purposes

-- simulate the selection of multiple resorts are per the main search feature.


-- set the rest of the main search feature paramters.
SET @DepartureDate = CAST('2023-01-01' AS DATE);
SET @HolidayDuration = 2; -- 2 days
SET @PassengersAdult = 2;
SET @PassengersChild = 0;

CREATE TEMPORARY TABLE RoomsAvailable 
	(
        resort_name varchar(255),
     	hotel_name varchar(255), 
        room_type varchar(255), 
        total_of_rooms_available int(11), 
        number_of_rooms_booked_on_selected_dates int(11), 
        rooms_available_on_selected_dates int(11)
    );

/* -- DEMONSTRATE ROOM AVAILABILITY IN A VISIBLE MANNER - FOR ROOMS THAT HAVE AT LEAST ONE BOOKING
SELECT
	resort.resort_name,
	hotel.hotel_name, 
    room_type.room_type_name, 
    room_type.room_type_base_quantity AS total_of_rooms_available,
    COUNT(room_booking.room_booking_room_type_id) AS number_of_rooms_booked_on_selected_dates,
    room_type.room_type_base_quantity - COUNT(room_booking.room_booking_room_type_id) AS rooms_available_on_selected_dates
FROM room_type
LEFT JOIN room_booking ON room_booking.room_booking_room_type_id = room_type.room_type_id
INNER JOIN hotel ON hotel.hotel_id = room_type.room_type_hotel_id
INNER JOIN resort ON hotel.hotel_resort_id = resort.resort_id
INNER JOIN booking ON booking.booking_id = room_booking.room_booking_booking_id
WHERE CAST('2023-01-01' AS DATE) BETWEEN booking.booking_start_date AND DATE_ADD(booking.booking_start_date, INTERVAL booking.booking_duration DAY) 
GROUP BY room_type.room_type_id , room_type.room_type_base_quantity;
*/

-- room types that have booking, but have availability on intended dates of the holiday
INSERT INTO RoomsAvailable
SELECT
	/*room_type.room_type_sleeps_min,
    room_type.room_type_sleeps_max,
    room_type.room_type_sleeps_infants,*/
	resort.resort_name,
	hotel.hotel_name, 
    room_type.room_type_name, 
    room_type.room_type_base_quantity AS total_of_rooms_available,
    COUNT(room_booking.room_booking_room_type_id) AS number_of_rooms_booked_on_selected_dates,
    room_type.room_type_base_quantity - COUNT(room_booking.room_booking_room_type_id) AS rooms_available_on_selected_dates
FROM room_type
LEFT JOIN room_booking ON room_booking.room_booking_room_type_id = room_type.room_type_id
INNER JOIN hotel ON hotel.hotel_id = room_type.room_type_hotel_id
INNER JOIN resort ON hotel.hotel_resort_id = resort.resort_id
INNER JOIN booking ON booking.booking_id = room_booking.room_booking_booking_id
WHERE hotel.hotel_resort_id IN (SELECT resort.resort_id FROM resort WHERE resort.resort_name LIKE '%Benidorm%' OR resort.resort_name LIKE '%Calpe%')
AND CAST('2023-01-01' AS DATE) BETWEEN booking.booking_start_date AND DATE_ADD(booking.booking_start_date, INTERVAL booking.booking_duration DAY)
AND room_type.room_type_sleeps_min <= @PassengersAdult AND room_type.room_type_sleeps_max >= @PassengersAdult
AND 
	(
 		(@PassengersChild > 0 AND (room_type.room_type_sleeps_infants >= @PassengersChild))
 		OR (@PassengersChild = 0)
	)
GROUP BY room_type.room_type_id, room_type.room_type_base_quantity
HAVING room_type.room_type_base_quantity - COUNT(room_booking.room_booking_room_type_id) > 0;

SELECT * FROM RoomsAvailable;

/* -- DEMONSTRATE ROOM AVAILABILITY IN A VISIBLE MANNER - NO BOOKINGS
SELECT
	resort.resort_name,
    hotel.hotel_name, 
    room_type.room_type_name, 
    room_type.room_type_base_quantity AS total_of_rooms_available,
    0 AS number_of_rooms_booked_on_selected_dates, 
    room_type.room_type_base_quantity AS rooms_available_on_selected_dates	
FROM room_type
INNER JOIN hotel ON hotel.hotel_id = room_type.room_type_hotel_id
INNER JOIN resort ON hotel.hotel_resort_id = resort.resort_id
WHERE room_type.room_type_id NOT IN (SELECT room_booking.room_booking_room_type_id FROM room_booking);
*/

-- room types that have no bookings on required date, and therefore have full availabilty
INSERT INTO RoomsAvailable
SELECT
	/*room_type.room_type_sleeps_min,
    room_type.room_type_sleeps_max,
    room_type.room_type_sleeps_infants,*/
	resort.resort_name,
    hotel.hotel_name, 
    room_type.room_type_name, 
    room_type.room_type_base_quantity AS total_of_rooms_available,
    0 AS number_of_rooms_booked_on_selected_dates, 										-- specifically this query is looking for rooms with no bookings, so number of booked rooms will be zero
    room_type.room_type_base_quantity AS rooms_available_on_selected_dates	-- and so remaining rooms will equal base quantity
FROM room_type
INNER JOIN hotel ON hotel.hotel_id = room_type.room_type_hotel_id
INNER JOIN resort ON hotel.hotel_resort_id = resort.resort_id
WHERE room_type.room_type_id NOT IN (SELECT room_booking.room_booking_room_type_id FROM room_booking)
AND room_type.room_type_sleeps_min <= @PassengersAdult AND room_type.room_type_sleeps_max >= @PassengersAdult
AND 
	(
 		(@PassengersChild > 0 AND (room_type.room_type_sleeps_infants >= @PassengersChild))
 		OR @PassengersChild = 0
	)
AND hotel.hotel_resort_id IN (SELECT resort.resort_id FROM resort WHERE resort.resort_name LIKE '%Benidorm%' OR resort.resort_name LIKE '%Calpe%');
SELECT * FROM RoomsAvailable;