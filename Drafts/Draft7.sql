-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 29, 2022 at 10:54 PM
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertArea` (IN `AreaName` VARCHAR(255), IN `AreaDescription` TEXT)   INSERT INTO area
	(area.area_name,
    area.area_description)
VALUES
	(AreaName, AreaDescription)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertBoardType` (IN `BoardTypeName` VARCHAR(255))   INSERT INTO board_type 
	(board_type.board_type_name)
VALUES 
	(BoardTypeName)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertBooking` (IN `Ref` VARCHAR(255), IN `MadeTimestamp` TIMESTAMP, IN `CostGbp` DECIMAL(13,4), IN `BookingContactId` INT, IN `ReturnFlightId` INT, IN `OutboundFlightId` INT)   INSERT INTO booking 
	(
    	booking.booking_reference,
        booking.booking_made_utc_datetime,
        booking.total_cost_gbp,
        booking.booking_contact_id,
        booking.return_flight_id,
        booking.outbound_flight_id
    )
VALUES 
	(
        Ref, 
        MadeTimestamp, 
        CostGbp, 
        BookingContactId,
        ReturnFlightId,
        OutboundFlightId
    )$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertEmail` (IN `EmailAddress` TEXT)   INSERT INTO email
	(email.email_address)
VALUES
	(EmailAddress)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertFlight` (IN `FlightRef` VARCHAR(255), IN `CheckIn` DATETIME, IN `Departure` DATETIME, IN `Arrival` DATETIME, IN `RouteId` INT(11))   INSERT INTO flight
	(
        flight.flight_reference,
        flight.flight_checkin_utc_datetime,
        flight.departure_utc_datetime,
        flight.arrival_utc_datetime,
        flight.route_id
	)
VALUES
	(FlightRef, CheckIn, Departure, Arrival, RouteId)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertFlightPrice` (IN `Price` DECIMAL(13,4), IN `ValidFrom` DATETIME, IN `ValidTo` DATETIME, IN `FlightId` INT(11))   INSERT INTO flight_price
	(
        flight_price.flight_price_gbp,
        flight_price.flight_price_valid_from_datetime,
        flight_price.flight_price_valid_to_datetime,
        flight_price.flight_id
	)
VALUES
	(Price, ValidFrom, ValidTo, FlightId)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertGps` (IN `GpsLat` DECIMAL(8,6), IN `GpsLong` DECIMAL(9,6))   INSERT INTO gps	(gps.gps_latitude, gps.gps_longitude)
VALUES (GpsLat, GpsLong)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertHotel` (IN `Name` VARCHAR(255), IN `HotelDescription` TEXT, IN `CheckIn` TIME, IN `CheckOut` TIME, IN `AdditionalInfo` TEXT, IN `LiftCount` INT, IN `FloorCount` INT, IN `GpsId` INT, IN `AddressId` INT, IN `HotelStarRatingId` INT)   INSERT INTO hotel 
	(
        hotel.hotel_name,
        hotel.hotel_description,
        hotel.hotel_check_in_local_time,
        hotel.hotel_check_out_local_time,
        hotel.hotel_additional_info,
        hotel.hotel_lift_count,
        hotel.hotel_floor_count,
        hotel.hotel_gps_id,
        hotel.hotel_address_id,
        hotel.hotel_star_rating_id
    )
VALUES 
	(
        Name,
        HotelDescription,
        CheckIn,
        CheckOut,
        AdditionalInfo,
        LiftCount,
        FloorCount,
        GpsId,
        AddressId,
        HotelStarRatingId
    )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertHotelBoardType` (IN `Fee` DECIMAL(13,4), IN `Description` TEXT, IN `BoardTypeId` INT(11), IN `HotelId` INT(11))   INSERT INTO hotel_board_type
	(
        hotel_board_type.hotel_board_fee_gbp,
        hotel_board_type.board_type_description,
        hotel_board_type.board_type_id,
        hotel_board_type.hotel_id
    )
VALUES 
	(Fee, Description, BoardTypeId, HotelId)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertHotelFacility` (IN `Description` TEXT, IN `HotelId` INT, IN `FacilityTypeId` INT)   INSERT INTO hotel_facility
	(
        hotel_facility.hotel_facility_description,
    	hotel_facility.hotel_id,
    	hotel_facility.hotel_facility_type_id
    )
