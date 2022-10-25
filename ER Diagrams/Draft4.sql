-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 25, 2022 at 07:33 PM
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
-- Database: `jet2`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertAddress` (IN `AddressLine1` VARCHAR(255), IN `AddressLine2` VARCHAR(255), IN `Postcode` VARCHAR(255), IN `TownCityId` INT)   INSERT INTO address 
	(
        address.address_line_1,
   		address.address_line_2,
    	address.postcode,
    	address.town_city_id
    )
VALUES 
	(
        AddressLine1,
        AddressLine2,
        Postcode,
        TownCityId
    )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertAirport` (IN `AirportName` VARCHAR(255), IN `AirportIataCode` VARCHAR(3), IN `AirportGpsId` INT, IN `AddressId` INT)   INSERT INTO airport 
	(
        airport.airport_name,
        airport.airport_iata_code,
        airport.airport_gps_id,
        airport.airport_address_id
	)
VALUES
	(AirportName, AirportIataCode, AirportGpsId, AddressId)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertBoardType` (IN `BoardTypeName` VARCHAR(255))   INSERT INTO board_type 
	(board_type.board_type_name)
VALUES 
	(BoardTypeName)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertBookingContact` (IN `AddressId` INT, IN `PassengerId` INT, IN `EmailId` INT)   INSERT INTO booking_contact
	(
        booking_contact.booking_contact_address_id,
        booking_contact.booking_contact_passenger_id,
        booking_contact.booking_contact_email_id
    )
VALUES 
	(AddressId, PassengerId, EmailId)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertBookingContactTelephone` (IN `BookingContactId` INT, IN `TelephoneId` INT)   INSERT INTO booking_contact_telephone 
	(
        booking_contact_telephone.booking_contact_telephone_booking_contact_id,
        booking_contact_telephone.booking_contact_telephone_telephone_id
    )
VALUES
	(BookingContactId, TelephoneId)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertBookingPassenger` (IN `BookingId` INT, IN `PassengerId` INT)   INSERT INTO booking_passenger 
	(
        booking_passenger.booking_passenger_booking_id,
        booking_passenger.booking_passenger_passenger_id
    )
VALUES
	(BookingId, PassengerId)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertCardVendor` (IN `CardVendorName` VARCHAR(255))   INSERT INTO card_vendor
	(card_vendor.card_vendor_name)
VALUES
	(CardVendorName)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertCountry` (IN `CountryName` VARCHAR(255), IN `CountryDescription` TEXT)   INSERT INTO country
	(country.country_name,
    country.country_description)
VALUES
	(CountryName, CountryDescription)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertEmail` (IN `EmailAddress` TEXT)   INSERT INTO email
	(email.email_address)
VALUES
	(EmailAddress)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertImage` (IN `ImageUrl` TEXT, IN `ImageAltText` VARCHAR(255))   INSERT INTO image 
	(
        image.image_url,
        image.image_alt_text
    )
VALUES 
	(
        ImageUrl,
        ImageAltText
    )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertPassenger` (IN `PassengerFirstName` VARCHAR(255), IN `PassengerLastName` VARCHAR(255), IN `PassengerDob` DATE, IN `PassengerTitleId` INT, IN `PassengerPassportId` INT)   INSERT INTO passenger
	(
        passenger.passenger_first_name,
    	passenger.passenger_last_name,
    	passenger.passenger_date_of_birth,
    	passenger.passenger_title_id,
    	passenger.passenger_passport_id
    )
VALUES
	(
        PassengerFirstName,
        PassengerLastName,
        PassengerDob,
        PassengerTitleId,
        PassengerPassportId
    )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertPassport` (IN `PassportNumber` VARCHAR(255), IN `PassportExpiryDate` DATE, IN `PassportCountryId` INT)   INSERT INTO passport
	(passport.passport_number,
    passport.passport_expiry_date,
    passport.passport_country_id)
VALUES
	(PassportNumber, PassportExpiryDate, PassportCountryId)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertRoom` (IN `RoomNumber` VARCHAR(10), IN `RoomTypeId` INT)   INSERT INTO room
	(
        room.room_number,
        room.room_type_id
    )
VALUES
	(RoomNumber, RoomTypeId)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertRoomBooking` (IN `BookingId` INT, IN `RoomId` INT)   INSERT INTO room_booking
	(
        room_booking.room_booking_booking_id,
        room_booking.room_booking_room_id
	)
