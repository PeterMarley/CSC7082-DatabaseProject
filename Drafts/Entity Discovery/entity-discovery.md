# Holiday

holiday (tie it all together)

		price_pp 
		total_price 
		duration 
		departure_date 
		room_type 
		holiday_type (possible null) - types table? 

# Travel entities

airport

		name (not city eg London Stansted)
		code
		latitutde
		longitude
		address

flight/ route

		check in datetime
		departure datetime
		departure airport
		arrival airport
		estimated time
			hand luggage > these two out of scope from what neil said
			hold luggage
		Gps co-ords for above 

DepartureDate / Date?

		day 
		month 
		year 
		availability 
		num_nights (1-55)
		return date?	

booking

		booking_contact
		Departure dates 
		Return dates 
		Hotel/resort location 
		Travel insurance 
		Baggage allowance 
		Car rental/coaches/taxis 
		Number of adults/children 
		Board type 
		Room type 
		made_datetime 
		dep_date 
		dep_time 

Booking_Details 

		booking_contact 
		name 
		house_no 
		address_line1 
		address_line2 
		town 
		postcode 
		telphone1_type                
		telephone1 
		emergency_number 
		email 
		confirmation_email 
		balance 

Plane

		Seat numbers 
		Seat type 
		Flight meal
		additional services	
		features
	
Transfer_Options 

		?

# Location entities

destination

		name
		country/ region
		town/ area
		resorts
		hotel

country

		name

	OR

area

		name
	
location

		address
		name
		latitude
		longitude
		language
		currency
		time_zone
		costs?

# Accomodation entities

benefits

		name (eg 1x free child place from results page)

accomodation

		type
		description
		location


guests/ party

		party_id
		room no/ booking id?
		adult no
		child no
		infant no
	
Room

		party_id
		adults min
		adults max
		children min
		children max
		infant min
		infant max
		name
		price
		type

room_type

		name
		min occup
		max occup
		room facilities
		room notes
		desc

resort

		name
		location
		address
		long/
		lat
		about info/ desc?
		region
		country
		stars
		stay_duration
		description

guest_age_bracket (perhaps better stored against room?)

		name/ type
		min
		max

hotel

		name
		location
		star rating
		review rating
		photos
		collection
		room_type
		board_info
		facility link of some sort
		lat/ long
		address
		descripton
		amenities
		
hotel_collection

		?
	
hotel descriptors (results page hotels tab)

		descriptor

facility (room / hotel)

		facility_name 
		facility_desc 
		facility_notes (italics)  
		(wifi both in hotel & room) 
	
hotel facility

		name
		type
		description
		photos
		notes
	
activities

		name
		photos
		location (long/ lat) country??
		description

activity type?

		sports/ relaxation etc

room facility

		name
	
pools

		water type (fresh etc)
		indoor/ outdoor
		sunbeds
		balinese beds
		parasols

holiday_type

		name
		description

board

		name
		board type
		hotel
		description
		type

board type

		name
		description

Benefits and Offers 


# Personnel entities

Customer/User

		First Name 
		Middle Name 
		Last Name 
		Title 
		Dob
		Second passenger info 
		Passport Number 
		Address 
		Phone Number 
		Emergency Contact 

person

		title
		first name
		middle name
		last name
		dob

passenger

		title / pronoun?
		first_name 
		surname 
		dob 
		type?

lead_passenger

		??
	
booking contact

		passenger 
		address_country 
			Add line 1 
			Add line 2 
			Town / city 
			House name 
			Postcode 
			Country 
		tel_type 
		tel_numb 
		emergency_numb 
		email  

passport

		passport number
		expiry date

# Ratings
	
jet2 resort star rating

		name (1,2,4, 4+, 5 etc)

trust pilot start rating (maybe just retrieved from an api)

		name (1,2,4, 4+, 5 etc)

trip advisor rating?

reviews

		reviewer name
		reviewer title
		star_rating
		review date
		title
		review content
		rating link?
		photos
	
# payments

accomodation per night

		hotel
		age bracket? max dob?
		date
	
payment

		amount
		options (paypal?)

card

		card_num 
		name 
		exp_month 
		exp_year 
		cvv 

payment_option

		type

paypal

		login
		password

payment type

		name
		desc?

date price multiplier (on off peak pricing impl)

		???

discount

		code
		booking
	
price

		(Depends on date ??) 
	
charge record/ all sales?

		amount
		holiday_id?
	

# Shortlisting

recent_searches

		uniqueID 
		Identifier  

# Concurrency constraints

# holiday

holiday

		arrival flight
		departure flight
		accommodation booking
		days (derived attribute?)

## Accessibility data?









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
