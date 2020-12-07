# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# @mixtape = Mixtape.new(name: 'My First Mixtape', theme_type: 'Retro')
# @mixtape.save!

require 'uri'

# CREATING USERS
puts "Creating new users..."
ondine = User.create(email: "ondine@email.com", password: "123456")
rob = User.create(email: "rob@email.com", password: "123456")
jurek = User.create(email: "jurek@email.com", password: "123456")
susan = User.create(email: "susan@email.com", password: "123456")
puts "Created #{User.count} users..."

# CREATING LISTS FOR ROB
puts "Creating lists..."
list = CuratedList.create( name: "Our favourite things" )
list.curated_list_items = [
  CuratedListItem.create(
    prompt: 'I know you love plants !',
    url: 'www.google.com',
    curated_list_id: list ),
  CuratedListItem.create(
    prompt: 'I know you love plants even more!',
    url: 'www.google.com',
    curated_list_id: list ),
  CuratedListItem.create(
    prompt: 'Blah blah blah',
    url: 'www.google.com',
    curated_list_id: list )
  ]
list.save!
list2 = CuratedList.create( name: "Things that remind me of us" )
list2.curated_list_items = [
  CuratedListItem.create(
    prompt: "You'll love this recipe !",
    url: 'www.google.com',
    curated_list_id: list2),
  CuratedListItem.create(
    prompt: 'Bake this bad boy!',
    url: 'www.google.com',
    curated_list_id: list2)
  ]
list2.save!
list3 = CuratedList.create( name: "Our favourite things" )
list3.curated_list_items = [
  CuratedListItem.create(
    prompt: 'I know you love plants !',
    url: 'www.google.com',
    curated_list_id: list ),
  CuratedListItem.create(
    prompt: 'I know you love plants even more!',
    url: 'www.google.com',
    curated_list_id: list ),
  CuratedListItem.create(
    prompt: 'Blah blah blah',
    url: 'www.google.com',
    curated_list_id: list )
  ]
list3.save!
list4 = CuratedList.create( name: "Things that remind me of us" )
list4.curated_list_items = [
  CuratedListItem.create(
    prompt: "You'll love this recipe !",
    url: 'www.google.com',
    curated_list_id: list2),
  CuratedListItem.create(
    prompt: 'Bake this bad boy!',
    url: 'www.google.com',
    curated_list_id: list2)
  ]
list4.save!
Giftape.create(giftable: list, user: rob)
Giftape.create(giftable: list2, user: rob)
Giftape.create(giftable: list3, user: ondine)
Giftape.create(giftable: list4, user: ondine)

puts "Created #{CuratedList.count} lists..."

# CREATING MIXTAPE FOR ROB
puts "Creating mixtape..."
tape = Mixtape.new(
  name: "Our Mixtape",
  theme_type: "lonely",
  tracks: [ Track.create(youtube_url: "www.google.com"),
    Track.create(youtube_url: "www.yt.com") ]
)
tape.save!
tape2 = Mixtape.new(
  name: "Our Mixtape #2",
  theme_type: "vibes",
  tracks: [ Track.create(youtube_url: "www.google.com"),
      Track.create(youtube_url: "www.yt.com") ]
)
tape2.save!
tape3 = Mixtape.new(
  name: "Our Mixtape",
  theme_type: "lonely",
  tracks: [ Track.create(youtube_url: "www.google.com"),
    Track.create(youtube_url: "www.yt.com") ]
)
tape3.save!
tape4 = Mixtape.new(
  name: "Our Mixtape #2",
  theme_type: "vibes",
  tracks: [ Track.create(youtube_url: "www.google.com"),
      Track.create(youtube_url: "www.yt.com") ]
)
tape4.save!
Giftape.create(giftable: tape, user: rob)
Giftape.create(giftable: tape2, user: rob)
Giftape.create(giftable: tape3, user: ondine)
Giftape.create(giftable: tape4, user: ondine)

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
  questions: [
    Question.new(
      content: "Why are we friends again...?",
      answers: [
        Answer.new(
          is_correct: true,
          content: "Yes",
          letter: 0
        ),
        Answer.new(
          is_correct: false,
          content: "No",
          letter: 1
        ),
      ]
    ),
    Question.new(
      content: "Hello...?",
      answers: [
        Answer.new(
          is_correct: true,
          content: "Hi",
          letter: 0
        ),
        Answer.new(
          is_correct: false,
          content: "Obrigado",
          letter: 1
        ),
      ]
    )
  ]
)
quiz2.save!
Giftape.create(giftable: quiz, user: ondine)
Giftape.create(giftable: quiz2, user: ondine)

puts "Created #{Quiz.count} quizzes..."

# CREATING COLLAGE FOR ROB
# puts "Creating collages.."
# collage = Collage.create( name: "Back to better times" )
# file1 = open()
# collage.collage_items = [
#   CollageItem.create(
#     prompt: "Silly goose",
#     photo: 'https://res.cloudinary.com/susanjsp/image/upload/v1607085804/flat_750x_075_f-pad_750x1000_f8f8f8.u1_gjowac.jpg'),
#   CollageItem.create(
#     prompt: "Silly, silly goosey",
#     photo: 'https://res.cloudinary.com/susanjsp/image/upload/v1607085804/flat_750x_075_f-pad_750x1000_f8f8f8.u1_gjowac.jpg')
#   ]
# collage.save!
# collage2 = Collage.create( name: "Yes" )
# collage2.collage_items = [
#   CollageItem.new(
#     prompt: "Just hangin with a legend",
#     photo: 'https://res.cloudinary.com/susanjsp/image/upload/v1607085825/36009738-8978325-image-a-109_1606148281244_mgtm3d.jpg'),
#   CollageItem.new(
#     prompt: "When will we learn lmao",
#     photo: 'https://res.cloudinary.com/susanjsp/image/upload/v1607085825/36009738-8978325-image-a-109_1606148281244_mgtm3d.jpg'),
#   ]
# collage2.save!

# Giftape.create(giftable: collage, user: User.second)
# Giftape.create(giftable: collage2, user: User.second)

# puts "Created #{Collage.count} collages..."