VALUES 
	(BookingId, RoomId)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertRoute` (IN `RouteName` VARCHAR(255), IN `DepartureAirportId` INT, IN `ArrivalAirportId` INT)   INSERT INTO route
	(
        route.route_name,
        route.departure_airport_id,
        route.arrival_airport_id
    )
VALUES
	(RouteName, DepartureAirportId, ArrivalAirportId)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertStarRating` (IN `StarRatingName` VARCHAR(255))   INSERT INTO star_rating
	(star_rating.star_rating_name)
VALUES 
	(StarRatingName)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertTelephone` (IN `TelephoneNumber` VARCHAR(50), IN `TelephoneTypeId` INT)   INSERT INTO telephone
	(
        telephone.telephone_number,
     	telephone.telephone_type_id
    )
VALUES
	(TelephoneNumber, TelephoneTypeId)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertTelephoneType` (IN `TelephoneTypeName` VARCHAR(255))   INSERT INTO telephone_type 
	(
        telephone_type.telephone_type_name
    )
VALUES
	(
        TelephoneTypeName
    )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertTitle` (IN `TitleAbbr` VARCHAR(10), IN `TitleName` VARCHAR(255))   INSERT INTO title 
	(
        title.title_abbreviation,
        title.title_name
    )
VALUES 
	(
        TitleAbbr,
        TitleName
    )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertTownCity` (IN `TownCityName` VARCHAR(255), IN `TownCityCountryId` INT)   INSERT INTO town_city
	(town_city.town_city_name,
     town_city.town_city_country_id)
VALUES
	(TownCityName,
     TownCityCountryId)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `address_id` int(11) NOT NULL,
  `address_line_1` varchar(255) CHARACTER SET utf8 NOT NULL,
  `address_line_2` varchar(255) CHARACTER SET utf8 NOT NULL,
  `postcode` varchar(255) CHARACTER SET utf8 NOT NULL,
  `town_city_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`address_id`, `address_line_1`, `address_line_2`, `postcode`, `town_city_id`) VALUES
(3, 'Airport Road', '', 'BT29 4AB', 1),
(2, 'Carrer S\'Aljub', '', '07849', 5),
(6, 'Dogville', '', 'BTXX XXX', 8),
(1, 'Playa de Es Figueral', '', '07840', 4);

-- --------------------------------------------------------

--
-- Table structure for table `airport`
--

CREATE TABLE `airport` (
  `airport_id` int(11) NOT NULL,
  `airport_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `airport_iata_code` varchar(3) CHARACTER SET utf8 NOT NULL,
  `airport_gps_id` int(11) NOT NULL,
  `airport_address_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `airport`
--

INSERT INTO `airport` (`airport_id`, `airport_name`, `airport_iata_code`, `airport_gps_id`, `airport_address_id`) VALUES
(1, 'Belfast International Airport', 'BFS', 6, 3),
(4, 'Antarctica Airport', 'ANT', 9, 6);

-- --------------------------------------------------------

--
-- Table structure for table `board_type`
--

CREATE TABLE `board_type` (
  `board_type_id` int(11) NOT NULL,
  `board_type_name` varchar(255) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `booking_id` int(11) NOT NULL,
  `booking_reference` varchar(255) NOT NULL,
  `booking_made_utc_datetime` datetime NOT NULL,
  `booking_contact_id` int(11) NOT NULL,
  `return_flight_id` int(11) NOT NULL,
  `outbound_flight_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `booking_contact`
--

