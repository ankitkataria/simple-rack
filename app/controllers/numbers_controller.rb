require 'json'
require 'pry'
require 'hanami/controller'
require 'hanami/validations'

module NumbersController
    NAME = "Ankit Kataria"

    # Identity
    class Identity 
        include Hanami::Action

        def call(params)
            response = {server_name: NAME}
            self.body = response.to_json
        end
    end

    # Convert
    class Convert
        include Hanami::Action

        params do
            required(:value)
        end

        def call(params)
        end
    end
end