VALUES 
	(Description, HotelId, FacilityTypeId)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertHotelFacilityImage` (IN `HotelFacilityTypeId` INT, IN `ImageId` INT)   INSERT INTO hotel_facility_image
	(
        hotel_facility_image.hotel_facility_type_id,
        hotel_facility_image.image_id
    )
VALUES 
	(HotelFacilityTypeId, ImageId)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertHotelFacilityType` (IN `FacilityTypeName` VARCHAR(255))   INSERT INTO hotel_facility_type 
	(hotel_facility_type.hotel_facility_type_name)
VALUES 
	(FacilityTypeName)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertHotelImage` (IN `HotelId` INT, IN `ImageId` INT)   INSERT INTO hotel_image
	(
        hotel_image.hotel_id,
        hotel_image.image_id
	)
VALUES (HotelId, ImageId)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertHotelResort` (IN `ResortId` INT, IN `HotelId` INT)   INSERT INTO hotel_resort
	(
    	hotel_resort.hotel_resort_resort_id,
        hotel_resort.hotel_resort_hotel_id
    )
VALUES
	(ResortId, HotelId)$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertPassport` (IN `PassportNumber` VARCHAR(255), IN `PassportExpiryDate` DATE, IN `PassportAreaId` INT)   INSERT INTO passport
	(passport.passport_number,
    passport.passport_expiry_date,
    passport.passport_area_id)
VALUES
	(PassportNumber, PassportExpiryDate, PassportAreaId)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertPayment` (IN `PaymentAmount` DECIMAL(13,4), IN `BookingId` INT, IN `CardId` INT)   INSERT INTO payment
	(
    	payment.payment_amount_gbp,
        payment.booking_id,
        payment.payment_card_id
    )
VALUES 
	(PaymentAmount, BookingId, CardId)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertPaymentCard` (IN `LongNum` VARBINARY(255), IN `Expiry` DATE, IN `BookingContactId` INT, IN `CardVendorId` INT)   INSERT INTO payment_card 
	(
    	payment_card.payment_card_long_number,
        payment_card.payment_card_expiry_date,
        payment_card.booking_contact_id,
        payment_card.card_vendor_id
    )
VALUES 
	(LongNum, Expiry, BookingContactId, CardVendorId)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertResort` (IN `ResortName` VARCHAR(255), IN `ResortDesc` TEXT, IN `ResortAreaId` INT)   INSERT INTO resort
	(
    	resort.resort_name,
        resort.resort_description,
        resort.resort_area_id
    )
VALUES
	(ResortName, ResortDesc, ResortAreaId)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertReview` (IN `ReviewDate` DATE, IN `ReviewContent` TEXT, IN `ReviewHotelId` INT, IN `ReviewerId` INT, IN `ReviewRatingId` INT)   INSERT INTO review
	(
        review.review_date,
        review.review_content,
        review.review_hotel_id,
        review.reviewer_id,
        review.review_rating_id
	)
VALUES 
	(
        ReviewDate, 
        ReviewContent, 
        ReviewHotelId, 
        ReviewerId, 
        ReviewRatingId
    )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertReviewRating` (IN `ReviewRating` INT(1))   INSERT INTO review_rating (review_rating.review_rating)
VALUES (ReviewRating)$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertRoomFacility` (IN `RoomFacilityName` VARCHAR(255))   INSERT INTO room_facility (room_facility.room_facility_name)
VALUES (RoomFacilityName)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertRoomImage` (IN `RoomTypeId` INT, IN `ImageId` INT)   INSERT INTO room_image
	(
        room_image.room_type_id,
        room_image.image_id
    )
