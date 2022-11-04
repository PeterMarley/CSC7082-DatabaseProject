-- hotel info
SELECT @HotelId := hotel.hotel_id FROM hotel WHERE hotel.hotel_name = 'Spanish Hotel 1';


-- hotel basic details
SELECT room_type.room_type_hotel_id, room_type.room_type_name, room_type.room_type_base_quantity FROM room_type WHERE room_type.room_type_hotel_id = @HotelId; -- confirm number of rooms
SELECT 
	hotel.hotel_name,
    resort.resort_name,
    region.region_name,
    hotel.hotel_description, 
    star_rating.star_rating AS Jet2StarRating, 
    star_rating.star_rating_plus AS Jet2StarRatingPlus,
    hotel.stated_star_rating AS StatedStarRating,
    hotel.child_age_max AS ChildAgeUpTo,
    hotel.hotel_block_count AS Blocks, 
    hotel.hotel_floor_count AS Floors,
    hotel.hotel_lift_count AS Lifts,
    SUM(room_type.room_type_base_quantity) AS Rooms,
    hotel.hotel_additional_info,
    gps.gps_latitude, 
    gps.gps_longitude FROM hotel 
INNER JOIN star_rating ON star_rating.star_rating_id = hotel.hotel_star_rating_id 
INNER JOIN gps ON gps.gps_id = hotel.hotel_gps_id
INNER JOIN resort ON hotel.hotel_resort_id = resort.resort_id
INNER JOIN region ON region.region_id = resort.resort_id
INNER JOIN destination ON destination.destination_id = region.region_destination_id
RIGHT JOIN room_type ON room_type.room_type_hotel_id = hotel.hotel_id
WHERE hotel.hotel_id = @HotelId
GROUP BY hotel.hotel_id;

-- hotel images
SELECT hotel.hotel_name, hotel_image.hotel_image_url, hotel_image.hotel_image_alt_text FROM hotel_image
INNER JOIN hotel ON hotel.hotel_id = hotel_image.hotel_image_hotel_id
WHERE hotel.hotel_id = @HotelId LIMIT 10;

SELECT hotel.hotel_name, room_type_image.room_type_image_url, room_type_image.room_type_image_alt_text FROM room_type_image
INNER JOIN room_type ON room_type_image.room_type_image_room_type_id = room_type.room_type_id
INNER JOIN hotel ON hotel.hotel_id = room_type.room_type_hotel_id 
WHERE hotel.hotel_id = @HotelId LIMIT 10;

-- hotel bullet points
SELECT hotel_bullet.hotel_bullet FROM hotel_bullet WHERE hotel_bullet.hotel_bullet_hotel_id = @HotelId;


-- select number of hotel reviews and average review score
CREATE TEMPORARY TABLE HotelReviews (hotel_name varchar(255), review_score int(11));

INSERT INTO HotelReviews
SELECT hotel.hotel_name, review_rating.review_rating FROM review_rating
INNER JOIN review ON review.review_rating_id = review_rating.review_rating_id
INNER JOIN booking_contact ON booking_contact.booking_contact_id = review.reviewer_id
INNER JOIN booking ON booking.booking_contact_id = booking_contact.booking_contact_id
INNER JOIN room_booking ON room_booking.room_booking_booking_id = booking.booking_id
INNER JOIN room_type ON room_type.room_type_id = room_booking.room_booking_room_type_id
INNER JOIN hotel ON hotel.hotel_id = room_type.room_type_hotel_id
WHERE hotel.hotel_id = @HotelId
group by review.review_id;

SELECT * FROM HotelReviews;

SELECT HotelReviews.hotel_name, COUNT(HotelReviews.review_score) AS NumberOfReviews, SUM(HotelReviews.review_score) / COUNT(HotelReviews.review_score) AS AverageReviewScore 
FROM HotelReviews;