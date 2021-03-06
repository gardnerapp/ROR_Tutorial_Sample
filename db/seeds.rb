# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

#Create a main Sample User 
User.create!(name: "Example User",
            email: "example1@examplel.org",
            password: "foobar",
            password_confirmation: "foobar",
            admin: true 
            )
            
#Generate a bunch of additional users 
99.times do |n|
    name = Faker::Name.name 
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password 
    )
end 