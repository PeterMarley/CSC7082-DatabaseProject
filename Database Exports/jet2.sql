-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 23, 2022 at 01:12 AM
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

-- --------------------------------------------------------

--
-- Table structure for table `airport`
--

CREATE TABLE `airport` (
  `airport_id` int(11) NOT NULL,
  `airport_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `airport_iata_code` varchar(3) CHARACTER SET utf8 NOT NULL,
  `airport_gps_address_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `address_id` int(11) NOT NULL,
  `passenger_id` int(11) NOT NULL,
  `email_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `booking_contact_telephone`
--

CREATE TABLE `booking_contact_telephone` (
  `booking_contact_telephone_id` int(11) NOT NULL,
  `booking_contact_id` int(11) NOT NULL,
  `telephone_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `booking_passenger`
--

CREATE TABLE `booking_passenger` (
  `booking_passenger_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `passenger_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `card_vendor`
--

CREATE TABLE `card_vendor` (
  `card_vendor_id` int(11) NOT NULL,
  `card_vendor_name` varchar(255) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE `country` (
  `country_id` int(11) NOT NULL,
  `country_code` varchar(10) CHARACTER SET utf8 NOT NULL,
  `country_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `country_currency_id` int(11) NOT NULL,
  `country_language_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `currency`
--

CREATE TABLE `currency` (
  `currency_id` int(11) NOT NULL,
  `currency_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `currency_symbol` varchar(1) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
-- Table structure for table `gps_address`
--

CREATE TABLE `gps_address` (
  `gps_address_id` int(11) NOT NULL,
  `gps_latitude` decimal(8,6) NOT NULL,
  `gps_longitude` decimal(9,6) NOT NULL,
  `address_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hotel`
--

CREATE TABLE `hotel` (
  `hotel_id` int(11) NOT NULL,
  `hotel_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `hotel_description` text CHARACTER SET utf8 NOT NULL,
  `hotel_check_in_utc_datetime` datetime NOT NULL,
  `hotel_check_out_utc_datetime` datetime NOT NULL,
  `hotel_additional_info` text CHARACTER SET utf8 DEFAULT NULL,
  `hotel_lift_count` int(11) NOT NULL,
  `hotel_floor_count` int(11) NOT NULL,
  `hotel_gps_address_id` int(11) NOT NULL,
  `hotel_star_rating_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hotel_board_type`
--

CREATE TABLE `hotel_board_type` (
  `hotel_board_type_id` int(11) NOT NULL,
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
  `hotel_facility_id` int(11) NOT NULL,
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
-- Table structure for table `language`
--

CREATE TABLE `language` (
  `language_id` int(11) NOT NULL,
  `language_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `language_code` varchar(10) CHARACTER SET utf8 NOT NULL
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
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `room_id` int(11) NOT NULL,
  `room_number` int(11) NOT NULL,
  `room_type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `room_booking`
--

CREATE TABLE `room_booking` (
  `room_booking_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL
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
-- Table structure for table `town_city`
--

CREATE TABLE `town_city` (
  `town_city_id` int(11) NOT NULL,
  `town_city_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `town_city_country_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`address_id`);

--
-- Indexes for table `airport`
--
ALTER TABLE `airport`
  ADD PRIMARY KEY (`airport_id`),
  ADD KEY `FK__gps_address__gps_address_id` (`airport_gps_address_id`);

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
  ADD KEY `FK__address__address_id_2` (`address_id`),
  ADD KEY `FK__passenger__passenger_id` (`passenger_id`),
  ADD KEY `FK__email__email_id` (`email_id`);

--
-- Indexes for table `booking_contact_telephone`
--
ALTER TABLE `booking_contact_telephone`
  ADD PRIMARY KEY (`booking_contact_telephone_id`),
  ADD KEY `FK__booking_contact__booking_contact_id` (`booking_contact_id`),
  ADD KEY `FK__telephone__telephone_id` (`telephone_id`);

--
-- Indexes for table `booking_passenger`
--
ALTER TABLE `booking_passenger`
  ADD PRIMARY KEY (`booking_passenger_id`),
  ADD KEY `FK__booking__booking_id` (`booking_id`),
  ADD KEY `FK__passenger__passenger_id_2` (`passenger_id`);

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
  ADD KEY `FK__currency__currency_id` (`country_currency_id`),
  ADD KEY `FK__language__language_id` (`country_language_id`);

--
-- Indexes for table `currency`
--
ALTER TABLE `currency`
  ADD PRIMARY KEY (`currency_id`);

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
-- Indexes for table `gps_address`
--
ALTER TABLE `gps_address`
  ADD PRIMARY KEY (`gps_address_id`),
  ADD KEY `FK__address__address_id` (`address_id`);

--
-- Indexes for table `hotel`
--
ALTER TABLE `hotel`
  ADD PRIMARY KEY (`hotel_id`),
  ADD KEY `FK__gps_address__gps_address_id_2` (`hotel_gps_address_id`),
  ADD KEY `FK__star_rating__star_rating_id` (`hotel_star_rating_id`);

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
  ADD KEY `FK__hotel_facility__hotel_facility_id` (`hotel_facility_id`),
  ADD KEY `FK__image__image_id` (`image_id`);

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
-- Indexes for table `language`
--
ALTER TABLE `language`
  ADD PRIMARY KEY (`language_id`);

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
  ADD KEY `FK__booking__booking_id_2` (`booking_id`),
  ADD KEY `FK__room__room_id` (`room_id`);

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
  ADD KEY `FK__town_city__town_city_id` (`town_city_country_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `airport`
--
ALTER TABLE `airport`
  MODIFY `airport_id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `card_vendor_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `country_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `currency`
--
ALTER TABLE `currency`
  MODIFY `currency_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `email`
--
ALTER TABLE `email`
  MODIFY `email_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `flight`
--
ALTER TABLE `flight`
  MODIFY `flight_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gps_address`
--
ALTER TABLE `gps_address`
  MODIFY `gps_address_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `hotel`
--
ALTER TABLE `hotel`
  MODIFY `hotel_id` int(11) NOT NULL AUTO_INCREMENT;

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
-- AUTO_INCREMENT for table `language`
--
ALTER TABLE `language`
  MODIFY `language_id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `start_rating_id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `title_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `town_city`
--
ALTER TABLE `town_city`
  MODIFY `town_city_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `airport`
--
ALTER TABLE `airport`
  ADD CONSTRAINT `FK__gps_address__gps_address_id` FOREIGN KEY (`airport_gps_address_id`) REFERENCES `gps_address` (`gps_address_id`);

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
  ADD CONSTRAINT `FK__address__address_id_2` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`),
  ADD CONSTRAINT `FK__email__email_id` FOREIGN KEY (`email_id`) REFERENCES `email` (`email_id`),
  ADD CONSTRAINT `FK__passenger__passenger_id` FOREIGN KEY (`passenger_id`) REFERENCES `passenger` (`passenger_id`);

--
-- Constraints for table `booking_contact_telephone`
--
ALTER TABLE `booking_contact_telephone`
  ADD CONSTRAINT `FK__booking_contact__booking_contact_id` FOREIGN KEY (`booking_contact_id`) REFERENCES `booking_contact` (`booking_contact_id`),
  ADD CONSTRAINT `FK__telephone__telephone_id` FOREIGN KEY (`telephone_id`) REFERENCES `telephone` (`telephone_id`);

--
-- Constraints for table `booking_passenger`
--
ALTER TABLE `booking_passenger`
  ADD CONSTRAINT `FK__booking__booking_id` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`),
  ADD CONSTRAINT `FK__passenger__passenger_id_2` FOREIGN KEY (`passenger_id`) REFERENCES `passenger` (`passenger_id`);

--
-- Constraints for table `country`
--
ALTER TABLE `country`
  ADD CONSTRAINT `FK__currency__currency_id` FOREIGN KEY (`country_currency_id`) REFERENCES `currency` (`currency_id`),
  ADD CONSTRAINT `FK__language__language_id` FOREIGN KEY (`country_language_id`) REFERENCES `language` (`language_id`);

--
-- Constraints for table `flight`
--
ALTER TABLE `flight`
  ADD CONSTRAINT `FK__route__route_id` FOREIGN KEY (`route_id`) REFERENCES `route` (`route_id`);

--
-- Constraints for table `gps_address`
--
ALTER TABLE `gps_address`
  ADD CONSTRAINT `FK__address__address_id` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`);

--
-- Constraints for table `hotel`
--
ALTER TABLE `hotel`
  ADD CONSTRAINT `FK__gps_address__gps_address_id_2` FOREIGN KEY (`hotel_gps_address_id`) REFERENCES `gps_address` (`gps_address_id`),
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
  ADD CONSTRAINT `FK__hotel_facility__hotel_facility_id` FOREIGN KEY (`hotel_facility_id`) REFERENCES `hotel_facility` (`hotel_facility_id`),
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
-- Constraints for table `room`
--
ALTER TABLE `room`
  ADD CONSTRAINT `FK__room_type__room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `room_type` (`room_type_id`);

--
-- Constraints for table `room_booking`
--
ALTER TABLE `room_booking`
  ADD CONSTRAINT `FK__booking__booking_id_2` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`),
  ADD CONSTRAINT `FK__room__room_id` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`);

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
  ADD CONSTRAINT `FK__town_city__town_city_id` FOREIGN KEY (`town_city_country_id`) REFERENCES `town_city` (`town_city_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
