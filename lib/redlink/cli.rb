require 'thor'
require 'redlink'
require 'redlink/endpoint'

module Redlink
  class Cli < Thor
    desc 'init TOKEN', 'Stores the app token for your Redlink application'
    def init(token)
      Redlink::Configuration.app_token = token
    end

    desc 'login USERNAME PASSWORD', 'sign in'
    def login(username, password)
      Redlink::Endpoint.login(username, password)
    end

    desc 'logout', 'Log the active user out'
    def logout
      Redlink::Endpoint.logout
    end

    desc 'locations', 'places'
    def locations
      Redlink::Location.all.each do |location|
        s = [location]
        if location.current_weather
          s << location.current_weather
        end

        puts s.join(' - ')

        location.thermostats.each do |thermostat|
          puts "\t#{thermostat.pretty}"
        end

      end
    end

  end
end
