# This file is used by Rack-based servers to start the application.

# Handle healthcheck requests first, to avoid problems with force_ssl.
map '/healthcheck' do
  run Proc.new { |env| ['200', {'Content-Type' => 'text/plain'}, ['ok']] }
end

require ::File.expand_path('../config/environment', __FILE__)
run Rails.application
