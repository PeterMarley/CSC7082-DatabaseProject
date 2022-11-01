-- basic hotel info

SET @HotelName = 'Spanish Hotel 1';

SELECT 
	hotel.hotel_name AS HotelName,
    region.region_name AS RegionName,
    resort.resort_name AS ResortName,
    star_rating.star_rating AS OurRating,
    star_rating.star_rating_plus AS OurRatingPlusFlag,
    CAST(SUM(review_rating.review_rating) / COUNT(review.review_id) AS DEC(2,1)) AS ReviewScore,
    COUNT(DISTINCT review.review_id) AS NumberOfReviews
FROM hotel
INNER JOIN resort ON resort.resort_id = hotel.hotel_resort_id
INNER JOIN region ON region.region_id = resort.resort_id
INNER JOIN star_rating ON star_rating.star_rating_id = hotel.hotel_star_rating_id
INNER JOIN room_type ON room_type.room_type_hotel_id = hotel.hotel_id
INNER JOIN room_booking ON room_booking.room_booking_room_type_id = room_type.room_type_id
INNER JOIN booking ON booking.booking_id = room_booking.room_booking_booking_id
INNER JOIN booking_contact ON booking_contact.booking_contact_id = booking.booking_contact_id
INNER JOIN review ON review.reviewer_id = booking_contact.booking_contact_id
INNER JOIN review_rating ON review_rating.review_rating_id = review.review_rating_id
WHERE hotel.hotel_name = @HotelName
GROUP BY hotel.hotel_id;

-- hotel reviews

SET @HotelName = 'Spanish Hotel 1';

SELECT
    hotel.hotel_name AS HotelName,
    town_city.town_city_name AS ReviewerTown,
    CountryName.location_name AS ReviewerCountry,
    passenger.passenger_first_name AS ReviewerFirstName,
    passenger.passenger_last_name AS ReviewerLastName,
    DATE(review.review_timestamp) AS ReviewDate,
    review_rating.review_rating AS ReviewRating,
    review.review_content AS Review
FROM review
INNER JOIN booking_contact ON booking_contact.booking_contact_id = review.reviewer_id
INNER JOIN passenger ON passenger.passenger_id = booking_contact.booking_contact_passenger_id
INNER JOIN booking ON booking.booking_contact_id = booking_contact.booking_contact_id
INNER JOIN review_rating ON review_rating.review_rating_id = review.review_rating_id
INNER JOIN address ON address.address_id = booking_contact.booking_contact_address_id
INNER JOIN town_city ON town_city.town_city_id = address.town_city_id
INNER JOIN country ON country.country_id = town_city.town_city_country_id
INNER JOIN location_name AS CountryName ON CountryName.location_name_id = country.country_location_name_id
INNER JOIN room_booking ON room_booking.room_booking_booking_id = booking.booking_id
INNER JOIN room_type ON room_type.room_type_id = room_booking.room_booking_room_type_id
INNER JOIN hotel ON hotel.hotel_id = room_type.room_type_hotel_id
WHERE hotel.hotel_name = @HotelName
GROUP BY review.review_id;
