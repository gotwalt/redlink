require 'savon'

module Redlink
  class Endpoint

    def self.login(username = Configuration.username, password = Configuration.password)
      return unless username && password

      params = {
        username: username,
        password: password,
        applicationID: Redlink::Configuration.app_token,
        applicationVersion: 2,
        uiLanguage: 'Default'
      }

      result = call_remote_method(:authenticate_user_login, message: params)

      if result[:result] == 'Success'
        user = result[:user_info]
        session_id = result[:session_id]

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
      if Configuration.session_id
        call_remote_method(:log_off, message: {sessionID: Configuration.session_id})
      end

      Configuration.clear!
    end

    def self.locations
      result = call_remote_method(:get_locations, message: {sessionID: Configuration.session_id})
      [result[:locations]].flatten.map do |loc|
        loc[:location_info]
      end
    end

    def self.get_volatile_thermostat_data(thermostat_id)
      verify_token

      result = call_remote_method(:get_locations, message: {sessionID: Configuration.session_id, thermostatID: thermostat_id})

      result[:ui]
    end

    private

    def self.verify_token
      if Configuration.session_expired?
        login
      end
    end

    def self.call_remote_method(method, options)
      verify_token
      body = endpoint_client.call(method, options).body
      result = body["#{method}_response".to_sym]["#{method}_result".to_sym]
      raise InvalidSessionError.new if result[:result] == 'InvalidSessionID'
      result
    end


    def self.endpoint_client
      @endpoint_client ||= Savon.client do
        wsdl File.expand_path("../../../wsdl/MobileV2.xml", __FILE__)
        log_level :warn
        log false
      end
    end

    class InvalidSessionError < StandardError; end
    class NoCredentialsError < StandardError; end
  end

end
