load_users.rake
namespace :load_users do

  desc "load initial user"
  task :run do
    user = User.new()
    user.email = "tayloredwebsites@me.com"
    user.given_name = "Dave"
    user.family_name = "Taylor"
    user.role = "admin"
    if user.save()
      puts "created Dave user"
    else
      puts "ERROR creating Dave user"
  end

end # translation_table
