-- parameters gathered from jet2Holidays main search feature form
SET @OutboundDate = '2023-01-01';
SET @Duration = 2;
SET @HomeAirportId = 5; -- Belfast Internation Airport ID

-- parameter from website card shown above, changes for each card
SET @HotelId = 11; -- 'Spanish Hotel 1' Id

-- get route ids & compute return date
SET @AwayAirportId = (SELECT hotel.hotel_serving_airport_id FROM hotel WHERE hotel.hotel_id = @HotelId);
SET @OutboundRouteId = (SELECT route.route_id FROM route WHERE route.departure_airport_id = @HomeAirportId AND route.arrival_airport_id = @AwayAirportId);
SET @ReturnRouteId = (SELECT route.route_id FROM route WHERE route.departure_airport_id = @AwayAirportId AND route.arrival_airport_id = @HomeAirportId);
SET @ReturnDate = DATE_ADD(@OutboundDate, INTERVAL @Duration DAY);

-- outbound flight info query
SELECT 
	dep_airport.airport_name AS DepartureAirport,
    dep_airport.airport_iata_code AS DepartureAirportCode,
   	arr_airport.airport_name AS ArrivalAirport,
    arr_airport.airport_iata_code AS ArrivalAirportCode,
    flight.departure_utc_datetime AS DepartureTime,
    flight.arrival_utc_datetime AS ArrivalTime,
    TIMEDIFF(flight.arrival_utc_datetime, flight.departure_utc_datetime) AS Duration
FROM flight 
INNER JOIN route ON route.route_id = flight.route_id
INNER JOIN airport AS dep_airport ON dep_airport.airport_id = route.departure_airport_id
INNER JOIN airport AS arr_airport ON arr_airport.airport_id = route.arrival_airport_id
WHERE flight.route_id = @OutboundRouteId LIMIT 1;

-- return flight info query
SELECT
	dep_airport.airport_name AS DepartureAirport,
    dep_airport.airport_iata_code AS DepartureAirportCode,
   	arr_airport.airport_name AS ArrivalAirport,
    arr_airport.airport_iata_code AS ArrivalAirportCode,
    flight.departure_utc_datetime AS DepartureTime,
    flight.arrival_utc_datetime AS ArrivalTime,
    TIMEDIFF(flight.arrival_utc_datetime, flight.departure_utc_datetime) AS Duration
FROM flight 
INNER JOIN route ON route.route_id = flight.route_id
INNER JOIN airport AS dep_airport ON dep_airport.airport_id = route.departure_airport_id
INNER JOIN airport AS arr_airport ON arr_airport.airport_id = route.arrival_airport_id
WHERE flight.route_id = @ReturnRouteId LIMIT 1;