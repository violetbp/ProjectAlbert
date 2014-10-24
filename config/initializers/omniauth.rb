OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '1058646244312-i87pgh9iac07l9n6gatj13oul0ifrj95.apps.googleusercontent.com', '6ygFtqAaHGKrg9PygbKDFF5k', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
