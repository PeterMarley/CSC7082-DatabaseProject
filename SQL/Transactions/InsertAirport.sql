START TRANSACTION;
	SET @CountryName = 'Antartica';
	SET @CountryDesc = 'real cold hey';
	SET @TownCityName = 'Anty Town';
	SET @AddressLine1 = 'Dogville';
	SET @AddressLine2 = '';
	SET @AddressPostcode = 'BTXX XXX';
	SET @GpsLat = 90.0;
	SET @GpsLong = 180.0;
	SET @AirportName = 'Antarctica Airport';
	SET @AirportCode = 'ANT';

	INSERT INTO country (country.country_name, country.country_description)
	VALUES (@CountryName, @CountryDesc);

	SET @CountryId = LAST_INSERT_ID();

	INSERT INTO town_city (town_city.town_city_name, town_city.town_city_country_id)
	VALUES (@TownCityName, @CountryId);

	SET @TownCityId = LAST_INSERT_ID();

	INSERT INTO address (address.address_line_1, address.address_line_2, address.postcode, address.town_city_id)
	VALUES (@AddressLine1, @AddressLine2, @AddressPostcode, @TownCityId);

	SET @AddressId = LAST_INSERT_ID();

	INSERT INTO gps (gps.gps_latitude, gps.gps_longitude)
	VALUES (@GpsLat, @GpsLong);

	SET @GpsId = LAST_INSERT_ID();

	INSERT INTO airport (airport.airport_name, airport.airport_iata_code, airport.airport_gps_id, airport.airport_address_id)
	VALUES (@AirportName, @AirportCode, @GpsId, @AddressId);
COMMIT;