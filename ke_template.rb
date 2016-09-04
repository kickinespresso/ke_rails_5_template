# KickinEspresso App Template
# www.kickinespresso.com
# contact@kickinespresso.com
# ke_template.rb
#rails new hvac -m ke_app_template/ke_template.rb
#rails new test3 -m ke_app_template/ke_template.rb
#http://multithreaded.stitchfix.com/blog/2014/01/06/rails-app-templates/
#TODO:
# Procfile
# Rich Snippets
# Site Map Generation
# Add Robots

#gem 'rails', '5.0.0.1'
def source_paths
  Array(super) +
    [File.join(File.expand_path(File.dirname(__FILE__)),'rails_root')]
end

insert_into_file 'Rakefile', "\nmodule TempFixForRakeLastComment
  def last_comment
    last_description
  end 
end
Rake::Application.send :include, TempFixForRakeLastComment", after: "require File.expand_path('../config/application', __FILE__)\n"



#temp
gem 'newrelic_rpm'
gem 'pg'
gem 'rollbar'
gem 'friendly_id', '~> 5.1.0'
gem 'ckeditor'
gem 'therubyracer', platforms: :ruby
gem 'simple_form'
gem 'devise'
gem 'activeadmin','~> 1.0.0.pre4'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'font-awesome-rails'

gem_group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'web-console'
end 

gem_group :production do
  gem 'rails_12factor'
end

gem_group :development, :test do
  gem 'byebug'
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.5'
  gem 'rubocop', require: false
  gem 'coveralls', require: false
  gem 'reek', require: false
  #gem 'brakeman', require: false
  #https://github.com/railsbp/rails_best_practices
end

gem_group :test do
  gem 'capybara-webkit', '>= 1.8.0'
  gem 'database_cleaner'
  gem 'timecop'
  gem 'webmock'
end
#First Route
route "match '*path' => redirect('/'),via: :get   unless Rails.env.development?"

# config the app to use postgres
gsub_file "Gemfile", /^gem\s+["']sqlite3["'].*$/,''
remove_file 'config/database.yml'
template 'database.erb', 'config/database.yml'

  

#  generate "rspec:install"
generate("rspec:install") #rails generate rspec:install
generate("simple_form:install --bootstrap") #rails generate simple_form:install --bootstrap
generate("active_admin:install User") #active_admin:install User  
#generate("bootstrap:install") #bootstrap generators
generate(:controller, "FrontPage index")
#Ask to generate friendly ID
#Add to User.rb
#  scope :recent, -> num_users { where.not(last_sign_in_at: nil).order("last_sign_in_at ASC" ).limit(num_users) }


#Application Mailer
file 'app/mailers/application_mailer.rb', <<-CODE
class ApplicationMailer < ActionMailer::Base

end
CODE
#Contact Mailer
file 'app/mailers/contact_mailer.rb', <<-CODE
class ContactMailer < ApplicationMailer
  def contact_me(msg)
    @msg = msg
    mail(from: @msg.email,
    to: "",
    subject: "New Visitor\'s Email")
  end
end
CODE


#Contact Views model
file 'app/views/contacts/new.html.erb', <<-CODE
TODO: contact_todo
CODE

#Contact Views model
file 'app/views/contact_mailer/contact_me.html.erb', <<-CODE
TODO: contact_todo
CODE

#Contact Views model
file 'app/views/contact_mailer/contact_me.text.erb', <<-CODE
TODO: contact_todo
CODE

#Contact Views model
file 'app/views/layouts/mailer.html.erb', <<-CODE
TODO: contact_todo
CODE

#Contact Views model
file 'app/views/layouts/mailer.text.erb', <<-CODE
TODO: contact_todo
CODE


inside 'config' do
  #copy_file 'database.yml.example'
end

inside 'config/initializers' do
  copy_file 'setup_mail.rb'
end

copy_file 'LICENSE'

inside 'app/views/layouts' do
  copy_file '_analytics.html.erb'
  copy_file '_footer.html.erb'
  copy_file '_header.html.erb'
  copy_file '_seo.html.erb'
  copy_file '_flash.html.erb'
end

inside 'app/controllers' do
  copy_file 'contacts_controller.rb'
end

inside 'app/models' do
  copy_file 'contact.rb'
  copy_file 'user.rb',  :force => true
end
inside 'app/admin' do
  copy_file 'dashboard.rb',  :force => true
  copy_file 'footer.rb',  :force => true
end

#specs
inside 'spec/factories' do
  copy_file 'users.rb',  :force => true
end
inside 'spec/features' do
  copy_file 'home_page_spec.rb',  :force => true
  copy_file 'user_login_and_logout_spec.rb'
end

copy_file 'Procfile',  :force => true
inside 'config' do
  copy_file 'puma.rb',  :force => true
end

open('app/assets/stylesheets/application.css', 'a') { |f|
  f << "@import \"bootstrap-sprockets\";\n"
  f << "@import \"bootstrap\";\n"
  f << "@import \"font-awesome\";\n"
}

File.rename('app/assets/stylesheets/application.css','app/assets/stylesheets/application.scss')

open('app/assets/javascripts/application.js', 'a') { |f|
  f << "//= require bootstrap-sprockets\n"
}

rake("db:create")
rake("db:create", env: 'test')
rake("db:migrate")
rake("db:migrate", env: 'test')

route "root 'front_page#index'"
route "resources :contacts, only: [:new, :create]"

after_bundle do
  git :init
  git add: "."
  git commit: %Q{ -m 'Initial commit' }
  #remove sqlite 
  insert_into_file 'Gemfile', "\nruby '2.3.1'", after: "source 'https://rubygems.org'\n"
end

open('.gitignore', 'a') { |f|
  f << ".idea\n"
}

File.open(".ruby-version", 'w') {|f| f.write("2.3.1") }
