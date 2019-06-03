require_relative "models/Databaseandler.rb"
require_relative "models/post.rb"

require 'bundler'
Bundler.require

require './app'

I18n.load_path << Dir[File.expand_path("config") + "/*.yml"]
I18n.default_locale = :se # (note that `en` is already the default!)

run Franks
