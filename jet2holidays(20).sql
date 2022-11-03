-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 03, 2022 at 01:20 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `jet2holidays`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `uspEncryptText` (IN `StrToEncrypt` VARCHAR(1000))   BEGIN
    DECLARE Salt int(11);
    DECLARE SaltedHash text;
    DECLARE EncryptedValue varbinary(1000);

    SET Salt = SUBSTRING(SHA1(RAND()), 1, 6);
    SET SaltedHash = SHA1(CONCAT(Salt, StrToEncrypt));
    SET EncryptedValue = CONCAT(Salt, SaltedHash);

	SELECT EncryptedValue;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertPaymentCard` (IN `CardNum` VARCHAR(255), IN `CardExpiryDate` DATE, IN `BookingContactId` INT, IN `CardVendorId` INT)   BEGIN
    DECLARE Secret varchar(255);
    SET Secret = 'JoeSatrianiIsTheBest';

    INSERT INTO payment_card
        (
            payment_card.payment_card_long_number, 
            payment_card.payment_card_expiry_date, 
            payment_card.booking_contact_id, 
            payment_card.card_vendor_id
        )
    VALUES 
        (
            AES_ENCRYPT(CardNum, Secret),
            AES_ENCRYPT(CardExpiryDate, Secret),
            BookingContactId,
            CardVendorId
        );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspQueryFlightPrice_byFlightId` (IN `FlightId` INT)   SELECT route_price.route_price_gbp AS FlightCost 
FROM route_price
INNER JOIN route 
	ON route.route_id = route_price.route_price_route_id
INNER JOIN flight 
	ON flight.route_id = route.route_id
WHERE 
	flight.flight_id = FlightId
AND 
	flight.departure_utc_datetime BETWEEN 
    	route_price.route_price_valid_from_datetime
        AND
        route_price.route_price_valid_to_datetime$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspQueryHotels` ()   SELECT hotel.hotel_name, region.region_name, location_name.location_name
FROM hotel
INNER JOIN resort ON resort.resort_id = hotel.hotel_resort_id
INNER JOIN region ON region.region_id = resort.resort_region_id
INNER JOIN destination ON destination.destination_id = region.region_destination_id
INNER JOIN location_name ON location_name.location_name_id = destination.destination_location_name_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspQueryPaymentCard` (IN `PaymentCardId` INT)   BEGIN
	DECLARE Secret varchar(255);  
    SET Secret = 'JoeSatrianiIsTheBest';
    
    SELECT 
        AES_DECRYPT(payment_card.payment_card_long_number, Secret),
        CONVERT(AES_DECRYPT(payment_card.payment_card_expiry_date, Secret), date),
        payment_card.booking_contact_id,
        payment_card.card_vendor_id
    FROM payment_card
    WHERE 
        payment_card.payment_card_id = PaymentCardId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspQueryRegionDescriptor_byName` (IN `RegionName` VARCHAR(255))   SELECT 
	region_descriptor.region_descriptor_title AS Title,
    region_descriptor.region_descriptor_body AS Body 
FROM `region_descriptor`
WHERE 
	region_descriptor.region_descriptor_region_id IN
	(
        SELECT region_id 
     	FROM region 
     	WHERE region.region_name = RegionName
    )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspQueryRoomFacilities` (IN `RoomTypeId` INT)   SELECT 
	hotel.hotel_name AS HotelName,
    room_type.room_type_name AS RoomTypeName,
    room_facility.room_facility_name AS HotelFacilityName 
FROM `room_type_facility`
INNER JOIN room_type ON 
	room_type.room_type_id = room_type_facility.room_type_id
INNER JOIN room_facility ON 
	room_facility.room_facility_id = room_type_facility.room_facility_id
INNER JOIN hotel ON 
	hotel.hotel_id = room_type.room_type_hotel_id
WHERE 
	room_type.room_type_id = RoomTypeId$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspQueryRoomTypePriceOnDate` (IN `DateToQuery` DATE, IN `RoomTypeId` INT)   SELECT 
	room_type_price.room_type_price_gbp AS RoomTypePrice,
    DateToQuery AS `Date`,
    room_type.room_type_name AS RoomTypeName,
    hotel.hotel_name AS HotelName
FROM room_type_price
INNER JOIN room_type 
	ON room_type.room_type_id = room_type_price.room_type_id
INNER JOIN hotel
	ON hotel.hotel_id = room_type.room_type_hotel_id
WHERE 
	DateToQuery BETWEEN 
    	room_type_price.room_type_price_valid_from__date
    	AND
        room_type_price.room_type_price_valid_to_date
AND 
	room_type.room_type_id = RoomTypeId$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `WIPuspCreateBooking` ()   SELECT SUM(combined.price_gbp) FROM booking
RIGHT JOIN room_booking ON booking.booking_id = room_booking.room_booking_booking_id 
LEFT JOIN room ON room.room_id = room_booking.room_booking_room_id
LEFT JOIN room_type ON room_type.room_type_id = room.room_type_id
LEFT JOIN room_type_price ON room_type_price.room_type_id = room.room_id
WHERE booking.booking_id = '1'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `WIPuspInsertPassword_encrypt` (IN `CardLongNum` TEXT, IN `CardExpiryDate` DATE, IN `BookingContactId` INT, IN `CardVendorId` INT)   BEGIN
    DECLARE CardNumSalt int(11);
    DECLARE CardNumSaltedHash text;
    DECLARE CardNumEncrypted varbinary(1000);
    
    DECLARE CardExpirySalt int(11);
    DECLARE CardExpirySaltedHash date;
    DECLARE CardExpiryEncrypted varbinary(1000);

    SET CardNumSalt = SUBSTRING(SHA1(RAND()), 1, 6);
    SET CardNumSaltedHash = SHA1(CONCAT(CardNumSalt, CardLongNum));
    SET CardNumEncrypted = CONCAT(CardNumSalt, CardNumSaltedHash);

	SET CardExpirySalt = SUBSTRING(SHA1(RAND()), 1, 6);
    SET CardExpirySaltedHash = SHA1(CONCAT(CardExpirySalt, CONVERT(CardExpiryDate, date)));
    SET CardExpiryEncrypted = CONCAT(CardExpirySalt, CardExpirySaltedHash);
    
    INSERT INTO payment_card 
        (
            payment_card.payment_card_long_number,
            payment_card.payment_card_expiry_date,
            payment_card.booking_contact_id,
            payment_card.card_vendor_id
        )
    VALUES
        (CardNumEncrypted,CardExpiryEncrypted,BookingContactId,CardVendorId);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `WIPuspQueryPassword_decrypt` (IN `payment_card_id_in` INT, OUT `payment_card_id` INT, OUT `paymeny_card_long_number` TEXT, OUT `paymeny_card_expiry_date` DATE, OUT `booking_contact_id` INT, OUT `card_vendor_id` INT)   BEGIN
	
	SELECT * FROM payment_card;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `address_id` int(11) NOT NULL,
  `address_line_1` varchar(255) NOT NULL,
  `address_line_2` varchar(255) DEFAULT NULL,
  `postcode` varchar(255) NOT NULL,
  `county` varchar(255) DEFAULT NULL,
  `town_city_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`address_id`, `address_line_1`, `address_line_2`, `postcode`, `county`, `town_city_id`) VALUES
(12, 'Belfastairport Road', 'Belairportsville', 'BT00 0TX', NULL, 10),
(13, 'Ibizairport Road', 'Ibairportsville', '001122', NULL, 15),
(14, 'Greeceairport Road', NULL, 'XXXYYYZZZ', NULL, 16),
(15, 'Turkeyairport Road', 'Turkportsville', '123987XY', 'Turkcounty', 17),
(16, 'Tenerifeairport Road', 'Tenerportsville', '11 223X', NULL, 18),
(17, 'Spanish Hotel1 lineaddressline1', 'Spanish Hotel1 lineaddressline2', 'VDFV45645', 'Hotel County', 19),
(18, 'Spanish Hotel2 lineaddressline1', NULL, 'GBNF5646', NULL, 20),
(19, 'Spanish Hotel3 lineaddressline1', NULL, 'BDFB43543453543', 'SpanishHotel3lineaddressline1', 21),
(20, 'Turkish Hotel1 lineaddressline1', 'Turkish Hotel1 lineaddressline2', 'BGFB456456 435', NULL, 22),
(21, 'Greek Hotel1 lineaddressline1', NULL, 'dsfdsf-5656AS', NULL, 23),
(22, 'Greek Hotel2 lineaddressline1', 'Greek Hotel2 lineaddressline2', 'GBDFBDF45454545', 'GreekHotel2county', 24),
(23, 'Passenger1 AddressLine1', 'Passenger1 AddressLine2', 'P1AL', 'MockCounty', 10),
(24, 'Passenger2 AddressLine1', NULL, 'P2AL', 'MockCounty', 10),
(36, 'BookContactAddressLine1', NULL, 'BTXX ZLZ', NULL, 10),
(37, 'Spanishairport road', 'spanport', 'SAR123', NULL, 21),
(47, 'BookContactAddressLine1', NULL, 'BTXX ZLZ', NULL, 10),
(48, 'DemoBookContactAddressLine1', NULL, 'BTXX ZLZ', NULL, 10),
(49, 'Glasgowport road', NULL, 'GPR XXX', NULL, 12),
(50, 'placeholder address 1', 'placeholder address 1', 'placeholder address 1', 'placeholder address 1', 19),
(51, 'DemoBookContactAddressLine1', NULL, 'BTXX ZLZ', NULL, 10);

-- --------------------------------------------------------

--
-- Table structure for table `airport`
--

CREATE TABLE `airport` (
  `airport_id` int(11) NOT NULL,
  `airport_name` varchar(255) NOT NULL,
  `airport_iata_code` varchar(3) NOT NULL,
  `airport_gps_id` int(11) NOT NULL,
  `airport_address_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `airport`
--

INSERT INTO `airport` (`airport_id`, `airport_name`, `airport_iata_code`, `airport_gps_id`, `airport_address_id`) VALUES
(5, 'Belfast International Airport', 'BFS', 11, 12),
(6, 'Ibiza Mock Airport', 'IMA', 12, 13),
(7, 'Greece Mock Airport\r\n', 'GMA', 14, 14),
(8, 'Turkey Mock Airport\r\n', 'TMA', 15, 15),
(9, 'Tenerife Mock Airport\r\n', 'TEA', 16, 16),
(10, 'Spanish Mock Airport', 'SMA', 18, 37),
(11, 'Glasgow Mock Airport', 'GLM', 21, 49);

-- --------------------------------------------------------

--
-- Table structure for table `board_type`
--

CREATE TABLE `board_type` (
  `board_type_id` int(11) NOT NULL,
  `board_type_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `board_type`
--

INSERT INTO `board_type` (`board_type_id`, `board_type_name`) VALUES
(1, 'Self Catering'),
(2, 'All Inclusive'),
(3, 'Bed And Breakfast'),
(4, 'Half Board Plus'),
(5, 'Full Board Plus'),
(6, 'Half Board'),
(7, 'Full Board');

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `booking_id` int(11) NOT NULL,
  `booking_reference` varchar(255) NOT NULL,
  `booking_made_utc_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `booking_start_date` date NOT NULL,
  `booking_duration` int(11) DEFAULT 1,
  `total_cost_gbp` decimal(13,4) NOT NULL,
  `booking_contact_id` int(11) NOT NULL,
  `return_flight_id` int(11) NOT NULL,
  `outbound_flight_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`booking_id`, `booking_reference`, `booking_made_utc_datetime`, `booking_start_date`, `booking_duration`, `total_cost_gbp`, `booking_contact_id`, `return_flight_id`, `outbound_flight_id`) VALUES
(18, 'PREVBOOKINGREF1', '2022-11-01 00:25:50', '2023-01-01', 1, '1086.5700', 23, 23, 19),
(19, 'DEMOBOOKING-REF', '2022-11-01 00:36:28', '2023-01-01', 2, '1173.2400', 24, 25, 19),
(20, 'NONSENSE NOISE', '2022-11-02 18:11:16', '2023-01-01', 2, '595.5900', 25, 25, 19);

-- --------------------------------------------------------

--
-- Table structure for table `booking_contact`
--

