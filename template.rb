=begin
Template Name: DAT Template 1
Author: David A Taylor
Instructions: $ rails new myapp -m appTemplate1.rb
=end

def source_paths
  [File.expand_path(File.dirname(__FILE__))]
end

def rails_version
  @rails_version ||= Gem::Version.new(Rails::VERSION::STRING)
end

def rails_5?
  Gem::Requirement.new(">= 5.2.0", "< 6.0.0.beta1").satisfied_by? rails_version
end

def rails_6?
  Gem::Requirement.new(">= 6.0.0.beta1", "< 7").satisfied_by? rails_version
end

def add_gems
  gem 'bootstrap', '~> 4.3', '>= 4.3.1'
  gem 'devise', '~> 4.6.2'
  gem 'devise-bootstrapped', github: 'excid3/devise-bootstrapped', branch: 'bootstrap4'
  gem 'devise_masquerade', '~> 0.6.2'
  gem 'font-awesome-sass', '~> 5.6', '>= 5.6.1'
  gem 'cancancan', '~> 3.0.1'
  gem 'gretel', '~> 3.0.9'    # breadcrumbs ( last release for this gem )
  gem 'uglifier', '>= 4.1.20'  # compressor for JavaScript assets

  gem_group :development do
    gem 'letter_opener', '~> 1.7.0'
    gem 'better_errors', '~> 2.5.1'
    gem 'binding_of_caller', '~> 0.8.0'
    gem 'ten_years_rails', '~> 0.2.0' # for rails 4.1.13 and later
  end
  gem_group :test do
    gem 'factory_bot_rails', '~> 5.0.2', require: false
    gem 'simplecov', '~> 0.16.1', require: false
    gem 'rails-controller-testing', '~> 1.0.4' # add assigns and assert template to controller testing
    gem 'launchy', '~> 2.4.3' # for launching save_and_open_page to default browser (rspec only?)
  end
  if rails_5?
    gsub_file "Gemfile", /gem 'sqlite3'/, "gem 'sqlite3', '~> 1.3.0'"
    gem 'webpacker', '~> 4.0.1'
  end
end

def add_devise
  # Install Devise
  generate "devise:install"
end

def configure_devise
  # Configure Devise
  environment "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }",
              env: 'development'
  route "resources :users"
  route "root to: 'home#index'"
end

def devise_user_table
  # Create Devise User
  generate :devise, "User", "given_name", "family_name", "role", "deleted"
end


def copy_templates
  copy_file "Procfile"
  copy_file "Procfile.dev"
  copy_file ".foreman"

  directory "app", force: true
  # directory "config", force: true
  # directory "lib", force: true

  # route "get '/terms', to: 'home#terms'"
  # route "get '/privacy', to: 'home#privacy'"
end

def add_tailwind
  # beta version for now
  run "yarn add tailwindcss@next"
  run "mkdir app/javascript/stylesheets"
  append_to_file("app/javascript/packs/application.js", 'import "stylesheets/application"')
  inject_into_file("./postcss.config.js",
  "var tailwindcss = require('tailwindcss');\n",  before: "module.exports")
  inject_into_file("./postcss.config.js", "\n    tailwindcss('./app/javascript/stylesheets/tailwind.config.js'),", after: "plugins: [")
  run "mkdir app/javascript/stylesheets/components"
end

def add_webpack_if_rails_5
  # Rails 6+ comes with webpacker by default, so we can skip this step
  return if rails_6?

  # Our application layout already includes the javascript_pack_tag,
  # so we don't need to inject it
  rails_command 'webpacker:install'
end

def add_javascript
  run "yarn add expose-loader jquery popper.js bootstrap data-confirm-modal local-time"

  if rails_5?
    run "yarn add turbolinks @rails/actioncable@pre @rails/actiontext@pre @rails/activestorage@pre @rails/ujs@pre"
  end

  content = <<-JS
    const webpack = require('webpack')
    environment.plugins.append('Provide', new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
      Rails: '@rails/ujs'
    }))
  JS

  insert_into_file 'config/webpack/environment.js', content + "\n", before: "module.exports = environment"
end

# Remove Application CSS
def remove_app_css
  remove_file "app/assets/stylesheets/application.css"
end


def add_foreman
  copy_file "Procfile"
end

def stop_spring
  run "spring stop"
end

# problems running Rake
# rake aborted! - NameError: uninitialized constant User
def create_user
  rakefile("load_users.rake") do
    <<-TASK
      namespace :load_users do
        task run: :environment do
          user = User.new()
          user.email = "tayloredwebsites@me.com"
          user.given_name = "Dave"
          user.family_name = "Taylor"
          user.password = 'password'
          user.password_confirmation = 'password'
          user.role = "admin"
          if user.save()
            puts "created Dave user"
          else
            # note split variable indicator for application template parsing
            puts "ERROR creating Dave user #"+"{user.errors.messages}"
          end
        end
      end
    TASK
  end
  run "rake load_users:run"
end

def create_locale_en
  file 'config/locales/app.en.yml', <<-CODE
    en:
      app:
        errors:
          error: "ERROR: "
          errors: "ERRORS: "
        messages:
          welcome: "Welcome "
      nav_bar:
        home: "Home"
        users: 'Users'
      users:
        labels:
          email: "E-mail"
          password: "Password"
          password_confirmation: "Confirm Password"
          given_name: "Given (first) Name"
          family_name: "Family (last) Name"
          role: "Role"
          deleted: "Deleted"
        errors:
          set_invalid_role: "You are not allowed to set this type of user role."
          email_is_req: "Email is a required field."
    CODE
end

# Main setup
source_paths

add_gems

after_bundle do
  stop_spring
  add_devise
  configure_devise
  devise_user_table
  add_webpack_if_rails_5
  add_javascript
  remove_app_css
  add_foreman
  copy_templates
  add_tailwind

  # Migrate
  rails_command "db:create"
  rails_command "db:migrate"

  create_user
  create_locale_en

  git :init
  git add: "."
  git commit: %Q{ -m "Initial commit" }

  say
  say "Application successfully created from template! 👍", :green
  say
  say "Switch to your app by running:"
  say "$ cd #{app_name}", :yellow
  say
  say "Then run:"
  say "> foreman", :green
end
