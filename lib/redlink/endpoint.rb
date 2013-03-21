require 'savon'

module Redlink
  class Endpoint

    def self.endpoint_client
      @endpoint_client ||= Savon.client wsdl: File.expand_path("../../../wsdl/MobileV2.xml", __FILE__)
    end

    def self.login(username, password)
      method = 'AuthenticateUserName'
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
      return unless Configuration.session_id
      body = endpoint_client.call(:get_locations, message: {sessionID: Configuration.session_id}).body

      body[:get_locations_response][:get_locations_result][:locations]
    end
  end
end