CREATE TABLE `booking_contact` (
  `booking_contact_id` int(11) NOT NULL,
  `booking_contact_address_id` int(11) NOT NULL,
  `booking_contact_passenger_id` int(11) NOT NULL,
  `booking_contact_email_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `booking_contact`
--

INSERT INTO `booking_contact` (`booking_contact_id`, `booking_contact_address_id`, `booking_contact_passenger_id`, `booking_contact_email_id`) VALUES
(23, 47, 70, 48),
(24, 48, 74, 49),
(25, 51, 78, 50);

-- --------------------------------------------------------

--
-- Table structure for table `booking_contact_telephone`
--

CREATE TABLE `booking_contact_telephone` (
  `booking_contact_telephone_id` int(11) NOT NULL,
  `booking_contact_telephone_booking_contact_id` int(11) NOT NULL,
  `booking_contact_telephone_telephone_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `booking_contact_telephone`
--

INSERT INTO `booking_contact_telephone` (`booking_contact_telephone_id`, `booking_contact_telephone_booking_contact_id`, `booking_contact_telephone_telephone_id`) VALUES
(13, 23, 80),
(14, 23, 81),
(15, 23, 82),
(16, 24, 83),
(17, 24, 84),
(18, 24, 85),
(19, 25, 86),
(20, 25, 87),
(21, 25, 88);

-- --------------------------------------------------------

--
-- Table structure for table `booking_line_item`
--

CREATE TABLE `booking_line_item` (
  `booking_line_item_id` int(11) NOT NULL,
  `booking_line_item_price_gbp` decimal(13,4) NOT NULL,
  `booking_line_item_type_id` int(11) NOT NULL,
  `booking_line_item_booking_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `booking_line_item`
--

INSERT INTO `booking_line_item` (`booking_line_item_id`, `booking_line_item_price_gbp`, `booking_line_item_type_id`, `booking_line_item_booking_id`) VALUES
(1, '123.1200', 1, 18),
(2, '23.4500', 1, 18),
(3, '150.0000', 4, 18),
(4, '25.0000', 4, 18),
(5, '125.2500', 2, 18),
(6, '125.2500', 2, 18),
(7, '125.2500', 2, 18),
(8, '125.2500', 2, 18),
(9, '66.0000', 3, 18),
(10, '66.0000', 3, 18),
(11, '66.0000', 3, 18),
(12, '66.0000', 3, 18),
(13, '67.6700', 1, 19),
(14, '23.4500', 1, 19),
(15, '150.0000', 4, 19),
(16, '25.0000', 4, 19),
(17, '67.6700', 1, 19),
(18, '23.4500', 1, 19),
(19, '150.0000', 4, 19),
(20, '25.0000', 4, 19),
(21, '125.2500', 2, 19),
(22, '125.2500', 2, 19),
(23, '125.2500', 2, 19),
(24, '125.2500', 2, 19),
(25, '35.0000', 3, 19),
(26, '35.0000', 3, 19),
(27, '35.0000', 3, 19),
(28, '35.0000', 3, 19),
(29, '67.6700', 1, 20),
(30, '150.0000', 4, 20),
(31, '67.6700', 1, 20),
(32, '150.0000', 4, 20),
(33, '125.2500', 2, 20),
(34, '35.0000', 3, 20);

-- --------------------------------------------------------

--
-- Table structure for table `booking_line_item_type`
--

CREATE TABLE `booking_line_item_type` (
  `booking_line_item_type_id` int(11) NOT NULL,
  `booking_line_item_type_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `booking_line_item_type`
--

INSERT INTO `booking_line_item_type` (`booking_line_item_type_id`, `booking_line_item_type_name`) VALUES
(1, 'hotel'),
(2, 'outbound flight'),
(3, 'return flight'),
(4, 'board');

-- --------------------------------------------------------

--
-- Table structure for table `booking_passenger`
--

CREATE TABLE `booking_passenger` (
  `booking_passenger_id` int(11) NOT NULL,
  `booking_passenger_booking_id` int(11) NOT NULL,
  `booking_passenger_passenger_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `booking_passenger`
--

INSERT INTO `booking_passenger` (`booking_passenger_id`, `booking_passenger_booking_id`, `booking_passenger_passenger_id`) VALUES
(1, 18, 70),
(2, 18, 71),
(3, 18, 72),
(4, 18, 73),
(5, 19, 74),
(6, 19, 75),
(7, 19, 76),
(8, 19, 77),
(9, 20, 78);

-- --------------------------------------------------------

--
-- Table structure for table `card_vendor`
--

CREATE TABLE `card_vendor` (
  `card_vendor_id` int(11) NOT NULL,
  `card_vendor_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `card_vendor`
--

INSERT INTO `card_vendor` (`card_vendor_id`, `card_vendor_name`) VALUES
(3, 'visa-electron'),
(4, 'mastercard'),
(5, 'switch'),
(6, 'americanexpress'),
(7, 'visa');

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE `country` (
  `country_id` int(11) NOT NULL,
  `country_location_name_id` int(11) DEFAULT NULL,
  `country_primary_language_id` int(11) NOT NULL,
  `country_primary_currency_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`country_id`, `country_location_name_id`, `country_primary_language_id`, `country_primary_currency_id`) VALUES
(7, 1, 1, 1),
(8, 2, 2, 2),
(9, 3, 4, 1),
(10, 4, 5, 1),
(11, 5, 6, 4),
(12, 6, 7, 1);

-- --------------------------------------------------------

--
-- Table structure for table `currency`
--

CREATE TABLE `currency` (
  `currency_id` int(11) NOT NULL,
  `currency_name` varchar(255) NOT NULL,
  `currency_symbol` varchar(10) NOT NULL,
  `currency_code` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `currency`
--

INSERT INTO `currency` (`currency_id`, `currency_name`, `currency_symbol`, `currency_code`) VALUES
(1, 'Euro\r\n', '€', 'EUR'),
(2, 'Turkish Lira\r\n', '₺', 'TRY'),
(4, 'Great British Pounds\r\n', '£', 'GBP');

-- --------------------------------------------------------

--
-- Table structure for table `destination`
--

CREATE TABLE `destination` (
  `destination_id` int(11) NOT NULL,
  `destination_description` text NOT NULL,
  `destination_location_name_id` int(11) NOT NULL,
  `destination_country_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `destination`
--

INSERT INTO `destination` (`destination_id`, `destination_description`, `destination_location_name_id`, `destination_country_id`) VALUES
(33, 'Spire-studded skylines, crop-covered countryside, sugar-scented boulangeries… say ‘bonjour’ to a petit place named France. Famed for its food, its fashion, its arts – there’s nothing this super chic spot hasn’t mastered. And when it comes to its resorts, well, they’re second to none. Take your pick between teal-coloured coastlines and unmissable cities, each one as magical as the last… ', 1, 7),
(34, 'Majorca, Ibiza, Menorca – they’re all legends in the holiday hotspot stakes. A giant waterpark and miles of sandy coast are just the tip of Majorca’s top attractions. Meanwhile, Ibiza serves up a mix of full-on clubbing and idyllic natural beauty. And Menorca’s all about peaceful, family-friendly holidays. Sun-kissed good times are ensured wherever you set foot.', 7, 7),
(35, 'Deserts, epic volcanoes and breathtaking mountains sit side-by-side on the spectacular Canary Islands. Year-round sun and average temps in the twenties make the quartet of Tenerife, Lanzarote, Gran Canaria and Fuerteventura a popular spot for classic beach breaks. Each one’s a firm favourite for different reasons – think wine tasting, surfing mighty waves, experiencing neon-lit nightlife and conquering incredible peaks.', 8, 7),
(36, 'Holidays to Turkey (Türkiye) are all about lazing on gold-sand beaches, tucking into chargrilled kebabs, sipping cocktails at swish marinas... and much more. Yes, there are many sides to this beautiful country, as it’s the ultimate bridge between the east and west. That means you can flip between seeing ancient wonders, experiencing mesmerising coastline and exploring chic shopping malls all in one holiday to Turkey (Türkiye).', 2, 8),
(37, 'With sunny climates, idyllic islands and culture aplenty, holidays to Greece offer guaranteed good times. From the secluded beaches of Lefkas, to the historic hub of the Peloponnese, the seafront resorts of Crete to the buzzing nightlife of Zante, Greece holidays will never disappoint. Check out some of the most picturesque destinations the country has to offer.', 6, 12);

-- --------------------------------------------------------

--
-- Table structure for table `email`
--

CREATE TABLE `email` (
  `email_id` int(11) NOT NULL,
  `email_address` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `email`
--

INSERT INTO `email` (`email_id`, `email_address`) VALUES
(2, 'kfolli0@surveymonkey.com'),
(3, 'vworrill1@huffingtonpost.com'),
(4, 'onorvel2@alexa.com'),
(5, 'fbriar3@dailymail.co.uk'),
(6, 'tburroughes4@com.com'),
(7, 'johnwayne@mock.com'),
(8, 'tkilbane6@nasa.gov'),
(9, 'sorme7@webeden.co.uk'),
(10, 'oblaza8@sbwire.com'),
(11, 'bgarvan9@networksolutions.com'),
(12, 'brutledgea@mac.com'),
(13, 'jgrishinb@statcounter.com'),
(14, 'stumiotoc@ezinearticles.com'),
(15, 'asymsd@t.co'),
(16, 'civashchenkoe@cmu.edu'),
(17, 'mstebbinf@nature.com'),
(18, 'sbartolomeonig@chicagotribune.com'),
(19, 'wnaruph@booking.com'),
(20, 'pdallmani@netscape.com'),
(21, 'cethridgej@de.vu'),
(22, 'bturpink@plala.or.jp'),
(23, 'ttregearl@sbwire.com'),
(24, 'roddam@e-recht24.de'),
(25, 'pmorillan@tinyurl.com'),
(26, 'tfullerdo@techcrunch.com'),
(48, 'prevbooking@prevcontact.prevmock'),
(49, 'Demobooking@Democontact.Demomock'),
(50, 'Demobooking@Democontact.Demomock');

-- --------------------------------------------------------

--
-- Table structure for table `flight`
--

CREATE TABLE `flight` (
  `flight_id` int(11) NOT NULL,
  `flight_reference` varchar(255) NOT NULL,
  `flight_checkin_utc_datetime` datetime NOT NULL,
  `departure_utc_datetime` datetime NOT NULL,
  `arrival_utc_datetime` datetime NOT NULL,
  `route_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `flight`
--

INSERT INTO `flight` (`flight_id`, `flight_reference`, `flight_checkin_utc_datetime`, `departure_utc_datetime`, `arrival_utc_datetime`, `route_id`) VALUES
(1, 'JT1', '2022-12-31 22:00:00', '2023-01-01 00:20:00', '2023-01-01 02:00:00', 1),
(2, 'JT2', '2023-01-01 10:00:01', '2023-01-01 12:20:01', '2023-01-01 14:20:01', 1),
(3, 'JT3', '2022-12-31 21:00:00', '2023-01-01 00:30:00', '2023-01-01 00:45:00', 2),
(4, 'JT4', '2023-01-01 10:00:01', '2023-01-01 12:20:01', '2023-01-01 14:20:01', 2),
(5, 'JT3', '2022-12-31 22:00:00', '2023-01-01 00:20:00', '2023-01-01 02:00:00', 3),
(6, 'JT4', '2023-01-01 10:00:01', '2023-01-01 12:20:01', '2023-01-01 14:20:01', 3),
(7, 'JT5', '2022-12-31 21:00:00', '2023-01-01 00:30:00', '2023-01-01 00:45:00', 4),
(8, 'JT6', '2023-01-01 10:00:01', '2023-01-01 12:20:01', '2023-01-01 14:20:01', 4),
(9, 'JT7', '2022-12-31 22:00:00', '2023-01-01 00:20:00', '2023-01-01 02:00:00', 5),
(10, 'JT8', '2023-01-01 10:00:01', '2023-01-01 12:20:01', '2023-01-01 14:20:01', 5),
(11, 'JT9', '2022-12-31 21:00:00', '2023-01-01 00:30:00', '2023-01-01 00:45:00', 6),
(12, 'JT10', '2023-01-01 10:00:01', '2023-01-01 12:20:01', '2023-01-01 14:20:01', 6),
(13, 'JT11', '2022-12-31 22:00:00', '2023-01-01 00:20:00', '2023-01-01 02:00:00', 7),
(14, 'JT12', '2023-01-01 10:00:01', '2023-01-01 12:20:01', '2023-01-01 14:20:01', 7),
(15, 'JT13', '2022-12-31 21:00:00', '2023-01-01 00:30:00', '2023-01-01 00:45:00', 8),
(16, 'JT14', '2023-01-01 10:00:01', '2023-01-01 12:20:01', '2023-01-01 14:20:01', 8),
(17, 'FlightAvailabilityModelDemoAM', '2022-12-31 23:30:00', '2023-01-01 00:15:00', '2023-01-01 02:15:00', 1),
(18, 'FlightAvailabilityModelDemoPM', '2023-01-01 14:25:00', '2023-01-01 15:25:00', '2022-10-30 17:25:00', 1),
(19, 'JT15', '2023-01-01 00:05:00', '2023-01-01 00:20:00', '2023-01-01 02:00:00', 9),
(20, 'JT16', '2023-01-01 10:00:01', '2023-01-01 12:20:01', '2023-01-01 14:20:01', 9),
(21, 'JT17', '2023-01-01 00:05:00', '2023-01-01 00:30:00', '2023-01-01 02:45:00', 10),
(22, 'JT18', '2023-01-01 10:00:01', '2023-01-01 12:20:01', '2023-01-01 14:20:01', 10),
(23, 'JT17', '2023-01-01 00:05:00', '2023-01-02 00:25:00', '2023-01-02 00:50:00', 10),
(24, 'JT18', '2023-01-01 10:00:01', '2023-01-02 12:22:01', '2023-01-02 14:40:01', 10),
(25, 'DEMO RETURN FLIGHT 1', '2023-01-03 00:25:00', '2023-01-03 01:30:00', '2023-01-03 02:35:00', 10),
(26, 'DEMO RETURN FLIGHT 2', '2023-01-03 18:30:00', '2023-01-03 19:00:00', '2023-01-03 20:30:00', 10);

-- --------------------------------------------------------

--
-- Table structure for table `gps`
--

CREATE TABLE `gps` (
  `gps_id` int(11) NOT NULL,
  `gps_latitude` decimal(8,6) NOT NULL,
  `gps_longitude` decimal(9,6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `gps`
--

INSERT INTO `gps` (`gps_id`, `gps_latitude`, `gps_longitude`) VALUES
(11, '-8.996518', '125.508314'),
(12, '24.489685', '105.093908'),
(13, '6.995512', '79.882999'),
(14, '38.962259', '-9.385554'),
(15, '36.406224', '55.016269'),
(16, '40.699993', '-112.011867'),
(17, '31.982984', '120.246992'),
(18, '48.019573', '66.923684'),
(19, '55.818252', '37.347767'),
(20, '50.578744', '35.788819'),
(21, '39.382286', '48.350173'),
(22, '15.267941', '102.851484'),
(23, '24.466675', '112.626495'),
(24, '36.685038', '117.071494'),
(25, '-6.959600', '113.196500'),
(26, '22.060541', '112.837815'),
(27, '41.150307', '-8.197896'),
(28, '16.712405', '98.574665'),
(29, '1.045287', '33.799254'),
(30, '24.241077', '117.655804');

-- --------------------------------------------------------

--
-- Table structure for table `hotel`
--

CREATE TABLE `hotel` (
  `hotel_id` int(11) NOT NULL,
  `hotel_name` varchar(255) NOT NULL,
  `hotel_description` text NOT NULL,
  `hotel_additional_info` text DEFAULT NULL,
  `hotel_lift_count` int(11) NOT NULL,
  `hotel_floor_count` int(11) NOT NULL,
  `hotel_block_count` int(11) DEFAULT NULL,
  `hotel_serving_airport_id` int(11) NOT NULL,
  `hotel_resort_id` int(11) NOT NULL,
  `hotel_gps_id` int(11) NOT NULL,
  `hotel_address_id` int(11) NOT NULL,
  `hotel_star_rating_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `hotel`
--

INSERT INTO `hotel` (`hotel_id`, `hotel_name`, `hotel_description`, `hotel_additional_info`, `hotel_lift_count`, `hotel_floor_count`, `hotel_block_count`, `hotel_serving_airport_id`, `hotel_resort_id`, `hotel_gps_id`, `hotel_address_id`, `hotel_star_rating_id`) VALUES
(11, 'Spanish Hotel 1', 'Spanish Hotel 1 desc', 'Spanish Hotel 1 additional info', 1, 2, 4, 10, 1, 30, 17, 13),
(12, 'Spanish Hotel 2', 'Spanish Hotel 2 desc', NULL, 4, 7, NULL, 10, 2, 29, 18, 11),
(13, 'Spanish Hotel 3', 'Spanish Hotel 3 desc', 'Spanish Hotel 3 additional info', 5, 5, NULL, 10, 3, 26, 19, 11),
(14, 'Turkish Hotel 1', 'Turkish Hotel 1 desc', NULL, 0, 1, 2, 8, 9, 21, 20, 13),
(15, 'Greek Hotel 1', 'Greek Hotel 1 desc', NULL, 10, 20, NULL, 7, 7, 19, 21, 15),
(16, 'Greek Hotel 2', 'Greek Hotel 2 desc', 'Greek Hotel 2 additional info', 1, 2, NULL, 7, 8, 14, 22, 13),
(17, 'Benidorm Placeholder hotel 1', 'Benidorm Placeholder hotel 1', 'Benidorm Placeholder hotel 1', 1, 1, NULL, 10, 2, 28, 50, 13);

-- --------------------------------------------------------

--
-- Table structure for table `hotel_board_type`
--

CREATE TABLE `hotel_board_type` (
  `hotel_board_type_id` int(11) NOT NULL,
  `hotel_board_fee_gbp` decimal(13,4) NOT NULL,
  `board_type_description` text DEFAULT NULL,
  `board_type_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `hotel_board_type`
--

INSERT INTO `hotel_board_type` (`hotel_board_type_id`, `hotel_board_fee_gbp`, `board_type_description`, `board_type_id`, `hotel_id`) VALUES
(1, '150.0000', 'The All Inclusive package includes buffet-style breakfast, lunch and dinner in the main restaurant. Snacks are available at selected times between meals for a minimum of 3hrs per day. Local wine, beer, spirits and non-alcoholic drinks are available from 10:00 until 24:00.', 2, 11),
(2, '25.0000', NULL, 3, 11);

-- --------------------------------------------------------

--
-- Table structure for table `hotel_bullet`
--

CREATE TABLE `hotel_bullet` (
  `hotel_bullet_id` int(11) NOT NULL,
  `hotel_bullet` text NOT NULL,
  `hotel_bullet_hotel_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `hotel_bullet`
--

INSERT INTO `hotel_bullet` (`hotel_bullet_id`, `hotel_bullet`, `hotel_bullet_hotel_id`) VALUES
(4, 'New for Summer 2023', 11),
(5, 'Recently refurbished', 11),
(6, 'Amazing sea views', 11);

-- --------------------------------------------------------

--
-- Table structure for table `hotel_facility`
--

CREATE TABLE `hotel_facility` (
  `hotel_facility_id` int(11) NOT NULL,
  `hotel_facility_hotel_id` int(11) NOT NULL,
  `hotel_facility_type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `hotel_facility`
--

INSERT INTO `hotel_facility` (`hotel_facility_id`, `hotel_facility_hotel_id`, `hotel_facility_type_id`) VALUES
(1, 11, 2),
(2, 11, 3);

-- --------------------------------------------------------

--
-- Table structure for table `hotel_facility_bullet`
--

CREATE TABLE `hotel_facility_bullet` (
  `hotel_facility_bullet_id` int(11) NOT NULL,
  `hotel_facility_bullet_title` varchar(255) DEFAULT NULL,
  `hotel_facility_bullet_body` text DEFAULT NULL,
  `hotel_facility_bullet_hotel_facility_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `hotel_facility_bullet`
--

INSERT INTO `hotel_facility_bullet` (`hotel_facility_bullet_id`, `hotel_facility_bullet_title`, `hotel_facility_bullet_body`, `hotel_facility_bullet_hotel_facility_id`) VALUES
(1, 'A La Carte', 'A la carte. Serves a range of international, Spanish and local cuisine for lunch and dinner. Show cooking at dinner and lunch. Please note that a dress code applies.', 1),
(2, 'Buffet', 'Buffet. Serves breakfast, lunch and dinner with show cooking. Please note that the hotel requests that beach wear is not worn.', 1),
(3, 'Bar', 'Lounge bar. Serves food.', 1),
(4, NULL, 'Outdoor freshwater pool. Sunbathing area with sunbeds and parasols. Towels (refundable deposit) (open between 01 Apr and 15 Nov).', 2);

-- --------------------------------------------------------

--
-- Table structure for table `hotel_facility_image`
--

CREATE TABLE `hotel_facility_image` (
  `hotel_facility_image_id` int(11) NOT NULL,
  `hotel_facility_image_url` text NOT NULL,
  `hotel_facility_image_alt_text` varchar(255) NOT NULL,
  `hotel_facility_image_hotel_facility_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `hotel_facility_image`
--

INSERT INTO `hotel_facility_image` (`hotel_facility_image_id`, `hotel_facility_image_url`, `hotel_facility_image_alt_text`, `hotel_facility_image_hotel_facility_id`) VALUES
(1, 'http://dummyimage.com/209x100.png/5fa2dd/ffffff', 'Phasellus in felis.', 1),
(2, 'http://dummyimage.com/142x100.png/5fa2dd/ffffff', 'Phasellus in felis.', 1),
(3, 'http://dummyimage.com/182x100.png/dddddd/000000', 'In hac habitasse platea dictumst.', 2),
(4, 'http://dummyimage.com/172x100.png/ff4444/ffffff', 'Nulla ut erat id mauris vulputate elementum.', 2),
(5, 'http://dummyimage.com/229x100.png/cc0000/ffffff', 'Praesent id massa id nisl venenatis lacinia.', 2),
(6, 'http://dummyimage.com/150x100.png/ff4444/ffffff', 'Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 2),
(7, 'http://dummyimage.com/172x100.png/cc0000/ffffff', 'Nulla facilisi.', 2),
(8, 'http://dummyimage.com/148x100.png/cc0000/ffffff', 'Vestibulum ac est lacinia nisi venenatis tristique.', 1),
(9, 'http://dummyimage.com/224x100.png/ff4444/ffffff', 'Curabitur at ipsum ac tellus semper interdum.', 1),
(10, 'http://dummyimage.com/160x100.png/cc0000/ffffff', 'Nullam sit amet turpis elementum ligula vehicula consequat.', 2),
(11, 'http://dummyimage.com/228x100.png/cc0000/ffffff', 'Aliquam non mauris.', 1),
(12, 'http://dummyimage.com/242x100.png/5fa2dd/ffffff', 'In hac habitasse platea dictumst.', 1),
(13, 'http://dummyimage.com/165x100.png/cc0000/ffffff', 'Sed ante.', 1),
(14, 'http://dummyimage.com/220x100.png/5fa2dd/ffffff', 'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', 1),
(15, 'http://dummyimage.com/228x100.png/dddddd/000000', 'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 2),
(16, 'http://dummyimage.com/171x100.png/ff4444/ffffff', 'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 1),
(17, 'http://dummyimage.com/117x100.png/5fa2dd/ffffff', 'Nulla justo.', 2),
(18, 'http://dummyimage.com/110x100.png/5fa2dd/ffffff', 'Morbi a ipsum.', 2),
(19, 'http://dummyimage.com/226x100.png/ff4444/ffffff', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.', 2),
(20, 'http://dummyimage.com/249x100.png/dddddd/000000', 'Curabitur gravida nisi at nibh.', 1);

-- --------------------------------------------------------

--
-- Table structure for table `hotel_facility_type`
--

CREATE TABLE `hotel_facility_type` (
  `hotel_facility_type_id` int(11) NOT NULL,
  `hotel_facility_type_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `hotel_facility_type`
--

INSERT INTO `hotel_facility_type` (`hotel_facility_type_id`, `hotel_facility_type_name`) VALUES
(1, 'Board Basis'),
(2, 'Restaurants & Bars '),
(3, 'Pool Areas'),
(4, 'Sports & Leisure '),
(5, 'Entertainment '),
(6, 'Children\'s Facilities '),
(7, 'Other');

-- --------------------------------------------------------

--
-- Table structure for table `hotel_image`
--

CREATE TABLE `hotel_image` (
  `hotel_image_id` int(11) NOT NULL,
  `hotel_image_url` text NOT NULL,
  `hotel_image_alt_text` varchar(255) NOT NULL,
  `hotel_image_hotel_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `hotel_image`
--

INSERT INTO `hotel_image` (`hotel_image_id`, `hotel_image_url`, `hotel_image_alt_text`, `hotel_image_hotel_id`) VALUES
(2, 'http://dummyimage.com/152x100.png/5fa2dd/ffffff', 'Nulla ac enim.', 11),
(3, 'http://dummyimage.com/198x100.png/dddddd/000000', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.', 11),
(4, 'http://dummyimage.com/136x100.png/dddddd/000000', 'Sed vel enim sit amet nunc viverra dapibus.', 11),
(5, 'http://dummyimage.com/207x100.png/cc0000/ffffff', 'Morbi non quam nec dui luctus rutrum.', 11),
(6, 'http://dummyimage.com/146x100.png/dddddd/000000', 'Duis ac nibh.', 11),
(7, 'http://dummyimage.com/233x100.png/cc0000/ffffff', 'Duis at velit eu est congue elementum.', 11),
(8, 'http://dummyimage.com/124x100.png/dddddd/000000', 'In hac habitasse platea dictumst.', 11),
(9, 'http://dummyimage.com/221x100.png/ff4444/ffffff', 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.', 11),
(10, 'http://dummyimage.com/160x100.png/5fa2dd/ffffff', 'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 11),
(11, 'http://dummyimage.com/150x100.png/dddddd/000000', 'Mauris ullamcorper purus sit amet nulla.', 11),
(12, 'http://dummyimage.com/138x100.png/ff4444/ffffff', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', 11),
(13, 'http://dummyimage.com/201x100.png/ff4444/ffffff', 'Sed ante.', 11),
(14, 'http://dummyimage.com/212x100.png/dddddd/000000', 'In hac habitasse platea dictumst.', 11),
(15, 'http://dummyimage.com/164x100.png/ff4444/ffffff', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.', 11),
(16, 'http://dummyimage.com/109x100.png/ff4444/ffffff', 'Integer tincidunt ante vel ipsum.', 11),
(17, 'http://dummyimage.com/213x100.png/cc0000/ffffff', 'Morbi ut odio.', 11),
(18, 'http://dummyimage.com/244x100.png/dddddd/000000', 'Curabitur convallis.', 11),
(19, 'http://dummyimage.com/241x100.png/ff4444/ffffff', 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.', 11),
(20, 'http://dummyimage.com/185x100.png/dddddd/000000', 'Integer ac leo.', 11),
(21, 'http://dummyimage.com/123x100.png/ff4444/ffffff', 'Sed accumsan felis.', 11);

-- --------------------------------------------------------

--
-- Table structure for table `language`
--

CREATE TABLE `language` (
  `language_id` int(11) NOT NULL,
  `language_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `language`
--

INSERT INTO `language` (`language_id`, `language_name`) VALUES
(1, 'Spanish\r\n'),
(2, 'Turkish\r\n'),
(4, 'German\r\n'),
(5, 'French\r\n'),
(6, 'English'),
(7, 'Greek');

-- --------------------------------------------------------

--
-- Table structure for table `location_name`
--

CREATE TABLE `location_name` (
  `location_name_id` int(11) NOT NULL,
  `location_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `location_name`
--

INSERT INTO `location_name` (`location_name_id`, `location_name`) VALUES
(1, 'Spain'),
(2, 'Turkey'),
(3, 'Germany'),
(4, 'France'),
(5, 'United Kingdom'),
(6, 'Greece'),
(7, 'Balearics'),
(8, 'Canary Islands');

-- --------------------------------------------------------

--
-- Table structure for table `passenger`
--

CREATE TABLE `passenger` (
  `passenger_id` int(11) NOT NULL,
  `passenger_first_name` varchar(255) NOT NULL,
  `passenger_last_name` varchar(255) NOT NULL,
  `passenger_date_of_birth` date NOT NULL,
  `passenger_title_id` int(11) NOT NULL,
  `passenger_passport_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `passenger`
--

INSERT INTO `passenger` (`passenger_id`, `passenger_first_name`, `passenger_last_name`, `passenger_date_of_birth`, `passenger_title_id`, `passenger_passport_id`) VALUES
(1, 'John\r\n', 'Wayne\r\n', '1953-06-01', 3, 1),
(2, 'Keanu\r\n', 'Reeves\r\n', '1979-07-05', 3, 2),
(3, 'Clare\r\n', 'Churchill\r\n', '1945-01-05', 4, 3),
(4, 'Donna\r\n', 'Data\r\n', '1992-02-28', 5, 5),
(70, 'PrevPassenger1Fname', 'PrevPassenger1Sname', '1988-03-19', 3, 67),
(71, 'PrevPassenger2Fname', 'PrevPassenger2Sname', '1987-02-18', 5, 68),
(72, 'PrevPassenger3Fname', 'PrevPassenger3Sname', '1986-01-17', 5, 69),
(73, 'PrevPassenger4Fname', 'PrevPassenger4Sname', '1986-01-17', 5, 70),
(74, 'DemoPassenger1Fname', 'DemoPassenger1Sname', '1988-03-19', 3, 71),
(75, 'DemoPassenger2Fname', 'DemoPassenger2Sname', '1987-02-18', 5, 72),
(76, 'DemoPassenger3Fname', 'DemoPassenger3Sname', '1986-01-17', 5, 73),
(77, 'DemoPassenger4Fname', 'DemoPassenger4Sname', '1986-01-17', 5, 74),
(78, 'DemoPassenger1Fname', 'DemoPassenger1Sname', '1988-03-19', 3, 75);

-- --------------------------------------------------------

--
-- Table structure for table `passport`
--

CREATE TABLE `passport` (
  `passport_id` int(11) NOT NULL,
  `passport_number` varchar(255) NOT NULL,
  `passport_expiry_date` date NOT NULL,
  `passport_country_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `passport`
--

INSERT INTO `passport` (`passport_id`, `passport_number`, `passport_expiry_date`, `passport_country_id`) VALUES
(1, 'NAB456789\r\n', '2030-10-01', 11),
(2, 'BKR8945645\r\n', '2035-12-15', 11),
(3, 'QW899997785\r\n', '2023-06-02', 11),
(5, 'A54841354\r\n', '2025-09-08', 9),
(67, 'PrevPPNumber1', '2025-11-22', 11),
(68, 'PrevPPNumber2', '2030-03-03', 11),
(69, 'PrevPPNumber3', '2024-02-02', 11),
(70, 'PrevPPNumber4', '2024-02-02', 11),
(71, 'DemoPPNumber1', '2025-11-22', 11),
(72, 'DemoPPNumber2', '2030-03-03', 11),
(73, 'DemoPPNumber3', '2024-02-02', 11),
(74, 'DemoPPNumber4', '2024-02-02', 11),
(75, 'DemoPPNumber1', '2025-11-22', 11);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL,
  `payment_amount_gbp` decimal(13,4) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `payment_card_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`payment_id`, `payment_amount_gbp`, `booking_id`, `payment_card_id`) VALUES
(7, '200.0000', 18, 25),
(8, '450.0000', 19, 26),
(9, '3.0000', 20, 27);

-- --------------------------------------------------------

--
-- Table structure for table `payment_card`
--

CREATE TABLE `payment_card` (
  `payment_card_id` int(11) NOT NULL,
  `payment_card_long_number` varbinary(255) NOT NULL,
  `payment_card_expiry_date` varbinary(255) NOT NULL,
  `booking_contact_id` int(11) NOT NULL,
  `card_vendor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `payment_card`
--

INSERT INTO `payment_card` (`payment_card_id`, `payment_card_long_number`, `payment_card_expiry_date`, `booking_contact_id`, `card_vendor_id`) VALUES
(25, 0x474305a046fc8469e9422b7aadd6377aa189606aad1b668c94183af6112a9f25, 0x0bc40a341635264de550582c0d9edcf1, 23, 7),
(26, 0xd1cb0c8d20fe5aa38a8b624e06b34ff6ff9f01136fbf9b463de02d930eb1e5a2, 0x6e2bf122cea4c8ef7f7ca2af9ac08ef3, 24, 7),
(27, 0x65c66d3f1a17e2312a51e464c9f91862a189606aad1b668c94183af6112a9f25, 0xa2ae170721cc1eaea9a5554068be8ed0, 25, 7);

-- --------------------------------------------------------

--
-- Table structure for table `region`
--

CREATE TABLE `region` (
  `region_id` int(11) NOT NULL,
  `region_name` varchar(255) NOT NULL,
  `region_description` text NOT NULL,
  `region_time_difference_utc` varchar(255) NOT NULL,
  `region_destination_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `region`
--

INSERT INTO `region` (`region_id`, `region_name`, `region_description`, `region_time_difference_utc`, `region_destination_id`) VALUES
(1, 'Costa Blanca', 'With larger-than-life Benidorm taking centre stage, this iconic Costa is a playground for pleasure-seekers of all ages, all year round. Blue Flag beaches, boat trips, wineries, great golf courses, tonnes of pubs – it’s all here. And you can’t beat a bit of sequin-splashed cabaret or tapas in the Old Town. That’s why it’s such a winner for stag and hen parties. Further up the coast, authentic Spanish scenes await in Calpe and Albir. Plus, there are the lantern-lit bars and art galleries of Alicante to discover, while the nearby mountains hide natural wonders, year-round cycle routes and secret villages. Whether you’re a first-timer or have been holidaying here for years, you’ll find this old-school favourite hasn’t lost its charm.', '+2', 33),
(2, 'Costa Del Sol', 'The Costa del Sol’s been a Brit hit for years – and rightly so. The favourites of Torremolinos and Benalmadena promise traditional fun and then some. That’s thanks to their miles of sun-drenched sands, oodles of exciting attractions and heaps of British restaurants and chiringuitos serving barbecued feasts. Over in modern Marbella and Puerto Banus, things get much glitzier. High-end, renovated hotels, sleek marinas and celeb-soaked bars make for the perfect party scene. Estepona is great if you’re into golf, while whitewashed Nerja slows the pace with buckets of old-school charm. Over winter, the sun’s still going strong and the good times keep rolling.\r\n', '+2', 33),
(3, 'Antalya', 'A stunning natural landscape and amazing ancient ruins provide a backdrop to stylish resorts bursting with sun-kissed beaches and great-value, luxury hotels. Combining age-old traditions with modern attractions, Antalya’s captivating coastline blends the best of both worlds for the perfect slice of Turkey. And the beaches here are some of the finest in the country, so get ready to sprawl out on the sand with a side of sensational views to boot. As for the resorts, Lara Beach shows off Cancun-style entertainment, Side is top for history and Belek is all about the golf. It’s the perfect playground for pleasure seekers and culture vultures alike. ', '+2 summer/ +1 winter', 36),
(4, 'Dalaman', 'Delve into Dalaman to discover a place where pine-clad mountains meet sparkling seascapes and there’s a typically Turkish feel wherever you go. Make the oh-so-dreamy Blue Lagoon in Olu Deniz top of your list and keep your eyes peeled for turtles at Iztuzu Beach. Head to Marmaris and you’re guaranteed fun. By day, try your hand at haggling in the Grand Bazaar and by night, enjoy the buzz of Bar Street. Meanwhile, Icmeler is a picturesque plot with a family-flavoured feel. And don’t miss the  tombs and mud baths of Dalyan. Whether you want to relax, party or explore, Dalaman has every type of holiday covered. ', '+2', 36),
(5, 'Kos\r\n', 'Part of the showstopping Dodecanese Islands, Kos has long been a favourite for sunshine holidays. Here you have the choice of lively party towns, laid-back seaside resorts and traditional fishing villages – all of them boasting beautiful beaches and dishing up heavenly traditional cuisine. Like history? It\'s got heaps of it. This is an island where centuries-old relics neighbour vibrant bars and buzzy promenades.', '+3', 37),
(6, 'Zante', 'Just off the south-west tip of mainland Greece, Zante is a glimmering Ionian jewel, where families come to relax, clubbers come to dance and sea turtles come to nest. Coves of curving azure water and sun-speckled sand are where you\'ll want to spend all your days. After a resort with a lively vibe? Laganas is a neon-lit playground for party goers, while Tsilivi serves up classic fun in the sun. And it’s over to Zante Town for chic boutiques and harbourside wining and dining. Hidden caves, shipwrecks, chalky white cliffs – they all add to the desert-island appeal of this Greek good looker too.', '+3', 37),
(7, 'Ibiza', 'Blissful beaches meet shimmering sunsets on this beautiful boho island, where a contrast of superclubs and family-flavoured resorts sit side by side. The White Isle may be famed for its party scene, but there’s a sleepier side of traditional towns, secret coves and pine-coated hills to leave you feeling zen. And the resorts come in all shapes and sizes. Playa d’En Bossa has a playful spirit with its watersports and buzzy beach bars, while Playa Es Cana’s Hippy Market will stir your senses and Santa Eulalia’s the place to go gourmet. For heaps of history mixed with a slice of sophistication, it’s got to be oh-so cool Ibiza Town. ', '+2', 34),
(8, 'Tenerife', 'Deserts, epic volcanoes and breathtaking mountains sit side-by-side on the spectacular Canary Islands. Year-round sun and average temps in the twenties make the quartet of Tenerife, Lanzarote, Gran Canaria and Fuerteventura a popular spot for classic beach breaks. Each one’s a firm favourite for different reasons – think wine tasting, surfing mighty waves, experiencing neon-lit nightlife and conquering incredible peaks.', '+1', 35);

-- --------------------------------------------------------

--
-- Table structure for table `region_descriptor`
--

CREATE TABLE `region_descriptor` (
  `region_descriptor_id` int(11) NOT NULL,
  `region_descriptor_title` varchar(255) NOT NULL,
  `region_descriptor_body` text NOT NULL,
  `region_descriptor_region_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `region_descriptor`
--

INSERT INTO `region_descriptor` (`region_descriptor_id`, `region_descriptor_title`, `region_descriptor_body`, `region_descriptor_region_id`) VALUES
(1, 'Stunning coast', 'The Costa Blanca’s coastline is utterly gorgeous, with never-ending beaches, towering cliffs and tucked-away coves. A little way inland, you’ve got mountains and pine forests, plus the salt marshes that draw in flocks of flamingos and other curious birds. It’s a glorious wild shoreline.', 1),
(2, 'Resorts for everyone', 'Classic Spanish villages dotted across the Costa Blanca all have their own character. Take Benidorm – it’s the biggest, best-known resort in the area, teeming with life and nightclubs, and couldn’t scream better value if it tried. Albir is more laid-back, while Calpe’s all about authentic España. Foodies will even find Michelin-starred dining options dotted about the region’s resorts.', 1),
(3, 'Vibrant cities', 'Alicante should be high on your list. Take advantage of the photo opportunities sweeping all the way from up on the hillside to down in the city. Don’t miss the covered markets or golden beaches. Stylish Valencia, with its parks and pretty old town, makes for a brilliant day trip.', 1);

-- --------------------------------------------------------

--
-- Table structure for table `resort`
--

CREATE TABLE `resort` (
  `resort_id` int(11) NOT NULL,
  `resort_name` varchar(255) NOT NULL,
  `resort_description` text NOT NULL,
  `resort_region_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `resort`
--

INSERT INTO `resort` (`resort_id`, `resort_name`, `resort_description`, `resort_region_id`) VALUES
(1, 'Benidorm\r\n', 'Benidorm is the resort of all resorts on Costa Blanca’s sun-kissed coast. Pull up a sunlounger in this popular plot and do what Benidorm does best – take life as it comes. With incredible value around the likes of English Square, the bright lights of Benidorm Palace and some of the most sun-soaked beaches in Spain (hello, Levante), it’s not surprising that people of all ages just can’t stop coming back to Benidorm…\r\n', 1),
(2, 'Calpe\r\n', 'This former fishing village is a hit with holidaymakers who like a dose of history with their beach-based relaxation. It’s got soft sands, tall buildings that light up the skyline at night, and some magical cliffside scenery to boot. Plus, it\'s a popular plot to explore on two wheels! \r\n', 1),
(3, 'Benalmadena\r\n', 'Benalmadena is a tale of three parts – the hilltop Old Town, the bustling downtown and a choice of glittering beaches. With cities and resorts nearby, it’s a palm-lined platform for exploration beyond the landscaped gardens, marvellous monuments and international eateries filling this bustling area.\r\n', 2),
(4, 'Lara Beach\r\n', 'With its extravagant, glitzy five-star hotels, it’s no wonder many people see Lara Beach as Turkey’s answer to Las Vegas. Lush pools, restaurants, waterparks and even sensational spas all add to the glamour of this resort. But if you fancy some authentic experiences, grab a bus to Antalya to explore.\r\n', 3),
(5, 'Belek\r\n', 'Stylish Belek is famous for golf, beaches and beautiful landscapes. Here, you’ll also get a glimpse into Turkey’s rich history. So, whether you plan to top up your tan, work on your swing, or explore ancient Greek towns, Antalya’s popular resort won’t disappoint. Check out our fantastic holidays to Belek.\r\n', 3),
(6, 'Turunc\r\n', 'Hiking up the Taurus Mountains offer incredible views of Turunç, so get your comfy shoes on and grab your camera – you’re going on an adventure. If you’d rather a bit of pure peace and quiet, there’s a brilliant beach, tranquil tea garden, and even enticing gift shops to browse.\r\n', 4),
(7, 'Kardamena\r\n', 'Kardamena is a great place if you\'re looking for nightlife – and it caters for all ages and tastes too. Nights out are centred on the square and its small variety of bars. The resort also offers peace and quiet at a medieval castle and a wide band of soft sand to kick back on along this south-east coast. Hop on a mini-hovercraft or pedalo, but don’t miss sniffing out a bargain in the souvenir shops.\r\n', 5),
(8, 'Agios Fokas\r\n', 'The minute you clap eyes on Agios Fokas, you’ll be immersed in a kaleidoscope of dreamy blues and greens. It’s a classic Greek resort, with a super-slow pace to it. If you’re eager to sit back and relax, simply pitch up on the pebbly beach or in a traditional taverna. \r\n', 5),
(9, 'Kalamaki\r\n', 'A popular choice for families, Kalamaki boasts everything from quiet to fun-filled nights, topped off with all the usual trappings of a bustling seaside resort. We’re talking souvenir shops, crazy golf – the works! And where the sandy beach meets the Bay of Laganas, you’ll want to keep your peepers peeled for the famous Caretta Caretta turtles.\r\n', 3);

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `review_id` int(11) NOT NULL,
  `review_timestamp` timestamp NULL DEFAULT current_timestamp(),
  `review_content` text NOT NULL,
  `reviewer_id` int(11) NOT NULL,
  `review_rating_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `review`
--

INSERT INTO `review` (`review_id`, `review_timestamp`, `review_content`, `reviewer_id`, `review_rating_id`) VALUES
(13, '2022-11-01 00:25:50', 'Was Amazing. Bitey scorpions!', 23, 5),
(14, '2022-11-01 00:36:28', 'Was Ok. Crocodiles were a little bitey', 24, 2),
(15, '2022-11-02 18:11:16', 'placeholder review please ignore', 25, 2);

-- --------------------------------------------------------

--
-- Table structure for table `review_rating`
--

CREATE TABLE `review_rating` (
  `review_rating_id` int(11) NOT NULL,
  `review_rating` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `review_rating`
--

INSERT INTO `review_rating` (`review_rating_id`, `review_rating`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `room_booking`
--

CREATE TABLE `room_booking` (
  `room_booking_id` int(11) NOT NULL,
  `room_booking_room_type_id` int(11) NOT NULL,
  `room_booking_hotel_board_type_id` int(11) DEFAULT NULL,
  `room_booking_booking_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `room_booking`
--

INSERT INTO `room_booking` (`room_booking_id`, `room_booking_room_type_id`, `room_booking_hotel_board_type_id`, `room_booking_booking_id`) VALUES
(1, 1, 1, 18),
(2, 2, 2, 18),
(3, 3, 1, 19),
(4, 2, 2, 19),
(5, 16, 1, 20);

-- --------------------------------------------------------

--
-- Table structure for table `room_facility`
--

CREATE TABLE `room_facility` (
  `room_facility_id` int(11) NOT NULL,
  `room_facility_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `room_facility`
--

INSERT INTO `room_facility` (`room_facility_id`, `room_facility_name`) VALUES
(1, 'Flat screen television'),
(2, 'Wi-fi'),
(3, 'Safety deposit box'),
(4, 'Kettle'),
(5, 'Balcony or terrace'),
(6, 'Hairdryer'),
(7, 'Fridge-freezer'),
(8, 'Air conditioning');

-- --------------------------------------------------------

--
-- Table structure for table `room_type`
--

CREATE TABLE `room_type` (
  `room_type_id` int(11) NOT NULL,
  `room_type_name` varchar(255) NOT NULL,
  `room_type_description` text DEFAULT NULL,
  `room_type_sleeps_min` int(11) NOT NULL,
  `room_type_sleeps_max` int(11) NOT NULL,
  `room_type_sleeps_infants` int(11) DEFAULT NULL,
  `room_type_base_quantity` int(11) NOT NULL,
  `room_type_hotel_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `room_type`
--

INSERT INTO `room_type` (`room_type_id`, `room_type_name`, `room_type_description`, `room_type_sleeps_min`, `room_type_sleeps_max`, `room_type_sleeps_infants`, `room_type_base_quantity`, `room_type_hotel_id`) VALUES
(1, 'Double or Twin room', 'lovely', 2, 2, 1, 10, 11),
(2, 'Double or Twin room - Sleeps up to 3', 'spiffing', 2, 3, NULL, 5, 11),
(3, 'Double or Twin room with Pool room', 'delightful', 2, 3, 2, 6, 11),
(4, 'Single Room Basic', 'frightful', 1, 1, 1, 15, 12),
(5, 'Single Room Fancy', 'massive', 1, 1, NULL, 2, 12),
(6, 'Double King Room Mega 9000', 'mega', 2, 2, 2, 3, 12),
(7, 'Uber Mega Fancy Business Suite', NULL, 1, 2, 0, 3, 13),
(8, 'Standard-Joe Room', NULL, 1, 2, NULL, 20, 13),
(9, 'Barely A Room', NULL, 1, 1, NULL, 6, 13),
(10, 'Double or Twin Room', NULL, 1, 2, 1, 6, 14),
(11, 'Double or Twin Room with Sea Viwe', NULL, 1, 2, 1, 5, 14),
(12, 'Twin Room', NULL, 1, 2, NULL, 22, 15),
(13, 'Twin Room with Sea View', NULL, 1, 2, NULL, 5, 15),
(14, 'Single Room', NULL, 1, 1, NULL, 5, 16),
(15, 'Party Room', NULL, 1, 10, NULL, 7, 16),
(16, 'no rooms left demo room type', 'no rooms left demo room type', 1, 2, NULL, 1, 11);

-- --------------------------------------------------------

--
-- Table structure for table `room_type_facility`
--

CREATE TABLE `room_type_facility` (
  `room_type_facility_id` int(11) NOT NULL,
  `room_type_id` int(11) NOT NULL,
  `room_facility_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `room_type_facility`
--

INSERT INTO `room_type_facility` (`room_type_facility_id`, `room_type_id`, `room_facility_id`) VALUES
(1, 1, 8),
(2, 1, 2),
(3, 1, 4);

-- --------------------------------------------------------

--
-- Table structure for table `room_type_image`
--

CREATE TABLE `room_type_image` (
  `room_type_image_id` int(11) NOT NULL,
  `room_type_image_url` text NOT NULL,
  `room_type_image_alt_text` varchar(255) NOT NULL,
  `room_type_image_room_type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `room_type_image`
--

INSERT INTO `room_type_image` (`room_type_image_id`, `room_type_image_url`, `room_type_image_alt_text`, `room_type_image_room_type_id`) VALUES
(1, 'http://dummyimage.com/244x100.png/dddddd/000000', 'In quis justo.', 1),
(2, 'http://dummyimage.com/104x100.png/ff4444/ffffff', 'Suspendisse potenti.', 1),
(3, 'http://dummyimage.com/103x100.png/5fa2dd/ffffff', 'Nunc purus.', 1),
(4, 'http://dummyimage.com/115x100.png/ff4444/ffffff', 'Curabitur at ipsum ac tellus semper interdum.', 1),
(5, 'http://dummyimage.com/212x100.png/ff4444/ffffff', 'Donec quis orci eget orci vehicula condimentum.', 1),
(6, 'http://dummyimage.com/176x100.png/cc0000/ffffff', 'Praesent blandit lacinia erat.', 1),
(7, 'http://dummyimage.com/195x100.png/ff4444/ffffff', 'Praesent blandit.', 1),
(8, 'http://dummyimage.com/167x100.png/ff4444/ffffff', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 1),
(9, 'http://dummyimage.com/120x100.png/dddddd/000000', 'Nulla mollis molestie lorem.', 1),
(10, 'http://dummyimage.com/152x100.png/cc0000/ffffff', 'In hac habitasse platea dictumst.', 1),
(11, 'http://dummyimage.com/115x100.png/ff4444/ffffff', 'Nulla tellus.', 1),
(12, 'http://dummyimage.com/161x100.png/cc0000/ffffff', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.', 1),
(13, 'http://dummyimage.com/143x100.png/cc0000/ffffff', 'Donec posuere metus vitae ipsum.', 1),
(14, 'http://dummyimage.com/171x100.png/cc0000/ffffff', 'Praesent blandit.', 1),
(15, 'http://dummyimage.com/211x100.png/ff4444/ffffff', 'Curabitur at ipsum ac tellus semper interdum.', 1),
(16, 'http://dummyimage.com/210x100.png/dddddd/000000', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.', 1),
(17, 'http://dummyimage.com/172x100.png/dddddd/000000', 'Etiam faucibus cursus urna.', 1),
(18, 'http://dummyimage.com/131x100.png/cc0000/ffffff', 'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', 1),
(19, 'http://dummyimage.com/115x100.png/ff4444/ffffff', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.', 1),
(20, 'http://dummyimage.com/128x100.png/cc0000/ffffff', 'Donec semper sapien a libero.', 1);

-- --------------------------------------------------------

--
-- Table structure for table `room_type_price`
--

CREATE TABLE `room_type_price` (
  `room_type_price_id` int(11) NOT NULL,
  `room_type_price_gbp` decimal(13,4) NOT NULL,
  `room_type_price_valid_from__date` date NOT NULL,
  `room_type_price_valid_to_date` date NOT NULL,
  `room_type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `room_type_price`
--

INSERT INTO `room_type_price` (`room_type_price_id`, `room_type_price_gbp`, `room_type_price_valid_from__date`, `room_type_price_valid_to_date`, `room_type_id`) VALUES
(1, '123.1200', '2023-01-01', '2023-01-01', 1),
(2, '23.4500', '2023-01-01', '2023-01-01', 2),
(4, '67.6700', '2023-01-01', '2023-01-01', 3),
(5, '78.7800', '2023-01-01', '2023-01-01', 4),
(6, '89.8900', '2023-01-01', '2023-01-01', 5),
(7, '99.9900', '2023-01-01', '2023-01-01', 6),
(8, '98.9800', '2023-01-01', '2023-01-01', 7),
(9, '87.8700', '2023-01-01', '2023-01-01', 8),
(10, '76.7600', '2023-01-01', '2023-01-01', 9),
(11, '65.6500', '2023-01-01', '2023-01-01', 10),
(12, '54.5400', '2023-01-01', '2023-01-01', 11),
(13, '43.4300', '2023-01-01', '2023-01-01', 12),
(14, '32.3200', '2023-01-01', '2023-01-01', 13),
(15, '21.2100', '2023-01-01', '2023-01-01', 14),
(16, '156.5400', '2023-01-01', '2023-01-01', 15),
(17, '231.1200', '2023-01-02', '2023-01-02', 1),
(18, '32.4500', '2023-01-02', '2023-01-02', 2),
(19, '76.6700', '2023-01-02', '2023-01-02', 3),
(20, '87.7800', '2023-01-02', '2023-01-02', 4),
(21, '98.8900', '2023-01-02', '2023-01-02', 5),
(22, '1.9900', '2023-01-02', '2023-01-02', 6),
(23, '89.9800', '2023-01-02', '2023-01-02', 7),
(24, '187.8700', '2023-01-02', '2023-01-02', 8),
(25, '176.7600', '2023-01-02', '2023-01-02', 9),
(26, '165.6500', '2023-01-02', '2023-01-02', 10),
(27, '54.5400', '2023-01-02', '2023-01-02', 11),
(28, '43.4300', '2023-01-02', '2023-01-02', 12),
(29, '32.3200', '2023-01-02', '2023-01-02', 13),
(30, '21.2100', '2023-01-02', '2023-01-02', 14),
(31, '156.5400', '2023-01-02', '2023-01-02', 15);

-- --------------------------------------------------------

--
-- Table structure for table `route`
--

CREATE TABLE `route` (
  `route_id` int(11) NOT NULL,
  `route_name` varchar(255) NOT NULL,
  `departure_airport_id` int(11) NOT NULL,
  `arrival_airport_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `route`
--

INSERT INTO `route` (`route_id`, `route_name`, `departure_airport_id`, `arrival_airport_id`) VALUES
(1, 'Belfast to Greece', 5, 7),
(2, 'Belfast to Ibiza', 5, 6),
(3, 'Belfast to Tenerife', 5, 9),
(4, 'Belfast to Turkey', 5, 8),
(5, 'Greece to Belfast', 7, 5),
(6, 'Ibiza to Belfast', 6, 5),
(7, 'Tenerife to Belfast', 9, 5),
(8, 'Turkey to Belfast', 8, 5),
(9, 'Belfast to Spain', 5, 10),
(10, 'Spain to Belfast', 10, 5);

-- --------------------------------------------------------

--
-- Table structure for table `route_price`
--

CREATE TABLE `route_price` (
  `route_price_id` int(11) NOT NULL,
  `route_price_gbp` decimal(13,4) NOT NULL,
  `route_price_valid_from_datetime` datetime NOT NULL,
  `route_price_valid_to_datetime` datetime NOT NULL,
  `route_price_route_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `route_price`
--

INSERT INTO `route_price` (`route_price_id`, `route_price_gbp`, `route_price_valid_from_datetime`, `route_price_valid_to_datetime`, `route_price_route_id`) VALUES
(1, '125.2500', '2023-01-01 00:00:00', '2023-01-01 12:00:00', 1),
(2, '999.7800', '2023-01-01 12:00:01', '2023-01-01 18:00:00', 1),
(3, '5451.1100', '2023-01-01 18:00:00', '2023-01-01 23:59:59', 1),
(4, '120.0000', '2023-01-01 00:00:00', '2023-01-01 12:00:00', 2),
(5, '105.0000', '2023-01-01 12:00:01', '2023-01-01 18:00:00', 2),
(6, '106.0000', '2023-01-01 18:00:00', '2023-01-01 23:59:59', 2),
(7, '5959.1000', '2023-01-01 00:00:00', '2023-01-01 12:00:00', 3),
(8, '69.4200', '2023-01-01 12:00:01', '2023-01-01 18:00:00', 3),
(9, '88.8800', '2023-01-01 18:00:00', '2023-01-01 23:59:59', 3),
(10, '840.1200', '2023-01-01 00:00:00', '2023-01-01 08:00:00', 4),
(11, '540.5500', '2022-10-29 08:00:01', '2022-10-29 15:00:00', 4),
(12, '94.4400', '2022-10-29 15:01:00', '2022-10-29 23:59:59', 4),
(13, '4353.0000', '2023-01-01 00:00:00', '2023-01-01 12:00:00', 5),
(14, '34.0000', '2023-01-01 12:00:01', '2023-01-01 18:00:00', 5),
(15, '6543.0000', '2023-01-01 18:00:00', '2023-01-01 23:59:59', 5),
(16, '656.0000', '2023-01-01 00:00:00', '2023-01-01 12:00:00', 6),
(17, '65.6600', '2023-01-01 12:00:01', '2023-01-01 18:00:00', 6),
(18, '588.6600', '2023-01-01 18:00:00', '2023-01-01 23:59:59', 6),
(19, '540.8800', '2023-01-01 00:00:00', '2023-01-01 12:00:00', 7),
(20, '464.1100', '2023-01-01 12:00:01', '2023-01-01 18:00:00', 7),
(21, '56.1000', '2023-01-01 18:00:00', '2023-01-01 23:59:59', 7),
(22, '262.1000', '2023-01-01 00:00:00', '2023-01-01 12:00:00', 8),
(23, '12.1000', '2023-01-01 12:00:01', '2023-01-01 18:00:00', 8),
(24, '566.6500', '2023-01-01 18:00:00', '2023-01-01 23:59:59', 8),
(26, '999.7800', '2023-01-02 12:00:01', '2023-01-02 18:00:00', 1),
(27, '5451.1100', '2023-01-02 18:00:00', '2023-01-02 23:59:59', 1),
(28, '120.0000', '2023-01-02 00:00:00', '2023-01-02 12:00:00', 2),
(29, '105.0000', '2023-01-02 12:00:01', '2023-01-02 18:00:00', 2),
(30, '106.0000', '2023-01-02 18:00:00', '2023-01-02 23:59:59', 2),
(31, '5959.1000', '2023-01-02 00:00:00', '2023-01-02 12:00:00', 3),
(32, '69.4200', '2023-01-02 12:00:01', '2023-01-02 18:00:00', 3),
(33, '88.8800', '2023-01-02 18:00:00', '2023-01-02 23:59:59', 3),
(34, '840.1200', '2023-01-02 00:00:00', '2023-01-02 08:00:00', 4),
(35, '540.5500', '2022-10-29 08:00:01', '2022-10-29 15:00:00', 4),
(36, '94.4400', '2022-10-29 15:01:00', '2022-10-29 23:59:59', 4),
(37, '4353.0000', '2023-01-02 00:00:00', '2023-01-02 12:00:00', 5),
(38, '34.0000', '2023-01-02 12:00:01', '2023-01-02 18:00:00', 5),
(39, '6543.0000', '2023-01-02 18:00:00', '2023-01-02 23:59:59', 5),
(40, '656.0000', '2023-01-02 00:00:00', '2023-01-02 12:00:00', 6),
(41, '65.6600', '2023-01-02 12:00:01', '2023-01-02 18:00:00', 6),
(42, '588.6600', '2023-01-02 18:00:00', '2023-01-02 23:59:59', 6),
(43, '540.8800', '2023-01-02 00:00:00', '2023-01-02 12:00:00', 7),
(44, '464.1100', '2023-01-02 12:00:01', '2023-01-02 18:00:00', 7),
(45, '56.1000', '2023-01-02 18:00:00', '2023-01-02 23:59:59', 7),
(46, '262.1000', '2023-01-02 00:00:00', '2023-01-02 12:00:00', 8),
(49, '532.1100', '2023-01-02 12:00:01', '2023-01-02 20:00:00', 8),
(50, '56.2200', '2023-01-02 20:00:01', '2023-01-02 23:59:59', 8),
(51, '125.2500', '2023-01-01 00:00:00', '2023-01-01 12:00:00', 9),
(52, '999.7800', '2023-01-01 12:00:01', '2023-01-01 18:00:00', 9),
(53, '5451.1100', '2023-01-01 18:00:00', '2023-01-01 23:59:59', 9),
(54, '120.0000', '2023-01-01 00:00:00', '2023-01-01 12:00:00', 10),
(55, '105.0000', '2023-01-01 12:00:01', '2023-01-01 18:00:00', 10),
(56, '106.0000', '2023-01-01 18:00:00', '2023-01-01 23:59:59', 10),
(57, '66.0000', '2023-01-02 00:00:00', '2023-01-02 12:00:00', 10),
(58, '77.0000', '2023-01-02 12:00:01', '2023-01-02 23:59:59', 10),
(59, '35.0000', '2023-01-03 00:00:00', '2023-01-03 12:00:00', 10),
(60, '88.0000', '2023-01-03 12:00:01', '2023-01-03 23:59:59', 10);

-- --------------------------------------------------------

--
-- Table structure for table `star_rating`
--

CREATE TABLE `star_rating` (
  `star_rating_id` int(11) NOT NULL,
  `star_rating` int(11) NOT NULL,
  `star_rating_plus` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `star_rating`
--

INSERT INTO `star_rating` (`star_rating_id`, `star_rating`, `star_rating_plus`) VALUES
(8, 1, b'0'),
(9, 2, b'0'),
(10, 3, b'0'),
(11, 3, b'1'),
(12, 4, b'0'),
(13, 4, b'1'),
(14, 5, b'0'),
(15, 5, b'1');

-- --------------------------------------------------------

--
-- Table structure for table `telephone`
--

CREATE TABLE `telephone` (
  `telephone_id` int(11) NOT NULL,
  `telephone_number` varchar(50) NOT NULL,
  `telephone_type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `telephone`
--

INSERT INTO `telephone` (`telephone_id`, `telephone_number`, `telephone_type_id`) VALUES
(5, '4076956204', 3),
(6, '5046936373', 2),
(7, '9177197343', 3),
(8, '1533410128', 2),
(9, '2889016921', 3),
(10, '1046456508', 3),
(11, '5132198604', 2),
(12, '3601532309', 3),
(13, '4089231071', 2),
(14, '9495050224', 1),
(15, '5915327868', 1),
(16, '6547282877', 3),
(17, '4248384222', 2),
(18, '4919621377', 2),
(19, '6765778847', 2),
(20, '8207272549', 1),
(21, '9501137122', 1),
(22, '9681722540', 2),
(23, '6458735077', 2),
(24, '9092864741', 1),
(25, '(952) 2348125', 1),
(26, '(510) 5570834', 2),
(27, '(993) 8144308', 3),
(28, '(437) 3768739', 2),
(29, '(720) 4886215', 2),
(30, '(630) 6806926', 2),
(31, '(170) 1539455', 3),
(32, '(219) 4624432', 1),
(33, '(687) 3927611', 1),
(34, '(593) 8462131', 2),
(80, '897864', 1),
(81, '+020 4485354651', 2),
(82, '0-9090-emergency', 3),
(83, '5346515', 1),
(84, '+44 65461345', 2),
(85, '0-800-emergency', 3),
(86, '34562134', 1),
(87, '+44 12342134', 2),
(88, '0-1234-emergency', 3);

-- --------------------------------------------------------

--
-- Table structure for table `telephone_type`
--

CREATE TABLE `telephone_type` (
  `telephone_type_id` int(11) NOT NULL,
  `telephone_type_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `telephone_type`
--

INSERT INTO `telephone_type` (`telephone_type_id`, `telephone_type_name`) VALUES
(1, 'Home/ Office'),
(2, 'Mobile'),
(3, 'Emergency');

-- --------------------------------------------------------

--
-- Table structure for table `title`
--

CREATE TABLE `title` (
  `title_id` int(11) NOT NULL,
  `title_abbreviation` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `title`
--

INSERT INTO `title` (`title_id`, `title_abbreviation`) VALUES
(3, 'Mr'),
(4, 'Miss'),
(5, 'Mrs'),
(6, 'Ms'),
(7, 'Mstr');

-- --------------------------------------------------------

--
-- Table structure for table `town_city`
--

CREATE TABLE `town_city` (
  `town_city_id` int(11) NOT NULL,
  `town_city_name` varchar(255) NOT NULL,
  `town_city_country_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `town_city`
--

INSERT INTO `town_city` (`town_city_id`, `town_city_name`, `town_city_country_id`) VALUES
(10, 'Belfast', 11),
(11, 'London', 11),
(12, 'Glasgow', 11),
(13, 'Cardiff', 11),
(14, 'Berlin', 9),
(15, 'Sant Antoni de Portmany', 7),
(16, 'Agreektown', 12),
(17, 'Aturktown', 8),
(18, 'Atenerifetown', 7),
(19, 'Spanish Hoteltown1', 7),
(20, 'Spanish Hoteltown2', 7),
(21, 'Spanish Hoteltown3', 7),
(22, 'Turkish Hoteltown1', 8),
(23, 'Greek Hoteltown1', 12),
(24, 'Greek Hoteltown2', 12);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`address_id`),
  ADD KEY `FK__town_city__town_city_id` (`town_city_id`);

--
-- Indexes for table `airport`
--
ALTER TABLE `airport`
  ADD PRIMARY KEY (`airport_id`),
  ADD KEY `FK__gps__gps_id_2` (`airport_gps_id`),
  ADD KEY `FK__address__address_id_4` (`airport_address_id`);

--
-- Indexes for table `board_type`
--
ALTER TABLE `board_type`
  ADD PRIMARY KEY (`board_type_id`);

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `FK__booking_contact__booking_contact_id_2` (`booking_contact_id`),
  ADD KEY `FK__flight__flight_id` (`outbound_flight_id`),
  ADD KEY `FK__flight__flight_id_2` (`return_flight_id`);

--
-- Indexes for table `booking_contact`
--
ALTER TABLE `booking_contact`
  ADD PRIMARY KEY (`booking_contact_id`),
  ADD KEY `FK__address__address_id_2` (`booking_contact_address_id`),
  ADD KEY `FK__passenger__passenger_id` (`booking_contact_passenger_id`),
  ADD KEY `FK__email__email_id` (`booking_contact_email_id`);

--
-- Indexes for table `booking_contact_telephone`
--
ALTER TABLE `booking_contact_telephone`
  ADD PRIMARY KEY (`booking_contact_telephone_id`),
  ADD KEY `FK__booking_contact__booking_contact_id` (`booking_contact_telephone_booking_contact_id`),
  ADD KEY `FK__telephone__telephone_id` (`booking_contact_telephone_telephone_id`);

--
-- Indexes for table `booking_line_item`
--
ALTER TABLE `booking_line_item`
  ADD PRIMARY KEY (`booking_line_item_id`),
  ADD KEY `FK__booking_line_item_type__booking_line_item_type_id` (`booking_line_item_type_id`),
  ADD KEY `FK__booking__booking_id_4` (`booking_line_item_booking_id`);

--
-- Indexes for table `booking_line_item_type`
--
ALTER TABLE `booking_line_item_type`
  ADD PRIMARY KEY (`booking_line_item_type_id`);

--
-- Indexes for table `booking_passenger`
--
ALTER TABLE `booking_passenger`
  ADD PRIMARY KEY (`booking_passenger_id`),
  ADD KEY `FK__booking__booking_id` (`booking_passenger_booking_id`),
  ADD KEY `FK__passenger__passenger_id_2` (`booking_passenger_passenger_id`);

--
-- Indexes for table `card_vendor`
--
ALTER TABLE `card_vendor`
  ADD PRIMARY KEY (`card_vendor_id`);

--
-- Indexes for table `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`country_id`),
  ADD KEY `FK__currency__currency_id` (`country_primary_currency_id`),
  ADD KEY `FK__language__language_id` (`country_primary_language_id`),
  ADD KEY `FK__location_name__location_name_id` (`country_location_name_id`);

--
-- Indexes for table `currency`
--
ALTER TABLE `currency`
  ADD PRIMARY KEY (`currency_id`);

--
-- Indexes for table `destination`
--
ALTER TABLE `destination`
  ADD PRIMARY KEY (`destination_id`),
  ADD KEY `FK__country__country_id_6` (`destination_country_id`),
  ADD KEY `FK__location_name__location_name_2` (`destination_location_name_id`);

--
-- Indexes for table `email`
--
ALTER TABLE `email`
  ADD PRIMARY KEY (`email_id`);

--
-- Indexes for table `flight`
--
ALTER TABLE `flight`
  ADD PRIMARY KEY (`flight_id`),
  ADD KEY `FK__route__route_id` (`route_id`);

--
-- Indexes for table `gps`
--
ALTER TABLE `gps`
  ADD PRIMARY KEY (`gps_id`);

--
-- Indexes for table `hotel`
--
ALTER TABLE `hotel`
  ADD PRIMARY KEY (`hotel_id`),
  ADD KEY `FK__star_rating__star_rating_id` (`hotel_star_rating_id`),
  ADD KEY `FK__gps__gps_id` (`hotel_gps_id`),
  ADD KEY `FK__address__address_id_3` (`hotel_address_id`),
  ADD KEY `FK__resort__resort_id_2` (`hotel_resort_id`),
  ADD KEY `FK__airport__airport_id_6` (`hotel_serving_airport_id`);

--
-- Indexes for table `hotel_board_type`
--
ALTER TABLE `hotel_board_type`
  ADD PRIMARY KEY (`hotel_board_type_id`),
  ADD KEY `FK__board_type__board_type_id` (`board_type_id`),
  ADD KEY `FK__hotel__hotel_id_3` (`hotel_id`);

--
-- Indexes for table `hotel_bullet`
--
ALTER TABLE `hotel_bullet`
  ADD PRIMARY KEY (`hotel_bullet_id`),
  ADD KEY `FK__hotel__hotel_id_11` (`hotel_bullet_hotel_id`);

--
-- Indexes for table `hotel_facility`
--
ALTER TABLE `hotel_facility`
  ADD PRIMARY KEY (`hotel_facility_id`),
  ADD KEY `FK__hotel__hotel_id_2` (`hotel_facility_hotel_id`),
  ADD KEY `FK__hotel_facility_type__hotel_facility_type_id` (`hotel_facility_type_id`);

--
-- Indexes for table `hotel_facility_bullet`
--
ALTER TABLE `hotel_facility_bullet`
  ADD PRIMARY KEY (`hotel_facility_bullet_id`),
  ADD KEY `FK__hotel_facility__hotel_facility_id_2` (`hotel_facility_bullet_hotel_facility_id`);

--
-- Indexes for table `hotel_facility_image`
--
ALTER TABLE `hotel_facility_image`
  ADD PRIMARY KEY (`hotel_facility_image_id`),
  ADD KEY `FK__hotel_facility__hotel_facility_id` (`hotel_facility_image_hotel_facility_id`);

--
-- Indexes for table `hotel_facility_type`
--
ALTER TABLE `hotel_facility_type`
  ADD PRIMARY KEY (`hotel_facility_type_id`);

--
-- Indexes for table `hotel_image`
--
ALTER TABLE `hotel_image`
  ADD PRIMARY KEY (`hotel_image_id`),
  ADD KEY `FK__hotel__hotel_id_6` (`hotel_image_hotel_id`);

--
-- Indexes for table `language`
--
ALTER TABLE `language`
  ADD PRIMARY KEY (`language_id`);

--
-- Indexes for table `location_name`
--
ALTER TABLE `location_name`
  ADD PRIMARY KEY (`location_name_id`);

--
-- Indexes for table `passenger`
--
ALTER TABLE `passenger`
  ADD PRIMARY KEY (`passenger_id`),
  ADD KEY `FK__passenger___passport_id` (`passenger_passport_id`),
  ADD KEY `FK__title__title_id` (`passenger_title_id`);

--
-- Indexes for table `passport`
--
ALTER TABLE `passport`
  ADD PRIMARY KEY (`passport_id`),
  ADD KEY `FK__country__country_id_7` (`passport_country_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `FK__booking__booking_id_3` (`booking_id`),
  ADD KEY `FK__payment_card__payment_card_id` (`payment_card_id`);

--
-- Indexes for table `payment_card`
--
ALTER TABLE `payment_card`
  ADD PRIMARY KEY (`payment_card_id`),
  ADD KEY `FK__booking_contact__booking_contact_id_3` (`booking_contact_id`),
  ADD KEY `FK__card_vendor_card_vendor_id` (`card_vendor_id`);

--
-- Indexes for table `region`
--
ALTER TABLE `region`
  ADD PRIMARY KEY (`region_id`),
  ADD KEY `FK__destination__destination_id` (`region_destination_id`);

--
-- Indexes for table `region_descriptor`
--
ALTER TABLE `region_descriptor`
  ADD PRIMARY KEY (`region_descriptor_id`),
  ADD KEY `FK__region__region_id` (`region_descriptor_region_id`);

--
-- Indexes for table `resort`
--
ALTER TABLE `resort`
  ADD PRIMARY KEY (`resort_id`),
  ADD KEY `FK__region__region_id_2` (`resort_region_id`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`review_id`),
  ADD UNIQUE KEY `reviewer_id` (`reviewer_id`),
  ADD UNIQUE KEY `reviewer_id_2` (`reviewer_id`),
  ADD KEY `FK__review_rating__review_rating_id` (`review_rating_id`);

--
-- Indexes for table `review_rating`
--
ALTER TABLE `review_rating`
  ADD PRIMARY KEY (`review_rating_id`);

--
-- Indexes for table `room_booking`
--
ALTER TABLE `room_booking`
  ADD PRIMARY KEY (`room_booking_id`),
  ADD KEY `FK__booking__booking_id_2` (`room_booking_booking_id`),
  ADD KEY `FK__room_type__room_type_id` (`room_booking_room_type_id`),
  ADD KEY `FK__hotel_board_type__hotel_board_type_id` (`room_booking_hotel_board_type_id`);

--
-- Indexes for table `room_facility`
--
ALTER TABLE `room_facility`
  ADD PRIMARY KEY (`room_facility_id`);

--
-- Indexes for table `room_type`
--
ALTER TABLE `room_type`
  ADD PRIMARY KEY (`room_type_id`),
  ADD KEY `FK__hotel__hotel_id` (`room_type_hotel_id`);

--
-- Indexes for table `room_type_facility`
--
ALTER TABLE `room_type_facility`
  ADD PRIMARY KEY (`room_type_facility_id`),
  ADD KEY `FK__room_facility__room_facility_id` (`room_facility_id`),
  ADD KEY `FK__room_type__room_type_id_3` (`room_type_id`);

--
-- Indexes for table `room_type_image`
--
ALTER TABLE `room_type_image`
  ADD PRIMARY KEY (`room_type_image_id`),
  ADD KEY `FK__room_type__room_type_id_2` (`room_type_image_room_type_id`);

--
-- Indexes for table `room_type_price`
--
ALTER TABLE `room_type_price`
  ADD PRIMARY KEY (`room_type_price_id`),
  ADD KEY `FK__room_type__room_type_id_4` (`room_type_id`);

--
-- Indexes for table `route`
--
ALTER TABLE `route`
  ADD PRIMARY KEY (`route_id`),
  ADD KEY `FK__airport__airport_id` (`arrival_airport_id`),
  ADD KEY `FK__airport__airport_id_2` (`departure_airport_id`);

--
-- Indexes for table `route_price`
--
ALTER TABLE `route_price`
  ADD PRIMARY KEY (`route_price_id`),
  ADD KEY `FK__route__route_id_2` (`route_price_route_id`);

--
-- Indexes for table `star_rating`
--
ALTER TABLE `star_rating`
  ADD PRIMARY KEY (`star_rating_id`),
  ADD UNIQUE KEY `star_rating` (`star_rating`,`star_rating_plus`);

--
-- Indexes for table `telephone`
--
ALTER TABLE `telephone`
  ADD PRIMARY KEY (`telephone_id`),
  ADD KEY `FK__telephone_type__telephone_type_id` (`telephone_type_id`);

--
-- Indexes for table `telephone_type`
--
ALTER TABLE `telephone_type`
  ADD PRIMARY KEY (`telephone_type_id`);

--
-- Indexes for table `title`
--
ALTER TABLE `title`
  ADD PRIMARY KEY (`title_id`);

--
-- Indexes for table `town_city`
--
ALTER TABLE `town_city`
  ADD PRIMARY KEY (`town_city_id`),
  ADD KEY `FK__country__country_id` (`town_city_country_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `airport`
--
ALTER TABLE `airport`
  MODIFY `airport_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `board_type`
--
ALTER TABLE `board_type`
  MODIFY `board_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `booking_contact`
--
ALTER TABLE `booking_contact`
  MODIFY `booking_contact_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `booking_contact_telephone`
--
ALTER TABLE `booking_contact_telephone`
  MODIFY `booking_contact_telephone_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `booking_line_item`
--
ALTER TABLE `booking_line_item`
  MODIFY `booking_line_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `booking_line_item_type`
--
ALTER TABLE `booking_line_item_type`
  MODIFY `booking_line_item_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `booking_passenger`
--
ALTER TABLE `booking_passenger`
  MODIFY `booking_passenger_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `card_vendor`
--
ALTER TABLE `card_vendor`
  MODIFY `card_vendor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `country_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `currency`
--
ALTER TABLE `currency`
  MODIFY `currency_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `destination`
--
ALTER TABLE `destination`
  MODIFY `destination_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `email`
--
ALTER TABLE `email`
  MODIFY `email_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `flight`
--
ALTER TABLE `flight`
  MODIFY `flight_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `gps`
--
ALTER TABLE `gps`
  MODIFY `gps_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `hotel`
--
ALTER TABLE `hotel`
  MODIFY `hotel_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `hotel_board_type`
--
ALTER TABLE `hotel_board_type`
  MODIFY `hotel_board_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `hotel_bullet`
--
ALTER TABLE `hotel_bullet`
  MODIFY `hotel_bullet_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `hotel_facility`
--
ALTER TABLE `hotel_facility`
  MODIFY `hotel_facility_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `hotel_facility_bullet`
--
ALTER TABLE `hotel_facility_bullet`
  MODIFY `hotel_facility_bullet_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `hotel_facility_image`
--
ALTER TABLE `hotel_facility_image`
  MODIFY `hotel_facility_image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `hotel_facility_type`
--
ALTER TABLE `hotel_facility_type`
  MODIFY `hotel_facility_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `hotel_image`
--
ALTER TABLE `hotel_image`
  MODIFY `hotel_image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `language`
--
ALTER TABLE `language`
  MODIFY `language_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `location_name`
--
ALTER TABLE `location_name`
  MODIFY `location_name_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `passenger`
--
ALTER TABLE `passenger`
  MODIFY `passenger_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT for table `passport`
--
ALTER TABLE `passport`
  MODIFY `passport_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `payment_card`
--
ALTER TABLE `payment_card`
  MODIFY `payment_card_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `region`
--
ALTER TABLE `region`
  MODIFY `region_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `region_descriptor`
--
ALTER TABLE `region_descriptor`
  MODIFY `region_descriptor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `resort`
--
ALTER TABLE `resort`
  MODIFY `resort_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `review_rating`
--
ALTER TABLE `review_rating`
  MODIFY `review_rating_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `room_booking`
--
ALTER TABLE `room_booking`
  MODIFY `room_booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `room_facility`
--
ALTER TABLE `room_facility`
  MODIFY `room_facility_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `room_type`
--
ALTER TABLE `room_type`
  MODIFY `room_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `room_type_facility`
--
ALTER TABLE `room_type_facility`
  MODIFY `room_type_facility_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `room_type_image`
--
ALTER TABLE `room_type_image`
  MODIFY `room_type_image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `room_type_price`
--
ALTER TABLE `room_type_price`
  MODIFY `room_type_price_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `route`
--
ALTER TABLE `route`
  MODIFY `route_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `route_price`
--
ALTER TABLE `route_price`
  MODIFY `route_price_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `star_rating`
--
ALTER TABLE `star_rating`
  MODIFY `star_rating_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `telephone`
--
ALTER TABLE `telephone`
  MODIFY `telephone_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT for table `telephone_type`
--
ALTER TABLE `telephone_type`
  MODIFY `telephone_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `title`
--
ALTER TABLE `title`
  MODIFY `title_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `town_city`
--
ALTER TABLE `town_city`
  MODIFY `town_city_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `FK__town_city__town_city_id` FOREIGN KEY (`town_city_id`) REFERENCES `town_city` (`town_city_id`);

--
-- Constraints for table `airport`
--
ALTER TABLE `airport`
  ADD CONSTRAINT `FK__address__address_id_4` FOREIGN KEY (`airport_address_id`) REFERENCES `address` (`address_id`),
  ADD CONSTRAINT `FK__gps__gps_id_2` FOREIGN KEY (`airport_gps_id`) REFERENCES `gps` (`gps_id`);

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `FK__booking_contact__booking_contact_id_2` FOREIGN KEY (`booking_contact_id`) REFERENCES `booking_contact` (`booking_contact_id`),
  ADD CONSTRAINT `FK__flight__flight_id` FOREIGN KEY (`outbound_flight_id`) REFERENCES `flight` (`flight_id`),
  ADD CONSTRAINT `FK__flight__flight_id_2` FOREIGN KEY (`return_flight_id`) REFERENCES `flight` (`flight_id`);

--
-- Constraints for table `booking_contact`
--
ALTER TABLE `booking_contact`
  ADD CONSTRAINT `FK__address__address_id_2` FOREIGN KEY (`booking_contact_address_id`) REFERENCES `address` (`address_id`),
  ADD CONSTRAINT `FK__email__email_id` FOREIGN KEY (`booking_contact_email_id`) REFERENCES `email` (`email_id`),
  ADD CONSTRAINT `FK__passenger__passenger_id` FOREIGN KEY (`booking_contact_passenger_id`) REFERENCES `passenger` (`passenger_id`);

--
-- Constraints for table `booking_contact_telephone`
--
ALTER TABLE `booking_contact_telephone`
  ADD CONSTRAINT `FK__booking_contact__booking_contact_id` FOREIGN KEY (`booking_contact_telephone_booking_contact_id`) REFERENCES `booking_contact` (`booking_contact_id`),
  ADD CONSTRAINT `FK__telephone__telephone_id` FOREIGN KEY (`booking_contact_telephone_telephone_id`) REFERENCES `telephone` (`telephone_id`);

--
-- Constraints for table `booking_line_item`
--
ALTER TABLE `booking_line_item`
  ADD CONSTRAINT `FK__booking__booking_id_4` FOREIGN KEY (`booking_line_item_booking_id`) REFERENCES `booking` (`booking_id`),
  ADD CONSTRAINT `FK__booking_line_item_type__booking_line_item_type_id` FOREIGN KEY (`booking_line_item_type_id`) REFERENCES `booking_line_item_type` (`booking_line_item_type_id`);

--
-- Constraints for table `booking_passenger`
--
ALTER TABLE `booking_passenger`
  ADD CONSTRAINT `FK__booking__booking_id` FOREIGN KEY (`booking_passenger_booking_id`) REFERENCES `booking` (`booking_id`),
  ADD CONSTRAINT `FK__passenger__passenger_id_2` FOREIGN KEY (`booking_passenger_passenger_id`) REFERENCES `passenger` (`passenger_id`);

--
-- Constraints for table `country`
--
ALTER TABLE `country`
  ADD CONSTRAINT `FK__currency__currency_id` FOREIGN KEY (`country_primary_currency_id`) REFERENCES `currency` (`currency_id`),
  ADD CONSTRAINT `FK__language__language_id` FOREIGN KEY (`country_primary_language_id`) REFERENCES `language` (`language_id`),
  ADD CONSTRAINT `FK__location_name__location_name_id` FOREIGN KEY (`country_location_name_id`) REFERENCES `location_name` (`location_name_id`);

--
-- Constraints for table `destination`
--
ALTER TABLE `destination`
  ADD CONSTRAINT `FK__country__country_id_6` FOREIGN KEY (`destination_country_id`) REFERENCES `country` (`country_id`),
  ADD CONSTRAINT `FK__location_name__location_name_2` FOREIGN KEY (`destination_location_name_id`) REFERENCES `location_name` (`location_name_id`);

--
-- Constraints for table `flight`
--
ALTER TABLE `flight`
  ADD CONSTRAINT `FK__route__route_id` FOREIGN KEY (`route_id`) REFERENCES `route` (`route_id`);

--
-- Constraints for table `hotel`
--
ALTER TABLE `hotel`
  ADD CONSTRAINT `FK__address__address_id_3` FOREIGN KEY (`hotel_address_id`) REFERENCES `address` (`address_id`),
  ADD CONSTRAINT `FK__airport__airport_id_6` FOREIGN KEY (`hotel_serving_airport_id`) REFERENCES `airport` (`airport_id`),
  ADD CONSTRAINT `FK__gps__gps_id` FOREIGN KEY (`hotel_gps_id`) REFERENCES `gps` (`gps_id`),
  ADD CONSTRAINT `FK__resort__resort_id_2` FOREIGN KEY (`hotel_resort_id`) REFERENCES `resort` (`resort_id`),
  ADD CONSTRAINT `FK__star_rating__star_rating_id` FOREIGN KEY (`hotel_star_rating_id`) REFERENCES `star_rating` (`star_rating_id`);

--
-- Constraints for table `hotel_board_type`
--
ALTER TABLE `hotel_board_type`
  ADD CONSTRAINT `FK__board_type__board_type_id` FOREIGN KEY (`board_type_id`) REFERENCES `board_type` (`board_type_id`),
  ADD CONSTRAINT `FK__hotel__hotel_id_3` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`);

--
-- Constraints for table `hotel_bullet`
--
ALTER TABLE `hotel_bullet`
  ADD CONSTRAINT `FK__hotel__hotel_id_11` FOREIGN KEY (`hotel_bullet_hotel_id`) REFERENCES `hotel` (`hotel_id`);

--
-- Constraints for table `hotel_facility`
--
ALTER TABLE `hotel_facility`
  ADD CONSTRAINT `FK__hotel__hotel_id_2` FOREIGN KEY (`hotel_facility_hotel_id`) REFERENCES `hotel` (`hotel_id`),
  ADD CONSTRAINT `FK__hotel_facility_type__hotel_facility_type_id` FOREIGN KEY (`hotel_facility_type_id`) REFERENCES `hotel_facility_type` (`hotel_facility_type_id`);

--
-- Constraints for table `hotel_facility_bullet`
--
ALTER TABLE `hotel_facility_bullet`
  ADD CONSTRAINT `FK__hotel_facility__hotel_facility_id_2` FOREIGN KEY (`hotel_facility_bullet_hotel_facility_id`) REFERENCES `hotel_facility` (`hotel_facility_id`);

--
-- Constraints for table `hotel_facility_image`
--
ALTER TABLE `hotel_facility_image`
  ADD CONSTRAINT `FK__hotel_facility__hotel_facility_id` FOREIGN KEY (`hotel_facility_image_hotel_facility_id`) REFERENCES `hotel_facility` (`hotel_facility_id`);

--
-- Constraints for table `hotel_image`
--
ALTER TABLE `hotel_image`
  ADD CONSTRAINT `FK__hotel__hotel_id_6` FOREIGN KEY (`hotel_image_hotel_id`) REFERENCES `hotel` (`hotel_id`);

--
-- Constraints for table `passenger`
--
ALTER TABLE `passenger`
  ADD CONSTRAINT `FK__passenger___passport_id` FOREIGN KEY (`passenger_passport_id`) REFERENCES `passport` (`passport_id`),
  ADD CONSTRAINT `FK__title__title_id` FOREIGN KEY (`passenger_title_id`) REFERENCES `title` (`title_id`);

--
-- Constraints for table `passport`
--
ALTER TABLE `passport`
  ADD CONSTRAINT `FK__country__country_id_7` FOREIGN KEY (`passport_country_id`) REFERENCES `country` (`country_id`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `FK__booking__booking_id_3` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`),
  ADD CONSTRAINT `FK__payment_card__payment_card_id` FOREIGN KEY (`payment_card_id`) REFERENCES `payment_card` (`payment_card_id`);

--
-- Constraints for table `payment_card`
--
ALTER TABLE `payment_card`
  ADD CONSTRAINT `FK__booking_contact__booking_contact_id_3` FOREIGN KEY (`booking_contact_id`) REFERENCES `booking_contact` (`booking_contact_id`),
  ADD CONSTRAINT `FK__card_vendor_card_vendor_id` FOREIGN KEY (`card_vendor_id`) REFERENCES `card_vendor` (`card_vendor_id`);

--
-- Constraints for table `region`
--
ALTER TABLE `region`
  ADD CONSTRAINT `FK__destination__destination_id` FOREIGN KEY (`region_destination_id`) REFERENCES `destination` (`destination_id`);

--
-- Constraints for table `region_descriptor`
--
ALTER TABLE `region_descriptor`
  ADD CONSTRAINT `FK__region__region_id` FOREIGN KEY (`region_descriptor_region_id`) REFERENCES `region` (`region_id`);

--
-- Constraints for table `resort`
--
ALTER TABLE `resort`
  ADD CONSTRAINT `FK__region__region_id_2` FOREIGN KEY (`resort_region_id`) REFERENCES `region` (`region_id`);

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `FK__booking_contact__booking_contact_id_4` FOREIGN KEY (`reviewer_id`) REFERENCES `booking_contact` (`booking_contact_id`),
  ADD CONSTRAINT `FK__review_rating__review_rating_id` FOREIGN KEY (`review_rating_id`) REFERENCES `review_rating` (`review_rating_id`);

--
-- Constraints for table `room_booking`
--
ALTER TABLE `room_booking`
  ADD CONSTRAINT `FK__booking__booking_id_2` FOREIGN KEY (`room_booking_booking_id`) REFERENCES `booking` (`booking_id`),
  ADD CONSTRAINT `FK__hotel_board_type__hotel_board_type_id` FOREIGN KEY (`room_booking_hotel_board_type_id`) REFERENCES `hotel_board_type` (`hotel_board_type_id`),
  ADD CONSTRAINT `FK__room_type__room_type_id` FOREIGN KEY (`room_booking_room_type_id`) REFERENCES `room_type` (`room_type_id`);

--
-- Constraints for table `room_type`
--
ALTER TABLE `room_type`
  ADD CONSTRAINT `FK__hotel__hotel_id` FOREIGN KEY (`room_type_hotel_id`) REFERENCES `hotel` (`hotel_id`);

--
-- Constraints for table `room_type_facility`
--
ALTER TABLE `room_type_facility`
  ADD CONSTRAINT `FK__room_facility__room_facility_id` FOREIGN KEY (`room_facility_id`) REFERENCES `room_facility` (`room_facility_id`),
  ADD CONSTRAINT `FK__room_type__room_type_id_3` FOREIGN KEY (`room_type_id`) REFERENCES `room_type` (`room_type_id`);

--
-- Constraints for table `room_type_image`
--
ALTER TABLE `room_type_image`
  ADD CONSTRAINT `FK__room_type__room_type_id_2` FOREIGN KEY (`room_type_image_room_type_id`) REFERENCES `room_type` (`room_type_id`);

--
-- Constraints for table `room_type_price`
--
ALTER TABLE `room_type_price`
  ADD CONSTRAINT `FK__room_type__room_type_id_4` FOREIGN KEY (`room_type_id`) REFERENCES `room_type` (`room_type_id`);

--
-- Constraints for table `route`
--
ALTER TABLE `route`
  ADD CONSTRAINT `FK__airport__airport_id` FOREIGN KEY (`arrival_airport_id`) REFERENCES `airport` (`airport_id`),
  ADD CONSTRAINT `FK__airport__airport_id_2` FOREIGN KEY (`departure_airport_id`) REFERENCES `airport` (`airport_id`);

--
-- Constraints for table `route_price`
--
ALTER TABLE `route_price`
  ADD CONSTRAINT `FK__route__route_id_2` FOREIGN KEY (`route_price_route_id`) REFERENCES `route` (`route_id`);

--
-- Constraints for table `telephone`
--
ALTER TABLE `telephone`
  ADD CONSTRAINT `FK__telephone_type__telephone_type_id` FOREIGN KEY (`telephone_type_id`) REFERENCES `telephone_type` (`telephone_type_id`);

--
-- Constraints for table `town_city`
--
ALTER TABLE `town_city`
  ADD CONSTRAINT `FK__country__country_id` FOREIGN KEY (`town_city_country_id`) REFERENCES `country` (`country_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
