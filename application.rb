# frozen_string_literal: true

require 'hanami/router'

# Application router
class Application
  def self.router
    Hanami::Router.new do
      # identity
      get '/identity', to: NumbersController::Identity

      # convert
      post '/convert', to: NumbersController::Convert
    end
  end
end
