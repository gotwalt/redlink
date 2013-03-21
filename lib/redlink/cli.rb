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

    desc 'logout', 'srsly'
    def logout
      Redlink::Endpoint.logout
    end

    desc 'locations', 'places'
    def locations
      p Redlink::Endpoint.locations
    end

    desc 'operations', 'wfasd'
    def operations
      p Redlink::Endpoint.endpoint_client.operations
    end

    desc 'session_id SESSION_ID', 'blah'
    def session_id(session_id)
      Redlink::Configuration.session_id = session_id
    end

  end
end