CREATE TABLE `booking_contact` (
  `booking_contact_id` int(11) NOT NULL,
  `booking_contact_address_id` int(11) NOT NULL,
  `booking_contact_passenger_id` int(11) NOT NULL,
  `booking_contact_email_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `booking_contact_telephone`
--

CREATE TABLE `booking_contact_telephone` (
  `booking_contact_telephone_id` int(11) NOT NULL,
  `booking_contact_telephone_booking_contact_id` int(11) NOT NULL,
  `booking_contact_telephone_telephone_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `booking_passenger`
--

CREATE TABLE `booking_passenger` (
  `booking_passenger_id` int(11) NOT NULL,
  `booking_passenger_booking_id` int(11) NOT NULL,
  `booking_passenger_passenger_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `card_vendor`
--

CREATE TABLE `card_vendor` (
  `card_vendor_id` int(11) NOT NULL,
  `card_vendor_name` varchar(255) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `card_vendor`
--

INSERT INTO `card_vendor` (`card_vendor_id`, `card_vendor_name`) VALUES
(1, 'VISA'),
(2, 'MASTERCARD');

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE `country` (
  `country_id` int(11) NOT NULL,
  `country_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `country_description` text CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`country_id`, `country_name`, `country_description`) VALUES
(1, 'Northern Ireland', NULL),
(2, 'Portugal', 'Charm, cuisine, culture – Portugal’s got it by the bucketload. The Algarve\'s just one great example, with excellent golf, Blue Flag shores and a ton of family-friendly attractions too. For Portugal with an island twist, look to Madeira. Its lush botanical gardens and epic hiking trails make it a magnet for outdoorsy types. Whichever patch of the country you plump for, all parts take pride in their love for good food, good wine and good times. Cinnamon-sprinkled custard tarts, grilled sardines, crisp wine and velvety port are all national treasures, so sampling them is a rite of passage for any holiday to Portugal.'),
(3, 'Balearics', 'Majorca, Ibiza, Menorca – they’re all legends in the holiday hotspot stakes. A giant waterpark and miles of sandy coast are just the tip of Majorca’s top attractions. Meanwhile, Ibiza serves up a mix of full-on clubbing and idyllic natural beauty. And Menorca’s all about peaceful, family-friendly holidays. Sun-kissed good times are ensured wherever you set foot.'),
(4, 'Greece', 'With sunny climates, idyllic islands and culture aplenty, holidays to Greece offer guaranteed good times. From the secluded beaches of Lefkas, to the historic hub of the Peloponnese, the seafront resorts of Crete to the buzzing nightlife of Zante, Greece holidays will never disappoint. Check out some of the most picturesque destinations the country has to offer. '),
(5, 'England', NULL),
(6, 'Wales', NULL),
(7, 'Scotland', NULL),
(8, 'Majorca', 'When it comes to showing off every type of holiday, Majorca wins hands down. After family fun? Say hello to action-packed resorts bursting with epic waterparks and shows. Looking for luxury? How do swanky ports, VIP beach clubs and exclusive hilltop hideouts sound? Outdoorsy types have the rugged mountain peaks and lush countryside scenes of the north to get lost in, while culture vultures, shoppers and bar-hoppers have their pick of things to do in cosmopolitan Palma. As for the beaches, there are more than 200, with everything from buzzy prom-backed stretches to idyllic cosy coves. Oh, and year-round sunshine? Yep, Majorca’s got that too.  '),
(9, 'Menorca', 'Menorca’s charm is sure to leave a lasting impression. This serene island is blessed with dreamy pine-fringed bays, where you can spend lazy days tucking into long lunches at family-friendly restaurants followed by a sleepy siesta in the sun. But there’s so much more to explore. Due to its outstanding beauty, Menorca’s landscape is UNESCO-protected. Explore it along the Camí de Cavalls path or take a hike to the top of Monte Toro. It\'s also a haven for culture, with two fascinating cities Ciutadella and Mahon, plus 3,000-year-old monuments. In the evenings, night markets, harbourside gin cocktails and impressive sunsets set the scene for good times. '),
(10, 'Ibiza', 'Blissful beaches meet shimmering sunsets on this beautiful boho island, where a contrast of superclubs and family-flavoured resorts sit side by side. The White Isle may be famed for its party scene, but there’s a sleepier side of traditional towns, secret coves and pine-coated hills to leave you feeling zen. And the resorts come in all shapes and sizes. Playa d’En Bossa has a playful spirit with its watersports and buzzy beach bars, while Playa Es Cana’s Hippy Market will stir your senses and Santa Eulalia’s the place to go gourmet. For heaps of history mixed with a slice of sophistication, it’s got to be oh-so cool Ibiza Town. '),
(13, 'Italy', 'Holidays to Italy are like no other…. Spellbinding scenery, astonishing architecture and delicious food and drink. And in each region, there’s a little bit of unique magic to unlock. Up in the north of Italy, Lake Garda, Tuscany and the Venetian Riviera charm with their quaint towns and dreamy settings. Down in the south, pastel-hued Sorrento’s just as pretty, with sparkling views of the Bay of Naples. And that’s before we get to Italy’s islands. Sardinia’s white-sand beaches and turquoise waters are nothing short of idyllic. And then there’s Sicily, with its showstopping volcanic landscape and ancient ruins.'),
(19, 'Antartica', 'real cold hey');

-- --------------------------------------------------------

--
-- Table structure for table `email`
--

CREATE TABLE `email` (
  `email_id` int(11) NOT NULL,
  `email_address` text CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `flight`
--

CREATE TABLE `flight` (
  `flight_id` int(11) NOT NULL,
  `flight_reference` varchar(255) CHARACTER SET utf8 NOT NULL,
  `flight_checkin_utc_datetime` datetime NOT NULL,
  `departure_utc_datetime` datetime NOT NULL,
  `arrival_utc_datetime` datetime NOT NULL,
  `route_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `gps`
--

CREATE TABLE `gps` (
  `gps_id` int(11) NOT NULL,
  `gps_latitude` decimal(8,6) NOT NULL,
  `gps_longitude` decimal(9,6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `gps`
--

INSERT INTO `gps` (`gps_id`, `gps_latitude`, `gps_longitude`) VALUES
(4, '39.051426', '1.591422'),
(5, '39.001335', '1.574875'),
(6, '54.657828', '-6.221570'),
(9, '90.000000', '180.000000');

-- --------------------------------------------------------

--
-- Table structure for table `hotel`
--

CREATE TABLE `hotel` (
  `hotel_id` int(11) NOT NULL,
  `hotel_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `hotel_description` text CHARACTER SET utf8 NOT NULL,
  `hotel_check_in_local_time` time NOT NULL,
  `hotel_check_out_local_time` time NOT NULL,
  `hotel_additional_info` text CHARACTER SET utf8 DEFAULT NULL,
  `hotel_lift_count` int(11) NOT NULL,
  `hotel_floor_count` int(11) NOT NULL,
  `hotel_gps_id` int(11) NOT NULL,
  `hotel_address_id` int(11) NOT NULL,
  `hotel_star_rating_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `hotel`
--

INSERT INTO `hotel` (`hotel_id`, `hotel_name`, `hotel_description`, `hotel_check_in_local_time`, `hotel_check_out_local_time`, `hotel_additional_info`, `hotel_lift_count`, `hotel_floor_count`, `hotel_gps_id`, `hotel_address_id`, `hotel_star_rating_id`) VALUES
(3, 'Invisa Figueral Resort', 'The Invisa Figueral Resort is a spacious property spread across two hotels - the Cala Verde and the Cala Blanca. Guests can be located in either hotel but can use the facilities in both. The large resort boasts spectacular views of the bay of Playa Es Figueral from its hillside location and a short walk downhill will bring you to a beautiful sandy beach. All the ingredients for a great holiday are here in resort including a host of activities and facilities across the two hotels that kids, couples and families will love. The Pirates’ Island water activity zone is a wonderful way for kids of all ages to spend the day, while adults have their own chill out area as well as an adults only bar area. The Invisa Figueral Resort is perfect for a fantastic All Inclusive holiday in Ibiza!', '14:00:00', '12:00:00', 'Please note: due to its hillside location and the number of steps, this property may not be suitable for guests with walking difficulties. Each block contains only one room type, therefore bookings with multiple room types cannot be allocated in the same block.', 14, 3, 4, 1, 4),
(4, 'Atlantic by LLUM', 'Families seeking a pared-back pad with fab facilities… we bring you Atlantic by LLUM. Perfectly placed for a peaceful Playa Es Cana break, this understated base boasts a choice of basic rooms, studios and apartments. The hotel highlights include a kids’ club and children’s pool, a whirlpool for the grown-ups and an exciting entertainment programme! You can holiday your way thanks to the Self Catering, Half Board or All Inclusive options. Pretty as a postcard, the resort’s a bit of a show-off with its white sands, glimmering harbour and palm-speckled shorefront. There’s the famous Hippy Market every Wednesday too.', '14:00:00', '12:00:00', NULL, 2, 6, 5, 2, 7);

-- --------------------------------------------------------

--
-- Table structure for table `hotel_board_type`
--

CREATE TABLE `hotel_board_type` (
  `hotel_board_type_id` int(11) NOT NULL,
  `hotel_board_fee_gbp` decimal(13,4) NOT NULL,
  `board_type_description` text CHARACTER SET utf8 DEFAULT NULL,
  `board_type_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hotel_facility`
--

CREATE TABLE `hotel_facility` (
  `hotel_facility_id` int(11) NOT NULL,
  `hotel_facility_description` text CHARACTER SET utf8 NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `hotel_facility_type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hotel_facility_image`
--

CREATE TABLE `hotel_facility_image` (
  `hotel_facility_image_id` int(11) NOT NULL,
  `hotel_facility_type_id` int(11) NOT NULL,
  `image_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hotel_facility_type`
--

CREATE TABLE `hotel_facility_type` (
  `hotel_facility_type_id` int(11) NOT NULL,
  `hotel_facility_type_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hotel_image`
--

CREATE TABLE `hotel_image` (
  `hotel_image_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `image_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `image`
--

CREATE TABLE `image` (
  `image_id` int(11) NOT NULL,
  `image_url` text CHARACTER SET utf8 NOT NULL,
  `image_alt_text` varchar(255) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `passenger`
--

CREATE TABLE `passenger` (
  `passenger_id` int(11) NOT NULL,
  `passenger_first_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `passenger_last_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `passenger_date_of_birth` date NOT NULL,
  `passenger_title_id` int(11) NOT NULL,
  `passenger_passport_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `passport`
--

CREATE TABLE `passport` (
  `passport_id` int(11) NOT NULL,
  `passport_number` varchar(255) CHARACTER SET utf8 NOT NULL,
  `passport_expiry_date` date NOT NULL,
  `passport_country_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL,
  `payment_amount_gbp` decimal(13,4) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `payment_card_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `payment_card`
--

CREATE TABLE `payment_card` (
  `payment_card_id` int(11) NOT NULL,
  `payment_card_long_number` int(16) NOT NULL,
  `payment_card_expiry_date` date NOT NULL,
  `booking_contact_id` int(11) NOT NULL,
  `card_vendor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `review_id` int(11) NOT NULL,
  `review_date` date DEFAULT current_timestamp(),
  `review_content` text CHARACTER SET utf8 NOT NULL,
  `review_hotel_id` int(11) NOT NULL,
  `reviewer_id` int(11) NOT NULL,
  `review_rating_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `review_rating`
--

CREATE TABLE `review_rating` (
  `review_rating_id` int(11) NOT NULL,
  `review_rating` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `room_id` int(11) NOT NULL,
  `room_number` varchar(10) NOT NULL,
  `room_type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `room_booking`
--

CREATE TABLE `room_booking` (
  `room_booking_id` int(11) NOT NULL,
  `room_booking_booking_id` int(11) NOT NULL,
  `room_booking_room_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `room_facility`
--

CREATE TABLE `room_facility` (
  `room_facility_id` int(11) NOT NULL,
  `room_facility_name` varchar(255) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `room_image`
--

CREATE TABLE `room_image` (
  `room_image_id` int(11) NOT NULL,
  `room_type_id` int(11) NOT NULL,
  `image_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `room_type`
--

CREATE TABLE `room_type` (
  `room_type_id` int(11) NOT NULL,
  `room_type_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `room_type_description` text CHARACTER SET utf8 DEFAULT NULL,
  `room_type_min_occup` int(11) NOT NULL,
  `room_type_max_occup` int(11) NOT NULL,
  `base_quantity` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `room_type_facility`
--

CREATE TABLE `room_type_facility` (
  `room_type_facility_id` int(11) NOT NULL,
  `room_type_id` int(11) NOT NULL,
  `room_facility_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `room_type_price`
--

CREATE TABLE `room_type_price` (
  `room_type_price_id` int(11) NOT NULL,
  `price_gbp` decimal(13,4) NOT NULL,
  `valid_from_utc_datetime` datetime NOT NULL,
  `valid_to_utc_datetime` datetime NOT NULL,
  `room_type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `route`
--

CREATE TABLE `route` (
  `route_id` int(11) NOT NULL,
  `route_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `departure_airport_id` int(11) NOT NULL,
  `arrival_airport_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `star_rating`
--

CREATE TABLE `star_rating` (
  `start_rating_id` int(11) NOT NULL,
  `star_rating_name` varchar(255) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `star_rating`
--

INSERT INTO `star_rating` (`start_rating_id`, `star_rating_name`) VALUES
(1, '1'),
(2, '2'),
(3, '3'),
(4, '4'),
(5, '4 plus'),
(6, '5'),
(7, '3 plus');

-- --------------------------------------------------------

--
-- Table structure for table `telephone`
--

CREATE TABLE `telephone` (
  `telephone_id` int(11) NOT NULL,
  `telephone_number` varchar(50) CHARACTER SET utf8 NOT NULL,
  `telephone_type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `telephone_type`
--

CREATE TABLE `telephone_type` (
  `telephone_type_id` int(11) NOT NULL,
  `telephone_type_name` varchar(255) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `title`
--

CREATE TABLE `title` (
  `title_id` int(11) NOT NULL,
  `title_abbreviation` varchar(10) CHARACTER SET utf8 NOT NULL,
  `title_name` varchar(255) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tmp`
--

CREATE TABLE `tmp` (
  `value` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `town_city`
--

CREATE TABLE `town_city` (
  `town_city_id` int(11) NOT NULL,
  `town_city_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `town_city_country_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `town_city`
--

INSERT INTO `town_city` (`town_city_id`, `town_city_name`, `town_city_country_id`) VALUES
(1, 'Belfast', 1),
(2, 'Birmingham', 5),
(3, 'Edinburgh', 7),
(4, 'Es Figueral', 10),
(5, 'Es Canar', 10),
(8, 'Anty Town', 19);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`address_id`),
  ADD UNIQUE KEY `addressUnique` (`address_line_1`,`address_line_2`,`postcode`,`town_city_id`) USING BTREE,
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
  ADD UNIQUE KEY `country_name` (`country_name`);

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
  ADD KEY `FK__address__address_id_3` (`hotel_address_id`);

--
-- Indexes for table `hotel_board_type`
--
ALTER TABLE `hotel_board_type`
  ADD PRIMARY KEY (`hotel_board_type_id`),
  ADD KEY `FK__board_type__board_type_id` (`board_type_id`),
  ADD KEY `FK__hotel__hotel_id_3` (`hotel_id`);

--
-- Indexes for table `hotel_facility`
--
ALTER TABLE `hotel_facility`
  ADD PRIMARY KEY (`hotel_facility_id`),
  ADD KEY `FK__hotel__hotel_id_2` (`hotel_id`),
  ADD KEY `FK__hotel_facility_type__hotel_facility_type_id` (`hotel_facility_type_id`);

--
-- Indexes for table `hotel_facility_image`
--
ALTER TABLE `hotel_facility_image`
  ADD PRIMARY KEY (`hotel_facility_image_id`),
  ADD KEY `FK__image__image_id` (`image_id`),
  ADD KEY `FK__hotel_facility_type__hotel_facility_type_id_2` (`hotel_facility_type_id`);

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
  ADD KEY `FK__hotel__hotel_id_4` (`hotel_id`),
  ADD KEY `FK__image__image_id_2` (`image_id`);

--
-- Indexes for table `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`image_id`);

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
  ADD KEY `FK__country__country_id` (`passport_country_id`);

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
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`review_id`),
  ADD UNIQUE KEY `reviewer_id` (`reviewer_id`),
  ADD KEY `FK__review_rating__review_rating_id` (`review_rating_id`);

--
-- Indexes for table `review_rating`
--
ALTER TABLE `review_rating`
  ADD PRIMARY KEY (`review_rating_id`);

--
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`room_id`),
  ADD KEY `FK__room_type__room_type_id` (`room_type_id`);

--
-- Indexes for table `room_booking`
--
ALTER TABLE `room_booking`
  ADD PRIMARY KEY (`room_booking_id`),
  ADD KEY `FK__booking__booking_id_2` (`room_booking_booking_id`),
  ADD KEY `FK__room__room_id` (`room_booking_room_id`);

--
-- Indexes for table `room_facility`
--
ALTER TABLE `room_facility`
  ADD PRIMARY KEY (`room_facility_id`);

--
-- Indexes for table `room_image`
--
ALTER TABLE `room_image`
  ADD PRIMARY KEY (`room_image_id`),
  ADD KEY `FK__room_type__room_type_id_2` (`room_type_id`),
  ADD KEY `FK__image__image_id_3` (`image_id`);

--
-- Indexes for table `room_type`
--
ALTER TABLE `room_type`
  ADD PRIMARY KEY (`room_type_id`),
  ADD KEY `FK__hotel__hotel_id` (`hotel_id`);

--
-- Indexes for table `room_type_facility`
--
ALTER TABLE `room_type_facility`
  ADD PRIMARY KEY (`room_type_facility_id`),
  ADD KEY `FK__room_facility__room_facility_id` (`room_facility_id`),
  ADD KEY `FK__room_type__room_type_id_3` (`room_type_id`);

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
-- Indexes for table `star_rating`
--
ALTER TABLE `star_rating`
  ADD PRIMARY KEY (`start_rating_id`);

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
  ADD KEY `FK__country__country_id_2` (`town_city_country_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `airport`
--
ALTER TABLE `airport`
  MODIFY `airport_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `board_type`
--
ALTER TABLE `board_type`
  MODIFY `board_type_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `booking_contact`
--
ALTER TABLE `booking_contact`
  MODIFY `booking_contact_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `booking_contact_telephone`
--
ALTER TABLE `booking_contact_telephone`
  MODIFY `booking_contact_telephone_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `booking_passenger`
--
ALTER TABLE `booking_passenger`
  MODIFY `booking_passenger_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `card_vendor`
--
ALTER TABLE `card_vendor`
  MODIFY `card_vendor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `country_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `email`
--
ALTER TABLE `email`
  MODIFY `email_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `flight`
--
ALTER TABLE `flight`
  MODIFY `flight_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gps`
--
ALTER TABLE `gps`
  MODIFY `gps_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `hotel`
--
ALTER TABLE `hotel`
  MODIFY `hotel_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `hotel_board_type`
--
ALTER TABLE `hotel_board_type`
  MODIFY `hotel_board_type_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hotel_facility`
--
ALTER TABLE `hotel_facility`
  MODIFY `hotel_facility_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hotel_facility_image`
--
ALTER TABLE `hotel_facility_image`
  MODIFY `hotel_facility_image_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hotel_facility_type`
--
ALTER TABLE `hotel_facility_type`
  MODIFY `hotel_facility_type_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hotel_image`
--
ALTER TABLE `hotel_image`
  MODIFY `hotel_image_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `image`
--
ALTER TABLE `image`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `passenger`
--
ALTER TABLE `passenger`
  MODIFY `passenger_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `passport`
--
ALTER TABLE `passport`
  MODIFY `passport_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_card`
--
ALTER TABLE `payment_card`
  MODIFY `payment_card_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `review_rating`
--
ALTER TABLE `review_rating`
  MODIFY `review_rating_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `room`
--
ALTER TABLE `room`
  MODIFY `room_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `room_booking`
--
ALTER TABLE `room_booking`
  MODIFY `room_booking_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `room_facility`
--
ALTER TABLE `room_facility`
  MODIFY `room_facility_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `room_image`
--
ALTER TABLE `room_image`
  MODIFY `room_image_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `room_type`
--
ALTER TABLE `room_type`
  MODIFY `room_type_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `room_type_facility`
--
ALTER TABLE `room_type_facility`
  MODIFY `room_type_facility_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `room_type_price`
--
ALTER TABLE `room_type_price`
  MODIFY `room_type_price_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `route`
--
ALTER TABLE `route`
  MODIFY `route_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `star_rating`
--
ALTER TABLE `star_rating`
  MODIFY `start_rating_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `telephone`
--
ALTER TABLE `telephone`
  MODIFY `telephone_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `telephone_type`
--
ALTER TABLE `telephone_type`
  MODIFY `telephone_type_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `title`
--
ALTER TABLE `title`
  MODIFY `title_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `town_city`
--
ALTER TABLE `town_city`
  MODIFY `town_city_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

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
-- Constraints for table `booking_passenger`
--
ALTER TABLE `booking_passenger`
  ADD CONSTRAINT `FK__booking__booking_id` FOREIGN KEY (`booking_passenger_booking_id`) REFERENCES `booking` (`booking_id`),
  ADD CONSTRAINT `FK__passenger__passenger_id_2` FOREIGN KEY (`booking_passenger_passenger_id`) REFERENCES `passenger` (`passenger_id`);

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
  ADD CONSTRAINT `FK__gps__gps_id` FOREIGN KEY (`hotel_gps_id`) REFERENCES `gps` (`gps_id`),
  ADD CONSTRAINT `FK__star_rating__star_rating_id` FOREIGN KEY (`hotel_star_rating_id`) REFERENCES `star_rating` (`start_rating_id`);

--
-- Constraints for table `hotel_board_type`
--
ALTER TABLE `hotel_board_type`
  ADD CONSTRAINT `FK__board_type__board_type_id` FOREIGN KEY (`board_type_id`) REFERENCES `board_type` (`board_type_id`),
  ADD CONSTRAINT `FK__hotel__hotel_id_3` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`);

--
-- Constraints for table `hotel_facility`
--
ALTER TABLE `hotel_facility`
  ADD CONSTRAINT `FK__hotel__hotel_id_2` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`),
  ADD CONSTRAINT `FK__hotel_facility_type__hotel_facility_type_id` FOREIGN KEY (`hotel_facility_type_id`) REFERENCES `hotel_facility_type` (`hotel_facility_type_id`);

--
-- Constraints for table `hotel_facility_image`
--
ALTER TABLE `hotel_facility_image`
  ADD CONSTRAINT `FK__hotel_facility_type__hotel_facility_type_id_2` FOREIGN KEY (`hotel_facility_type_id`) REFERENCES `hotel_facility_type` (`hotel_facility_type_id`),
  ADD CONSTRAINT `FK__image__image_id` FOREIGN KEY (`image_id`) REFERENCES `image` (`image_id`);

--
-- Constraints for table `hotel_image`
--
ALTER TABLE `hotel_image`
  ADD CONSTRAINT `FK__hotel__hotel_id_4` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`),
  ADD CONSTRAINT `FK__image__image_id_2` FOREIGN KEY (`image_id`) REFERENCES `image` (`image_id`);

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
  ADD CONSTRAINT `FK__country__country_id` FOREIGN KEY (`passport_country_id`) REFERENCES `country` (`country_id`);

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
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `FK__booking_contact__booking_contact_id_4` FOREIGN KEY (`reviewer_id`) REFERENCES `booking_contact` (`booking_contact_id`),
  ADD CONSTRAINT `FK__review_rating__review_rating_id` FOREIGN KEY (`review_rating_id`) REFERENCES `review_rating` (`review_rating_id`);

--
-- Constraints for table `room`
--
ALTER TABLE `room`
  ADD CONSTRAINT `FK__room_type__room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `room_type` (`room_type_id`);

--
-- Constraints for table `room_booking`
--
ALTER TABLE `room_booking`
  ADD CONSTRAINT `FK__booking__booking_id_2` FOREIGN KEY (`room_booking_booking_id`) REFERENCES `booking` (`booking_id`),
  ADD CONSTRAINT `FK__room__room_id` FOREIGN KEY (`room_booking_room_id`) REFERENCES `room` (`room_id`);

--
-- Constraints for table `room_image`
--
ALTER TABLE `room_image`
  ADD CONSTRAINT `FK__image__image_id_3` FOREIGN KEY (`image_id`) REFERENCES `image` (`image_id`),
  ADD CONSTRAINT `FK__room_type__room_type_id_2` FOREIGN KEY (`room_type_id`) REFERENCES `room_type` (`room_type_id`);

--
-- Constraints for table `room_type`
--
ALTER TABLE `room_type`
  ADD CONSTRAINT `FK__hotel__hotel_id` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`);

--
-- Constraints for table `room_type_facility`
--
ALTER TABLE `room_type_facility`
  ADD CONSTRAINT `FK__room_facility__room_facility_id` FOREIGN KEY (`room_facility_id`) REFERENCES `room_facility` (`room_facility_id`),
  ADD CONSTRAINT `FK__room_type__room_type_id_3` FOREIGN KEY (`room_type_id`) REFERENCES `room_type` (`room_type_id`);

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
-- Constraints for table `telephone`
--
ALTER TABLE `telephone`
  ADD CONSTRAINT `FK__telephone_type__telephone_type_id` FOREIGN KEY (`telephone_type_id`) REFERENCES `telephone_type` (`telephone_type_id`);

--
-- Constraints for table `town_city`
--
ALTER TABLE `town_city`
  ADD CONSTRAINT `FK__country__country_id_2` FOREIGN KEY (`town_city_country_id`) REFERENCES `country` (`country_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
