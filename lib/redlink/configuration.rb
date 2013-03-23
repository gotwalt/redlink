require 'yaml'

module Redlink
  class Configuration
    CONFIG_FILE = '~/.redlink'

    def self.app_token
      config_file['app_token']
    end

    def self.app_token=(val)
      self.config_file['app_token'] = val
      save
    end

    def self.session_id
      config_file['session_id']
    end

    def self.session_id=(val)
      config_file['session_id'] = val
      if val
        config_file['session_id_expires'] = Time.now + 3600 # one hour from now
      else
        config_file['session_id_expires'] = nil
      end
    end

    def self.session_expired?
      !config_file['session_id_expires'] && config_file['session_id_expires'] < Time.now
    end

    def self.user
      config_file['user']
    end

    def self.user=(val)
      config_file['user'] = val
    end

    def self.username
      config_file['username']
    end

    def self.username=(val)
      config_file['username'] = val
    end

    def self.password
      config_file['password']
    end

    def self.password=(val)
      config_file['password'] = val
    end

    def self.save
      File.open(File.expand_path(CONFIG_FILE), 'w+') do |f|
        f.write YAML.dump(@config_file)
      end
    end

    def self.clear!
      [:session_id, :user, :username, :password].each do |k|
        self.send("#{k}=", nil)
      end
      self.save
    end

    private

    def self.config_file
      return @config_file if @config_file

      @config_file = {}
      if File.exists?(path = File.expand_path(CONFIG_FILE))
        begin
          @config_file = YAML.load(File.read(path)) || {}
        rescue TypeError => ex

        end
      end

      @config_file
    end


  end
end
