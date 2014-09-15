module SpreeBitpay
  module Generators
    class InstallGenerator < Rails::Generators::Base

      def add_javascripts
        append_file 'vendor/assets/javascripts/spree/frontend/all.js', "//= require spree/frontend/spree_bitpay\n"
        append_file 'vendor/assets/javascripts/spree/frontend/all.js', "//= require jquery.easyModal\n"
        append_file 'vendor/assets/javascripts/spree/backend/all.js', "//= require spree/backend/spree_bitpay\n"
      end

      def add_stylesheets
        frontend_css_file = "vendor/assets/stylesheets/spree/frontend/all.css"
        backend_css_file = "vendor/assets/stylesheets/spree/backend/all.css"

        if File.exist?(backend_css_file) && File.exist?(frontend_css_file)
          inject_into_file frontend_css_file, " *= require spree/frontend/spree_bitpay\n", :before => /\*\//, :verbose => true
          inject_into_file backend_css_file, " *= require spree/backend/spree_bitpay\n", :before => /\*\//, :verbose => true
        end
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations'  #FROM=spree_bitpay
      end

      def run_migrations
        run 'bundle exec rake db:migrate'
      end
    end
  end
end
