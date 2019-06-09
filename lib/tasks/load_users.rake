namespace :load_users do
  task run: :environment do
    user = User.new()
    user.email = "tayloredwebsites@me.com"
    user.given_name = "Dave"
    user.family_name = "Taylor"
    user.password = 'password'
    user.password_confirmation = 'password'
    user.roles = "admin"
    if user.save()
      puts "created Dave user"
    else
      # note split variable indicator for application template parsing
      puts "ERROR creating Dave user #"+"{user.errors.messages}"
    end
  end
end
