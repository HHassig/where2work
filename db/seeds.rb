require 'faker'
require "csv"
require "open-uri"

Faker::Config.locale = "ca-CAT"

# Destroying:
# Review.destroy_all
# Booking.destroy_all
# VenueOffer.destroy_all
# Venue.destroy_all
# User.destroy_all

venue_photos = []
csv_text = File.read(Rails.root.join('lib','seeds','cafe_photos.csv'))
csv = CSV.parse(csv_text, encoding: 'UTF-8')
csv.each do |row|
  venue_photos << row
end

review_photos = []
csv_text = File.read(Rails.root.join('lib','seeds','review_photos.csv'))
csv = CSV.parse(csv_text, encoding: 'UTF-8')
csv.each do |row|
  review_photos << row
end

user_photos = []
csv_text = File.read(Rails.root.join('lib','seeds','user_photos.csv'))
csv = CSV.parse(csv_text, encoding: 'UTF-8')
csv.each do |row|
  user_photos << row
end

# x = 0
# while x < user_photos.size - 20
#   name = Faker::Name.name
#   user = User.new(
#     is_owner: false,
#     name: name,
#     username: Faker::Internet.username,
#     email: Faker::Internet.email,
#     password: Faker::Internet.password,
#   )
#   file = URI.open(user_photos[x][0])
#   user.photo.attach(io: file, content_type: "image/png", filename: "user#{user.id}.jpg")
#   user.save!
#   puts "User #{x} saved!"
#   x += 1
# end

# x = 0
# while x < 20
#   name = Faker::Name.name
#   user = User.new(
#     is_owner: true,
#     name: name,
#     username: Faker::Internet.username,
#     email: Faker::Internet.email,
#     password: Faker::Blockchain::Bitcoin.address,
#   )
#   file = URI.open(user_photos[x + 279][0])
#   user.photo.attach(io: file, content_type: "image/png", filename: "user#{user.id}.jpg")
#   user.save!
#   puts "User #{x + 279} saved!"
#   x += 1
# end

# x = 0
# while x < venue_photos.size
#   venue = Venue.new(
#     name: venue_photos[x][0],
#     address: venue_photos[x][3],
#     website: venue_photos[x][4],
#     category: venue_photos[x][1],
#     user: User.all.sample,
#     wifi: Faker::Boolean.boolean(true_ratio: 0.75),
#     power_outlets: [true, false].sample,
#     natural_light: [true, false].sample,
#     suited_for_calls: [true, false].sample,
#     opening_time: [6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9, 9.5, 10.0].sample,
#     closing_time: [17.0, 17.5, 18.0, 18.5, 19.0, 19.5, 20.0, 20.5, 21.0, 21.5, 22.0, 22.5, 23.0, 23.5].sample
#   )
#   file = URI.open(venue_photos[x][2])
#   venue.photo.attach(io: file, content_type: "image/png", filename: "venue_#{venue.id}.jpg")
#   venue.save!
#   puts "Venue #{x} saved!"
#   x += 1
# end

# x = 0
# while x < 100
#   venue_offer = VenueOffer.create(
#     venue: Venue.all.sample,
#     coupon: [5.0, 10.0, 15.0, 20.0, 30.0].sample
#   )
#   venue_offer.save!
#   puts "Offer #{x} saved!"
#   x += 7
# end

# x = 0
# while x < 1000
#   booking = Booking.new(
#     user: User.all.sample,
#     venue: Venue.all.sample,
#     date: Date.today - rand(900)
#   )
#   booking.save!
#   puts "Booking #{booking.id} saved!"
#   x += 1
# end

x = 1
while x < 500
  review = Review.new(
    suited_for_calls: [Faker::Boolean.boolean(true_ratio: 0.6)],
    coffe_price: rand(0..5),
    wifi_down: rand(30..300),
    wifi_up: rand(30..150),
    power_outlets: Faker::Boolean.boolean(true_ratio: 0.33),
    natural_light: Faker::Boolean.boolean(true_ratio: 0.85),
    rating: rand(0..5),
    food_price: rand(0..5),
    comment: Faker::Restaurant.review,
    title: Faker::Coffee.origin,
    booking: Booking.find(x+5000)
  )
  file = URI.open(review_photos[x][0])
  review.photo.attach(io: file, content_type: "image/png", filename: "review_#{review.id}.jpg")
  review.save!
  puts "Review #{x} saved"
  x += 1
end

admin = User.new(
  admin: true,
  is_owner: false,
  name: "Pikachu Roll",
  username: "PikaRoll",
  email: "admin@where2work.es",
  password: "gonzalez"
)
file = URI.open("https://i.imgur.com/HIVLLtb.jpg")
admin.photo.attach(io: file, content_type: "image/png", filename: "user#{user.id}.jpg")
admin.save!


user = User.new(
    is_owner: true,
    name: "Julian Gaspar",
    username: "JGaspar15",
    email: "julian@where2work.es",
    password: "123456",
  )
  file = URI.open("https://i.imgur.com/vE0hjMo.png")
  user.photo.attach(io: file, content_type: "image/png", filename: "Julian.jpg")
  user.save!
