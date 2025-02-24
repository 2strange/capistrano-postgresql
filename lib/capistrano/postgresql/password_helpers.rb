require 'securerandom'

module Capistrano
  module Postgresql
    module PasswordHelpers

      def generate_random_password
        # SecureRandom.hex(10)
        # => use more secure password generation ( 0-9 + a-z )
        # SecureRandom.base36(42)               # method not available.. so we use hex and convert it to base36
        SecureRandom.hex(28).to_i(16).to_s(36)  # generates ~ 44 characters
      end

      def pg_password_generate
        if fetch(:pg_ask_for_password)
          ask :pg_password, "Postgresql database password for the app: "
        elsif fetch(:pg_generate_random_password)
          set :pg_password, generate_random_password
        else
          set :pg_password, nil # Necessary for pg_template
        end
      end
    end
  end
end

