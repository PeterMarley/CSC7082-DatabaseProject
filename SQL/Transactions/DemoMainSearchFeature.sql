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
SELECT airport.airport_id, airport.airport_name FROM airport 
INNER JOIN address ON address.address_id = airport.airport_address_id
INNER JOIN town_city ON town_city.town_city_id = address.town_city_id
INNER JOIN country ON country.country_id = town_city.town_city_country_id
INNER JOIN location_name ON location_name.location_name_id = country.country_location_name_id
WHERE location_name = 'United Kingdom';

-- we shall simulate the airport selection of belfast international airport / id = 5
SET @DepartureAirportId = 5;

-- the main search feature allows the location to be selected as either of the following: (I shall demonstrate all 3)
SET @LocationDestinationId = 33;	-- Name: "Spain"
SET @LocationRegionId = 1; 			-- Name: "Costa Blanca"
SET @LocationResortId = 1; 			-- Name: "Benidorm"

-- simulate the main search destination drop down selections
SELECT destination_location.location_name AS destination_name, region.region_name, resort.resort_name, COUNT(DISTINCT hotel.hotel_id) AS HotelCount
FROM resort
INNER JOIN hotel ON hotel.hotel_resort_id = resort.resort_id
INNER JOIN region ON resort.resort_region_id = region.region_id
INNER JOIN destination ON region.region_destination_id = destination.destination_id
INNER JOIN location_name AS destination_location ON destination.destination_location_name_id = destination_location.location_name_id
GROUP BY resort.resort_id; -- note there is only 1 test hotel added at each location, aside from calpe, which has 2 for demonstration purposes

-- simulate the selection of multiple resorts are per the main search feature.
CREATE TEMPORARY TABLE resort_selection (resort_id int(11), resort_name varchar(255)); -- to store resort ids return from resort drop down
INSERT INTO resort_selection (SELECT resort.resort_id, resort.resort_name FROM resort
WHERE resort.resort_name LIKE '%Benidorm%' OR resort.resort_name LIKE '%Calpe%');
SELECT * FROM resort_selection;

-- set the rest of the main search feature paramters.
SET @DepartureDate = CAST('2023-01-01' AS DATE);
SET @HolidayDuration = 2; -- 2 days
SET @PassengersAdult = 2;
SET @PassengersChild = 0;


/* select all hotels in selected resorts and the room availabilty of the rooms therein, this data would 
 allow filtering by developers of website, to show only hotels with rooms available. */
SELECT 
	resort.resort_name,
	hotel.hotel_name,
    room_type.room_type_name,
    room_type.room_type_base_quantity AS BaseQuantity,
    COUNT(room_booking.room_booking_room_type_id) AS NumberBooked,
    (room_type.room_type_base_quantity - COUNT(room_booking.room_booking_room_type_id)) AS RemainingAvailable,
    room_type.room_type_sleeps_min AS MinAdults,
    room_type.room_type_sleeps_max AS MaxAdults,
    room_type.room_type_sleeps_infants AS AllowedInfants
FROM room_type
INNER JOIN hotel ON hotel.hotel_id = room_type.room_type_hotel_id
INNER JOIN resort ON resort.resort_id = hotel.hotel_resort_id
LEFT JOIN room_booking ON room_type.room_type_id = room_booking.room_booking_room_type_id
WHERE hotel.hotel_resort_id IN (SELECT resort_id FROM resort_selection)
GROUP BY room_type.room_type_id
ORDER BY resort.resort_name;
-- NOTE THE ABOVE REQUIRES MORE WORK ON DATE SELECTION