require 'faker'

# Creates one user with 10 travels.

# User
email = Faker::Internet.email
password = Faker::Internet.password

# Creates a new user
user = User.create! do |user|
  user.email = email
  user.password = password
end

# User travels
10.times do
  planet = Faker::Space.planet
  price = Faker::Commerce.price
  latitude = Faker::Address.latitude
  longitude = Faker::Address.longitude

  # Creates a new travel
  travel = Travel.create! do |travel|
    travel.user = user
    travel.title = "Space trip to #{planet}"
    travel.description = "Enjoy a trip to #{planet}"
    travel.address = planet
    travel.price = price
    travel.latitude = latitude
    travel.longitude = longitude
  end
end
