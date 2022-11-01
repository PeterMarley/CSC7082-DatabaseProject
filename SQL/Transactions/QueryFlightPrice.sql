SET @DateTimeToCheck = '2023-01-01 03:00:00';
-- SET @DateTimeToCheck = '2023-01-01 14:00:00';
-- SET @DateTimeToCheck = '2023-01-01 21:00:00';
-- SET @DateTimeToCheck = '2023-01-02 12:20:00';

SET @RouteId = 10; -- 'Spain to Belfast'

SELECT 
	route_price.route_price_gbp AS FlightPrice,
    @DateTimeToCheck AS FlightDateTime,
    route_price.route_price_valid_from_datetime AS ValidFrom,
    route_price.route_price_valid_to_datetime AS ValidTo FROM route_price
INNER JOIN route ON route.route_id = route_price.route_price_route_id
WHERE route_price.route_price_route_id = @RouteId
AND @DateTimeToCheck BETWEEN route_price.route_price_valid_from_datetime AND route_price.route_price_valid_to_datetime
AND route.route_id = @RouteId;