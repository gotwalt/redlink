# Encoding: utf-8

module Redlink
  class Ui < Redthing
    attr_accessor :created, :thermostat_locked, :outdoor_temp, :disp_temperature, :heat_setpoint,
      :cool_setpoint, :displayed_units, :status_heat, :status_cool, :hold_until_capable,
      :schedule_capable, :vacation_hold, :dual_setpoint_status, :heat_next_period, :cool_next_period,
      :heat_lower_setpt_limit, :heat_upper_setpt_limit, :cool_lower_setpt_limit, :cool_upper_setpt_limit,
      :sched_heat_sp, :sched_cool_sp, :system_switch_position, :can_set_switch_auto, :can_set_switch_cool,
      :can_set_switch_off, :can_set_switch_heat, :can_set_switch_emergency_heat,
      :can_set_switch_southern_away, :deadband, :outdoor_humidity, :indoor_humidity, :commercial


    def outdoor_temp=(val)
      @outdoor_temp = val.to_f
    end

    def heat_setpoint=(val)
      @heat_setpoint = val.to_f
    end

    def cool_setpoint=(val)
      @cool_setpoint = val.to_f
    end

    def sched_heat_sp=(val)
      @sched_heat_sp = val.to_f
    end

    def sched_cool_sp=(val)
      @sched_cool_sp = val.to_f
    end

    def outdoor_temp=(val)
      @outdoor_temp = val.to_f
    end

    def disp_temperature=(val)
      @disp_temperature = val.to_f
    end

    def heating?
      status_heat.to_i == 1
    end

    def cooling?
      status_cool.to_i == 1
    end

    def overridden?
      heat_setpoint != sched_heat_sp && cool_setpoint != sched_cool_sp
    end

    def status
      if heating?
        if overridden?
          return '(heating via override)'
        else
          return '(heating)'
        end
      elsif cooling?
        if overridden?
          return '(cooling via override)'
        else
          return '(cooling)'
        end
      end
    end

    def pretty
      "#{disp_temperature.to_i}° / #{heat_setpoint}° #{status}"
    end

    def ==(other_ui)
      return false unless other_ui.respond_to(:pretty)
      pretty == other_ui.pretty
    end

  end
end
