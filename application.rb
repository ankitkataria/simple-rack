require 'hanami/router'
 
class Application

  # Application router 
  def self.router
    Hanami::Router.new do
      # identity
      get '/identity', to: NumbersController::Identity

      # convert
      post '/convert', to: NumbersController::Convert
    end
  end
end