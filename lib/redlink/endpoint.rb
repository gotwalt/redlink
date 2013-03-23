require 'savon'

module Redlink
  class Endpoint

    def self.endpoint_client
      @endpoint_client ||= Savon.client do
        wsdl File.expand_path("../../../wsdl/MobileV2.xml", __FILE__)
        log_level :warn
        log false
      end
    end

    def self.login(username = Configuration.username, password = Configuration.password)
      raise "A username and password is required" unless username && password

      params = {
        username: username,
        password: password,
        applicationID: Redlink::Configuration.app_token,
        applicationVersion: 2,
        uiLanguage: 'Default'
      }

      body = endpoint_client.call(:authenticate_user_login, message: params).body
      p body[:authenticate_user_login_response]
      if body[:authenticate_user_login_response][:authenticate_user_login_result][:result] == 'Success'
        user = body[:authenticate_user_login_response][:authenticate_user_login_result][:user_info]
        session_id = body[:authenticate_user_login_response][:authenticate_user_login_result][:session_id]

        Configuration.username = username
        Configuration.password = password
        Configuration.session_id = session_id
        Configuration.user = user
        Configuration.save

        return true
      else
        return false
      end
    end

    def self.logout
      return unless Configuration.session_id
      body = endpoint_client.call(:log_off, message: {sessionID: Configuration.session_id}).body

      if body[:log_off_response][:log_off_result][:result] == 'Success'
        Configuration.clear!
      end
    end

    def self.locations
      verify_token

      body = endpoint_client.call(:get_locations, message: {sessionID: Configuration.session_id}).body
      [body[:get_locations_response][:get_locations_result][:locations]].flatten.map do |loc|
        loc[:location_info]
      end
    end

    def self.get_volatile_thermostat_data(thermostat_id)
      verify_token

      body = endpoint_client.call(:get_volatile_thermostat_data, message: {sessionID: Configuration.session_id, thermostatID: thermostat_id}).body

      body[:get_volatile_thermostat_data_response][:get_volatile_thermostat_data_result][:ui]
    end

    private

    def self.verify_token
      if Configuration.session_expired?
        login
      end
    end

  end
end
