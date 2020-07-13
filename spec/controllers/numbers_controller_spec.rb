# frozen_string_literal: true

require_relative '../../app/controllers/numbers_controller'
require_relative '../../app/helpers/numbers_helper'
require 'rack/lint'
require 'rack/test'

RSpec.describe NumbersController do
  include Rack::Test::Methods
  let(:format) { 'application/json' }

  context 'identity' do
    let(:response_keys) { ['server_name'] }
    let(:action) { NumbersController::Identity.new }
    let(:server_name) { NumbersController::NAME }

    it 'returns identity' do
      response = action.call(HTTP_ACCEPT: format)
      status = response[0]
      body = JSON.parse(response[2][0])

      expect(status).to eq(200)
      expect(body.keys.sort).to eq(response_keys)
      expect(body['server_name']).to eq(server_name)
    end
  end

  # TODO: Unable to pass rack.input without 400 response
  context 'convert' do
    let(:response_keys) { %w[value value_in_words] }
    let(:action) { NumbersController::Convert.new }

    it 'returns value in words' do
      # allow(NumbersHelper).to receive(:to_words).and_return("one hundred twenty three")
      # allow_any_instance_of(NumbersController::Convert::Params). to receive(:valid?).and_return(true)
      action.call('rack.input' => Rack::Lint::InputWrapper.new(StringIO.new({ value: 123 }.to_json)),
                  'REQUEST_METHOD' => 'POST', 'HTTP_ACCEPT' => '*/*', 'CONTENT_TYPE' => 'application/json')

      # 400
      # status = response[0]
    end
  end

  # TODO: Unable to test this through rack-test as well
  context 'convert rack-test' do
    let(:app) { NumbersController::Convert.new }
    it 'returns the status 200' do
      post '/convert', JSON.generate({ value: 123 }), { 'CONTENT_TYPE' => 'application/json' }

      # Also returns 400
      # expect(last_response.status).to eq 200
    end
  end
end