VALUES 
	(RoomTypeId, ImageId)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertRoomType` (IN `RoomTypeName` VARCHAR(255), IN `RoomTypeDesc` TEXT, IN `RoomTypeMinOcc` INT, IN `RoomTypeMaxOcc` INT, IN `RoomTypeBaseQuantity` INT, IN `RoomTypeHotelId` INT)   INSERT INTO room_type
	(
        room_type.room_type_name,
        room_type.room_type_description,
        room_type.room_type_min_occup,
        room_type.room_type_max_occup,
        room_type.base_quantity,
        room_type.hotel_id
    )
VALUES
	(
        RoomTypeName,
        RoomTypeDesc,
        RoomTypeMinOcc,
        RoomTypeMaxOcc,
        RoomTypeBaseQuantity,
        RoomTypeHotelId
	)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertRoomTypeFacility` (IN `RoomTypeId` INT, IN `RoomFacilityId` INT)   INSERT INTO room_type_facility
	(
        room_type_facility.room_type_id,
        room_type_facility.room_facility_id
    )
VALUES 
	(RoomTypeId,RoomFacilityId)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertRoomTypePrice` (IN `PriceGbp` DECIMAL(13,4), IN `ValidFromDt` DATE, IN `ValidToDt` DATE, IN `RoomTypeId` INT)   INSERT INTO room_type_price
	(
        room_type_price.room_type_price_gbp,
        room_type_price.valid_from_utc_datetime,
        room_type_price.valid_to_utc_datetime,
        room_type_price.room_type_id
	)
VALUES 
	(PriceGbp, ValidFromDt, ValidToDt, RoomTypeId)$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertTitle` (IN `TitleAbbr` VARCHAR(10))   INSERT INTO title (title.title_abbreviation )
VALUES (TitleAbbr)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uspInsertTownCity` (IN `TownCityName` VARCHAR(255), IN `TownCityAreaId` INT)   INSERT INTO town_city
	(town_city.town_city_name,
     town_city.town_city_area_id)
VALUES
	(TownCityName,
     TownCityAreaId)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `WIPuspCreateBooking` ()   SELECT SUM(combined.price_gbp) FROM booking
RIGHT JOIN room_booking ON booking.booking_id = room_booking.room_booking_booking_id 
LEFT JOIN room ON room.room_id = room_booking.room_booking_room_id
LEFT JOIN room_type ON room_type.room_type_id = room.room_type_id
LEFT JOIN room_type_price ON room_type_price.room_type_id = room.room_id
WHERE booking.booking_id = '1'$$

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
(22, 'Greek Hotel2 lineaddressline1', 'Greek Hotel2 lineaddressline2', 'GBDFBDF45454545', 'GreekHotel2county', 24);

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
(9, 'Tenerife Mock Airport\r\n', 'TEA', 16, 16);

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
  `total_cost_gbp` decimal(13,4) NOT NULL,
  `booking_contact_id` int(11) NOT NULL,
  `return_flight_id` int(11) NOT NULL,
  `outbound_flight_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

-- --------------------------------------------------------

--
-- Table structure for table `booking_contact_telephone`
--

