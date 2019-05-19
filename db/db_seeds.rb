# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create an initial admin user to get things going.
# to do - turn off admin flag for production.
if User.count < 1
  User.create(
    email: 'tayloredwebsites@me.com',
    password: 'password',
    password_confirmation: 'password',
    given_name: 'Dave',
    family_name: 'Taylor',
    role: 'admin',
    confirmed_at: DateTime.now
  )
end
throw "Invalid User Count" if User.count < 1
@dave = User.where(email: 'tayloredwebsites@me.com').first
