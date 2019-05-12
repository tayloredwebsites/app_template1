# Application Template 1

An application template based upon [kickoff_tailwind](https://github.com/justalever/kickoff_tailwind). This template has the following gems pre-configured:


## Installed Gems

### Global Gems
- [devise](https://github.com/plataformatec/devise). Devise is a flexible authentication solution for Rails based on Warden.
- [Tailwind CSS](https://github.com/IcaliaLabs/tailwindcss-rails). The tailwindcss gem helps you to easily install the Tailwind CSS framework by using WebPack and the webpacker gem. Using PostCSS we can install Tailwind as a base CSS framework via webpacker.
- [webpacker](https://github.com/rails/webpacker/tree/v4.0.2). Webpacker makes it easy to use the JavaScript pre-processor and bundler webpack 4.x.x+ to manage application-like JavaScript in Rails.
- [cancancan](https://github.com/CanCanCommunity/cancancan). CanCanCan is an authorization library for Ruby >= 2.2.0 and Ruby on Rails >= 4.2 which restricts what resources a given user is allowed to access.
- [gretel](https://github.com/lassebunk/gretel). Note: [current maintainer](https://github.com/WilHall/gretel). Gretel is a Ruby on Rails plugin that makes it easy yet flexible to create breadcrumbs. It is based around the idea that breadcrumbs are a concern of the view.
- [sass-rails](https://github.com/rails/sass-rails). This gem provides official integration for Ruby on Rails projects with the Sass stylesheet language.
- [uglifier](https://github.com/lautis/uglifier). Ruby wrapper for UglifyJS JavaScript compressor.

### Development Gems
- [letter_opener](https://github.com/ryanb/letter_opener). Preview email in the default browser instead of sending it. This means you do not need to set up email delivery in your development environment, and you no longer need to worry about accidentally sending a test email to someone else's address.
- [better_errors](https://github.com/BetterErrors/better_errors). Better Errors replaces the standard Rails error page with a much better and more useful error page. It is also usable outside of Rails in any Rack app as Rack middleware.
- [binding_of_caller](https://github.com/banister/binding_of_caller). Using binding_of_caller we can grab bindings from higher up the call stack and evaluate code in that context.
- ['ten_years_rails](https://github.com/clio/ten_years_rails). Learn about your Gemfile and see what needs updating.

### Test Gems
- [capybara](https://github.com/teamcapybara/capybara). Capybara helps you test web applications by simulating how a real user would interact with your app.
- [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails). factory_bot is a fixtures replacement with a straightforward definition syntax, support for multiple build strategies (saved instances, unsaved instances, attribute hashes, and stubbed objects), and support for multiple factories for the same class (user, admin_user, and so on), including factory inheritance.
- [simplecov](https://github.com/colszowka/simplecov/). SimpleCov is a code coverage analysis tool for Ruby. It uses Ruby's built-in Coverage library to gather code coverage data, but makes processing its results much easier by providing a clean API to filter, group, merge, format, and display those results, giving you a complete code coverage suite that can be set up with just a couple lines of code.
- [rails-controller-testing](https://github.com/rails/rails-controller-testing). This gem brings back assigns to your controller tests as well as assert_template to both controller and integration tests.
- [aunchy](https://github.com/copiousfreetime/launchy). Launchy is helper class for launching cross-platform applications in a fire and forget manner. Provides save_and_open_page (in capybara / rspec only?).

### Creating a new app

```bash
$ rails new sample_app -d <postgresql, mysql, sqlite> -m <app_template_dir/template.rb
```

#### Notes.

- Foreman may need to be installed:
    - `npm install -g foreman` to install foreman through npm
    - `gem install foreman` to install foreman as a global gem on your system.
    - Note: Webpack will still compile down with just `rails server` if you don't want to use Foreman.

- Webpack support + Tailwind CSS configured in the `app/javascript` directory.
- Devise with a new `username` and `name` field already migrated in. Enhanced views using Tailwind CSS.

- ??? A custom scaffold view template when generating theme resources (Work in progress) ????
- Git repo initialized at end of template processing.

#### Getting started.

- To start application :
    - On console, run `foreman start` to get `rails server`and `webpack-dev-server` running all in one terminal instance.
    - Open up browser to: `locahost:5000` to see website.

    - You'll have hot reloading on `js` and `css` and `scss/sass` files by default.
