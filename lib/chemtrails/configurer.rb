require 'chemtrails/fetcher'

module Chemtrails
  class Configurer
    def configure(app_name:, rails_env:, env:)
      server = env['CONFIG_SERVER_URL']
      branch = env['CONFIG_SERVER_BRANCH']
      username = env['CONFIG_SERVER_USERNAME']
      password = env['CONFIG_SERVER_PASSWORD']
      profiles = env.fetch('CONFIG_SERVER_PROFILE_ACTIVE', rails_env)

      if server.present?
        fetcher = Chemtrails::Fetcher.new(server, app_name, profiles, branch, username, password)
        env.update(fetcher.fetch_configuration)
      else
        puts "No CONFIG_SERVER_URL provided, Chemtrails will not fetch environment variables"
      end
    end
  end
end