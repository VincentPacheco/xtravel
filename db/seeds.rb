require 'faker'
require 'open-uri'

# Destroy

puts'Cleaning database'
Booking.destroy_all
Travel.destroy_all
User.destroy_all

# Photos
photo_urls = [

  'https://res.cloudinary.com/vincentpacheco/image/upload/v1598001683/01-newplanet-manser1hr_ukbppe.jpg',
  'https://res.cloudinary.com/vincentpacheco/image/upload/v1598001683/1aa5e55057_50157976_plane-te-b-hd_xrjyxq.jpg',
  'https://res.cloudinary.com/vincentpacheco/image/upload/v1598001683/25450-191010135850013-0_rgja1y.jpg',
  'https://res.cloudinary.com/vincentpacheco/image/upload/v1598001683/8129590b3c_108529_planete-10_rhtddz.jpg',
  'https://res.cloudinary.com/vincentpacheco/image/upload/v1598001683/cover-r4x3w1000-5b6972563b280-terre-e-tuve_cvxwcq.jpg',
  'https://res.cloudinary.com/vincentpacheco/image/upload/v1598001684/image_iiea4e.jpg',
  'https://res.cloudinary.com/vincentpacheco/image/upload/v1598001684/ob_0b370e_terre-2_l7cz9z.jpg',
  'https://res.cloudinary.com/vincentpacheco/image/upload/v1598001684/WP_Perijove_26_-_Composite_-_2_uudtl2.jpg',
  'https://res.cloudinary.com/vincentpacheco/image/upload/v1598002999/18352380-0-image-a-13_1568213885311_lhxv2z.jpg',
  'https://res.cloudinary.com/vincentpacheco/image/upload/v1598002999/2_feature_1600x900_mercury-ef8b94-0_1x_sm1u7q.jpg',
  'https://res.cloudinary.com/vincentpacheco/image/upload/v1598002999/LIFT-Mars_the_Red_Planet-1600x900_vwywto.jpg',
  'https://res.cloudinary.com/vincentpacheco/image/upload/v1598002999/PlanetaSH_3_ea2wzf.jpg',
  'https://res.cloudinary.com/vincentpacheco/image/upload/v1598002999/Supermassive_blackhole_planet_fefztx.jpg'
]

puts'Generating photos'

photos = photo_urls.map do |url|
  # puts url
  open(url)
end
puts photos

puts'Generating admin'

# Admin
admin = User.create do |user|
  user.admin = true
  user.email = 'admin@xtravel.com'
  user.password = 'xtravel-admin'
end

puts'Generating organizers'

# Organizers
organizers = Array.new(3) do
  email = Faker::Internet.email
  password = Faker::Internet.password

  User.create do |user|
    user.email = email
    user.password = password
  end
end.select(&:valid?)

puts'Generating travelers'

# Travelers
travelers = Array.new(3) do
  email = Faker::Internet.email
  password = Faker::Internet.password

  User.create do |user|
    user.email = email
    user.password = password
  end
end.select(&:valid?)

puts'Generating array of travels'

# Travels
travels = Array.new(10) do
  organizer = organizers.sample
  photo = photos.sample

  planet = Faker::Space.galaxy
  price = Faker::Number.within(range: 25000..200000)
  latitude = Faker::Address.latitude
  longitude = Faker::Address.longitude

puts'Generating travels'

  # Creates a new travel
  Travel.create! do |travel|
    travel.user = organizer
    travel.title = planet
    travel.address = planet
    travel.price = price
    travel.description = Faker::Games::Overwatch.quote
    travel.longdescription = Faker::Games::WorldOfWarcraft.quote
    travel.duration = Faker::Number.within(range: 45..170)
    travel.capacity = Faker::Number.within(range: 40..250)
    travel.latitude = latitude
    travel.longitude = longitude
    # Please uncomment
    puts 'attach photo to travel'
    # puts photo
    puts '----'
    url = photo_urls.sample
    puts url
    pic = open(url)
    travel.photo.attach(
      io: pic,
      filename: 'photo.png',
      content_type: 'image/png'
    )
  end
end.select(&:valid?)

puts'Generating array of bookings'

# Bookings
bookings_grouped_by_travel = Array.new(3) do
  travel = travels.sample

  future = Faker::Date.forward(days: 23)
  past = Faker::Date.backward(days: 14)

  future_or_past = [future, past].sample

  bookings = Array.new(3) do
    traveler = travelers.sample

    # Creates a new booking
    Booking.create do |booking|
      booking.user = traveler
      booking.travel = travel
      booking.date = future_or_past
    end
  end.select(&:valid?)
end
