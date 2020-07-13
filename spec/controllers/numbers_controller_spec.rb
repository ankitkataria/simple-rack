# frozen_string_literal: true

require_relative '../../app/controllers/numbers_controller'
require_relative '../../app/helpers/numbers_helper'
require 'rack/test'

RSpec.describe NumbersController do
  include Rack::Test::Methods

  def params(value)
    { value: value }
  end

  let(:format) { 'application/json' }
  let(:convert_response_keys) { %w[value value_in_words] }
  let(:identity_response_keys) { %w[server_name] }

  context 'identity' do
    let(:action) { NumbersController::Identity.new }
    let(:server_name) { NumbersController::NAME }

    it 'returns identity' do
      response = action.call(HTTP_ACCEPT: format)
      status = response[0]
      body = JSON.parse(response[2][0])

      expect(status).to eq(200)
      expect(body.keys.sort).to eq(identity_response_keys)
      expect(body['server_name']).to eq(server_name)
    end
  end

  context 'convert' do
    let(:action) { NumbersController::Convert.new }

    it 'returns value in words' do
      # Stub NumbersHelper as this is a unit test
      allow(NumbersHelper).to receive(:to_words).and_return('one hundred twenty three')
      expect(NumbersHelper).to receive(:to_words).once

      response = action.call('router.params' => { value: 123 },
                             'REQUEST_METHOD' => 'POST', 'HTTP_ACCEPT' => '*/*', 'CONTENT_TYPE' => format)
      status = response[0]
      body = JSON.parse(response[2][0])

      expect(status).to eq(200)
      expect(body.keys.sort).to eq(convert_response_keys)
    end
  end

  # API tests
  context 'convert route test' do
    let(:app) { NumbersController::Convert.new }

    it 'returns 200 with valid params' do
      post '/convert', params(123), { 'CONTENT_TYPE' => format, 'router.params' => params(123) }
      expect(last_response.status).to eq 200

      body = JSON.parse(last_response.body)
      expect(body.keys.sort).to eq(convert_response_keys)
      expect(body['value']).to eq(123)
      expect(body['value_in_words']).to eq('one hundred twenty three')
    end

    it 'returns 400 with invalid params' do
      # Negative parameters are not allowed
      post '/convert', params(-1), { 'CONTENT_TYPE' => format, 'router.params' => params(-1) }
      expect(last_response.status).to eq 400

      # String parameters are not allowed
      post '/convert', params('abc'), { 'CONTENT_TYPE' => format, 'router.params' => params('abc') }
      expect(last_response.status).to eq 400
    end
  end
end
