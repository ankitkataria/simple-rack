# frozen_string_literal: true

require 'json'
require 'pry'
require 'hanami/controller'
require 'hanami/validations'

module NumbersController
  NAME = 'Ankit Kataria'

  # Identity
  class Identity
    include Hanami::Action

    def call(_params)
      response = { server_name: NAME }
      self.body = response.to_json
    end
  end

  # Convert
  class Convert
    include Hanami::Action

    params do
      required(:value).filled(:int?, gteq?: 0)
    end

    def call(params)
      # return BAD_RESPONSE if invalid params
      halt 400 unless params.valid?

      response = {
        value: params.get(:value),
        value_in_words: 'bhai ki value in words'
      }

      self.body = response.to_json
    end
  end
end
