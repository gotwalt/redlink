module Redlink
  class Thermostat < Redthing
    attr_accessor :thermostat_id, :mac_id, :domain_id, :instance, :device_name,
      :user_defined_device_name, :upgrading, :thermostats_alerts, :ui, :fan,
      :humidification, :can_control_schedule, :will_support_schedule

    def ui=(val)
      @ui = Ui.new(val)
    end

    def name
      user_defined_device_name || device_name
    end

    def pretty
      "#{name} - #{ui.pretty}"
    end

    def refresh
      @ui = Ui.new Endpoint.get_volatile_thermostat_data(self.thermostat_id)
    end

    def ==(other_thermostat)
      return false unless other_thermostat.respond_to?(:mac_id)
      mac_id == other_thermostat.mac_id
    end
  end
end
