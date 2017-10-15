source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '~> 2.4.0'
gem 'rails', '~> 5.1.4'

gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.2'
gem 'kaminari', '~> 1.0', '>= 1.0.1'
gem 'nokogiri', '~> 1.8', '>= 1.8.1'
gem 'simple_form', '~> 3.5'
gem 'slim-rails', '~> 3.1', '>= 3.1.2'
gem 'toastr-rails', '~> 1.0', '>= 1.0.3'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.6', '>= 3.6.1'
  gem 'factory_girl_rails', '~> 4.8'
  gem 'capybara', '~> 2.15', '>= 2.15.4'
  gem 'selenium-webdriver', '~> 3.6'
  gem 'launchy', '~> 2.4', '>= 2.4.3'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry-rails', '~> 0.3.6'
  gem 'rubocop', '~> 0.50.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
