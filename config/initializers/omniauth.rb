OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  # In order to run the server, make sure you set these environment variables!
  client_id = ENV['ALBERT_OAUTH_ID']
  client_secret = ENV['ALBERT_OAUTH_SECRET']
  provider :google_oauth2, client_id, client_secret, {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
