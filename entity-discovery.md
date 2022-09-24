# Initial Entity Discovery

airport
  airport_id PRIMARY KEY
  airport_city
  airport_code

flight
  flight_id PRIMARY KEY
  flight_check_in_date_time
  flight_departure_airport_id FOREIGN KEY
  flight_arrival_airport_id FOREIGN KEY
  flight_departure_date_time

holiday_type
  holiday_type_id PRIMARY KEY
  holiday_type_name
  holiday_type_description

location
  location_id PRIMARY KEY
  location_country_id FOREIGN KEY
  location_address_id FOREIGN KEY
  location_name
  location_gps_latitude
  location_gps_longitude

country
  country_id PRIMARY KEY
  country_name

address
  address_id PRIMARY_KEY
  address_line_1
  address_line_2
  address_line_3
  address_line_4
  address_line_5
  address_line_6
  address_city_town
  address_country_id FOREIGN KEY

person
  person_id PRIMARY KEY
  person_first_name
  person_middle_name
  person_last_name
  person_date_of_birth
  person_nationality_country_id FOREIGN KEY
  person_passport_id FOREIGN KEY

passport
  passport_id PRIMARY KEY
  passport_number
  passport_expiry_date

accommodation
  accomodation_id PRIMARY KEY
  accomodation_type_id FOREIGN KEY
  accomodation_descriptors - needs expanded probably
  accomodation_location_id FOREIGN KEY

accommodation_ratings
  accommodation_rating_id PRIMARY KEY
  accommodation_id FOREIGN KEY
  accommodation_rating_person_id FOREIGN KEY
  accommodation_five_star_rating_id FOREIGN KEY

five_star_rating
  rating_id
  rating_value

accomodation_type
  accomodation_type_id PRIMARY KEY
  accomodation_name
  accomodation_location_id FORIEGN KEY
