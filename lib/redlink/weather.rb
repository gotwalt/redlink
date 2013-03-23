# Encoding: utf-8

module Redlink
  class Weather < Redthing
    attr_accessor :is_defined, :is_valid, :condition, :temperature, :temp_unit, :humidity, :phrase_key

    def to_s
      if is_defined && is_valid
        "#{temperature.to_i}° #{condition}"
      else
        ""
      end
    end

    def temperature=(val)
      @temperature = val.to_f
    end

    def humidity=(val)
      @humidity = val.to_f
    end

  end
end
