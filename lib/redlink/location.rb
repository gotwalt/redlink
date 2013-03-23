module Redlink
  class Location < Redthing
    attr_accessor :location_id, :name, :type, :country, :zip_code, :current_weather, :thermostats, :time_zone

    def thermostats=(val)
      @thermostats = val[:thermostat_info].map do |therm|
        Thermostat.new(therm)
      end
    end

    def thermostats
      @thermostats
    end

    def current_weather=(val)
      @current_weather = Weather.new(val)
    end

    def to_s
      name
    end

  end
end
