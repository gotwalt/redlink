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

    def to_s
      "#{name} - #{ui}"
    end
  end
end