CREATE TABLE `booking_contact_telephone` (
  `booking_contact_telephone_id` int(11) NOT NULL,
  `booking_contact_telephone_booking_contact_id` int(11) NOT NULL,
  `booking_contact_telephone_telephone_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `booking_passenger`
--

CREATE TABLE `booking_passenger` (
  `booking_passenger_id` int(11) NOT NULL,
  `booking_passenger_booking_id` int(11) NOT NULL,
  `booking_passenger_passenger_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `destination_location_name` int(11) NOT NULL,
  `destination_country_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `destination`
--

INSERT INTO `destination` (`destination_id`, `destination_description`, `destination_location_name`, `destination_country_id`) VALUES
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
(7, 'ghulcoop5@mayoclinic.com'),
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
(26, 'tfullerdo@techcrunch.com');

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
(1, 'JT1', '2022-01-01 22:00:00', '2023-01-01 00:20:00', '2023-01-01 02:00:00', 1),
(2, 'JT2', '2023-01-01 10:00:01', '2023-01-01 12:20:01', '2023-01-01 14:20:01', 1);

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
  `hotel_resort_id` int(11) NOT NULL,
  `hotel_gps_id` int(11) NOT NULL,
  `hotel_address_id` int(11) NOT NULL,
  `hotel_star_rating_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `hotel`
--

INSERT INTO `hotel` (`hotel_id`, `hotel_name`, `hotel_description`, `hotel_additional_info`, `hotel_lift_count`, `hotel_floor_count`, `hotel_block_count`, `hotel_resort_id`, `hotel_gps_id`, `hotel_address_id`, `hotel_star_rating_id`) VALUES
(11, 'Spanish Hotel 1', 'Spanish Hotel 1 desc', 'Spanish Hotel 1 additional info', 1, 2, 4, 1, 30, 17, 8),
(12, 'Spanish Hotel 2', 'Spanish Hotel 2 desc', NULL, 4, 7, NULL, 2, 29, 18, 11),
(13, 'Spanish Hotel 3', 'Spanish Hotel 3 desc', 'Spanish Hotel 3 additional info', 5, 5, NULL, 3, 26, 19, 11),
(14, 'Turkish Hotel 1', 'Turkish Hotel 1 desc', NULL, 0, 1, 2, 9, 21, 20, 13),
(15, 'Greek Hotel 1', 'Greek Hotel 1 desc', NULL, 10, 20, NULL, 7, 19, 21, 15),
(16, 'Greek Hotel 2', 'Greek Hotel 2 desc', 'Greek Hotel 2 additional info', 1, 2, NULL, 8, 14, 22, 13);

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

-- --------------------------------------------------------

--
-- Table structure for table `hotel_bullet`
--

CREATE TABLE `hotel_bullet` (
  `hotel_bullet_id` int(11) NOT NULL,
  `hotel_bullet` text NOT NULL,
  `hotel_bullet_hotel_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hotel_facility`
--

CREATE TABLE `hotel_facility` (
  `hotel_facility_id` int(11) NOT NULL,
  `hotel_facility_description` text NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `hotel_facility_type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

-- --------------------------------------------------------

--
-- Table structure for table `hotel_resort`
--

CREATE TABLE `hotel_resort` (
  `hotel_resort_id` int(11) NOT NULL,
  `hotel_resort_resort_id` int(11) NOT NULL,
  `hotel_resort_hotel_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
(4, 'Donna\r\n', 'Data\r\n', '1992-02-28', 5, 5);

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
(5, 'A54841354\r\n', '2025-09-08', 9);

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

-- --------------------------------------------------------

--
-- Table structure for table `payment_card`
--

CREATE TABLE `payment_card` (
  `payment_card_id` int(11) NOT NULL,
  `payment_card_long_number` varbinary(255) NOT NULL,
  `payment_card_expiry_date` date NOT NULL,
  `booking_contact_id` int(11) NOT NULL,
  `card_vendor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
(9, 'Kalamaki\r\n', 'A popular choice for families, Kalamaki boasts everything from quiet to fun-filled nights, topped off with all the usual trappings of a bustling seaside resort. We’re talking souvenir shops, crazy golf – the works! And where the sandy beach meets the Bay of Laganas, you’ll want to keep your peepers peeled for the famous Caretta Caretta turtles.\r\n', 6);

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `review_id` int(11) NOT NULL,
  `review_date` date DEFAULT current_timestamp(),
  `review_content` text NOT NULL,
  `review_hotel_id` int(11) NOT NULL,
  `reviewer_id` int(11) NOT NULL,
  `review_rating_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `room_id` int(11) NOT NULL,
  `room_number` varchar(10) NOT NULL,
  `room_type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `room_booking`
--

CREATE TABLE `room_booking` (
  `room_booking_id` int(11) NOT NULL,
  `room_booking_booking_id` int(11) NOT NULL,
  `room_booking_room_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `room_facility`
--

CREATE TABLE `room_facility` (
  `room_facility_id` int(11) NOT NULL,
  `room_facility_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `room_type`
--

CREATE TABLE `room_type` (
  `room_type_id` int(11) NOT NULL,
  `room_type_name` varchar(255) NOT NULL,
  `room_type_description` text DEFAULT NULL,
  `room_type_min_occup` int(11) NOT NULL,
  `room_type_max_occup` int(11) NOT NULL,
  `base_quantity` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `room_type_facility`
--

CREATE TABLE `room_type_facility` (
  `room_type_facility_id` int(11) NOT NULL,
  `room_type_id` int(11) NOT NULL,
  `room_facility_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
(8, 'Turkey to Belfast', 8, 5);

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
(24, '566.6500', '2023-01-01 18:00:00', '2023-01-01 23:59:59', 8);

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
(34, '(593) 8462131', 2);

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
  ADD KEY `FK__location_name__location_name_2` (`destination_location_name`);

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
  ADD KEY `FK__resort__resort_id_2` (`hotel_resort_id`);

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
  ADD PRIMARY KEY (`hotel_bullet_id`);

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
-- Indexes for table `hotel_resort`
--
ALTER TABLE `hotel_resort`
  ADD PRIMARY KEY (`hotel_resort_id`),
  ADD KEY `FK__resort__resort_id` (`hotel_resort_resort_id`),
  ADD KEY `FK__hotel__hotel_id_5` (`hotel_resort_hotel_id`);

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
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `airport`
--
ALTER TABLE `airport`
  MODIFY `airport_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `board_type`
--
ALTER TABLE `board_type`
  MODIFY `board_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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
  MODIFY `email_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `flight`
--
ALTER TABLE `flight`
  MODIFY `flight_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `gps`
--
ALTER TABLE `gps`
  MODIFY `gps_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `hotel`
--
ALTER TABLE `hotel`
  MODIFY `hotel_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `hotel_board_type`
--
ALTER TABLE `hotel_board_type`
  MODIFY `hotel_board_type_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hotel_bullet`
--
ALTER TABLE `hotel_bullet`
  MODIFY `hotel_bullet_id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `hotel_facility_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `hotel_image`
--
ALTER TABLE `hotel_image`
  MODIFY `hotel_image_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hotel_resort`
--
ALTER TABLE `hotel_resort`
  MODIFY `hotel_resort_id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `passenger_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `passport`
--
ALTER TABLE `passport`
  MODIFY `passport_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
-- AUTO_INCREMENT for table `region`
--
ALTER TABLE `region`
  MODIFY `region_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `region_descriptor`
--
ALTER TABLE `region_descriptor`
  MODIFY `region_descriptor_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `resort`
--
ALTER TABLE `resort`
  MODIFY `resort_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `review_rating`
--
ALTER TABLE `review_rating`
  MODIFY `review_rating_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
-- AUTO_INCREMENT for table `room_type_image`
--
ALTER TABLE `room_type_image`
  MODIFY `room_type_image_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `room_type_price`
--
ALTER TABLE `room_type_price`
  MODIFY `room_type_price_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `route`
--
ALTER TABLE `route`
  MODIFY `route_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `route_price`
--
ALTER TABLE `route_price`
  MODIFY `route_price_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `star_rating`
--
ALTER TABLE `star_rating`
  MODIFY `star_rating_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `telephone`
--
ALTER TABLE `telephone`
  MODIFY `telephone_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

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
  ADD CONSTRAINT `FK__location_name__location_name_2` FOREIGN KEY (`destination_location_name`) REFERENCES `location_name` (`location_name_id`);

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
  ADD CONSTRAINT `FK__resort__resort_id_2` FOREIGN KEY (`hotel_resort_id`) REFERENCES `resort` (`resort_id`),
  ADD CONSTRAINT `FK__star_rating__star_rating_id` FOREIGN KEY (`hotel_star_rating_id`) REFERENCES `star_rating` (`star_rating_id`);

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
  ADD CONSTRAINT `FK__hotel_facility__hotel_facility_id` FOREIGN KEY (`hotel_facility_image_hotel_facility_id`) REFERENCES `hotel_facility` (`hotel_facility_id`);

--
-- Constraints for table `hotel_image`
--
ALTER TABLE `hotel_image`
  ADD CONSTRAINT `FK__hotel__hotel_id_6` FOREIGN KEY (`hotel_image_hotel_id`) REFERENCES `hotel` (`hotel_id`);

--
-- Constraints for table `hotel_resort`
--
ALTER TABLE `hotel_resort`
  ADD CONSTRAINT `FK__hotel__hotel_id_5` FOREIGN KEY (`hotel_resort_hotel_id`) REFERENCES `hotel` (`hotel_id`),
  ADD CONSTRAINT `FK__resort__resort_id` FOREIGN KEY (`hotel_resort_resort_id`) REFERENCES `resort` (`resort_id`);

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
