require_relative 'application'
require 'hanami/middleware/body_parser'

# Load controllers
Dir[File.join(File.dirname(__FILE__), 'app/controllers', '**', '*.rb')].sort.each do
    |file| require file
end

# Load Helpers
Dir[File.join(File.dirname(__FILE__), 'app/helpers', '**', '*.rb')].sort.each do
    |file| require file
end

# Use stock JSON-parsers
use Hanami::Middleware::BodyParser, :json

# Running server
run Application.router