START TRANSACTION;

	SET @CountryName = '';
	SET @CountryDesc = '';
    
    SET @TownCityName = '';
    
    SET @AddressLine1 = '';
    SET @AddressLine2 = '';
    SET @AddressPostcode = '';

	-- insert country
	INSERT INTO country (country.country_name, country.country_description)
	VALUES (@CountryName, @CountryDesc);
    
    SET @CountryId = LAST_INSERT_ID();
    
    -- insert town_city
    INSERT INTO town_city (town_city.town_city_name, town_city.town_city_country_id)
    VALUES (@TownCityName, @CountryId);
    
    SET @TownCityId = LAST_INSERT_ID();
    
    -- insert address
    INSERT INTO address (address.address_line_1, address.address_line_2, address.postcode, address.town_city_id)
    VALUES (@AddressLine1, @AddressLine2, @AddressPostcode, @TownCityId);

COMMIT;