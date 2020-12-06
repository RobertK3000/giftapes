# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# @mixtape = Mixtape.new(name: 'My First Mixtape', theme_type: 'Retro')
# @mixtape.save!

# CREATING USERS
puts "Creating new users..."
users = %w(susan robert ondine jurek)

users.each do |user|
  user = User.new(
    email: "#{user}@email.com",
    password: "123456"
  )
  user.save!
end
puts "Created #{User.count} users..."

# CREATING LISTS FOR ROB
puts "Creating lists..."

list = CuratedList.new(
  name: "Our favourite things",
  curated_list_items: [ CuratedListItem.create(
      prompt: 'I know you love plants !',
      url: 'www.google.com',
      curated_list_id: list ),
    CuratedListItem.create(
      prompt: 'I know you love plants even more!',
      url: 'www.google.com',
      curated_list_id: list ) ]
  )
list.save!
list2 = CuratedList.new(
  name: "Things that remind me of us",
  curated_list_items: [ CuratedListItem.create(
    prompt: "You'll love this recipe !",
    url: 'www.google.com',
    curated_list_id: list2),
  CuratedListItem.create(
    prompt: 'Bake this bad boy!',
    url: 'www.google.com',
    curated_list_id: list2) ]
)
list2.save!
Giftape.create(giftable: list, user: User.second)
Giftape.create(giftable: list2, user: User.second)

puts "Created #{CuratedList.count} lists..."

# CREATING MIXTAPE FOR ROB
puts "Creating mixtape..."
tape = Mixtape.new(
  name: "Our Mixtape",
  theme_type: "lonely",
  tracks: [ Track.new(youtube_url: "www.google.com"),
    Track.new(youtube_url: "www.yt.com") ]
)
tape.save!
tape2 = Mixtape.new(
  name: "Our Mixtape #2",
  theme_type: "vibes",
  tracks: [ Track.new(youtube_url: "www.google.com"),
      Track.new(youtube_url: "www.yt.com") ]
)
tape2.save!
Giftape.create(giftable: tape, user: User.second)
Giftape.create(giftable: tape2, user: User.second)

puts "Created #{Mixtape.count} mixtapes..."

# CREATING QUIZ FOR ROB
puts "Creating quizzes..."
quiz = Quiz.new(
  name: ":/",
  questions: [ Question.new(
    content: "Why are we friends...?"
  ) ]
)
quiz.save!
quiz2 = Quiz.new(
  name: "I really don't know",
  questions: [ Question.new(
    content: "Why are we friends again...?"
  ) ]
)
quiz2.save!
Giftape.create(giftable: quiz, user: User.second)
Giftape.create(giftable: quiz2, user: User.second)

puts "Created #{Quiz.count} quizzes..."

# CREATING COLLAGE FOR ROB
# puts "Creating collages.."
# collage = Collage.new(
#   name: "Back to better times",
#   collage_items: [ CollageItem.new(
#     prompt: "Silly goose",
#     photo: 'https://res.cloudinary.com/susanjsp/image/upload/v1607085804/flat_750x_075_f-pad_750x1000_f8f8f8.u1_gjowac.jpg'
#   ) ]
# )
# collage.save!
# collage2 = Collage.new(
#   name: "Yes",
#   collage_items: [ CollageItem.new(
#     prompt: "Just hangin with a legend",
#     photo: 'https://res.cloudinary.com/susanjsp/image/upload/v1607085825/36009738-8978325-image-a-109_1606148281244_mgtm3d.jpg'
#   ) ]
# )
# collage2.save!

# Giftape.create(giftable: collage, user: User.second)
# Giftape.create(giftable: collage2, user: User.second)

puts "Created #{Collage.count} collages..."