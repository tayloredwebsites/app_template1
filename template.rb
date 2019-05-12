=begin
Template Name: DAT Template 1
Author: David A Taylor
Instructions: $ rails new myapp -m appTemplate1.rb
=end

def source_paths
  [File.expand_path(File.dirname(__FILE__))]
end

def add_gems
  gem 'devise', '~> 4.6.2'
  gem 'cancancan', '~> 3.0.1'
  gem 'gretel', '~> 3.0.9'    # breadcrumbs ( last release for this gem )
  gem 'sass-rails', '~> 5.0.7'
  gem 'uglifier', '>= 4.1.20'  # compressor for JavaScript assets

  gem_group :development do
    gem 'letter_opener', '~> 1.7.0'
    gem 'better_errors', '~> 2.5.1'
    gem 'binding_of_caller', '~> 0.8.0'
    gem 'ten_years_rails', '~> 0.2.0' # for rails 4.1.13 and later
  end
  gem_group :test do
    gem 'capybara', '~> 3.19.1'
    gem 'factory_bot_rails', '~> 5.0.2', require: false
    gem 'simplecov', '~> 0.16.1', require: false
    gem 'rails-controller-testing', '~> 1.0.4' # add assigns and assert template to controller testing
    gem 'launchy', '~> 2.4.3' # for launching save_and_open_page to default browser (rspec only?)
    end
end

def add_users
  # Install Devise
  generate "devise:install"

  # Configure Devise
  environment "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }",
              env: 'development'
  route "root to: 'home#index'"

  # Create Devise User
  generate :devise, "User", "username", "name", "roles"
end

def copy_templates
  directory "app", force: true
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

# Main setup
source_paths

add_gems

after_bundle do
  stop_spring
  add_users
  remove_app_css
  add_foreman
  copy_templates
  add_tailwind

  # Migrate
  rails_command "db:create"
  rails_command "db:migrate"

  git :init
  git add: "."
  git commit: %Q{ -m "Initial commit" }

  say
  say "Kickoff app successfully created! 👍", :green
  say
  say "Switch to your app by running:"
  say "$ cd #{app_name}", :yellow
  say
  say "Then run:"
  say "$ rails server", :green
end
