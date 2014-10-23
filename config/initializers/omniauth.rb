OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '1058646244312-7do3u562lh7mb64j5bmjmkngd0bf2c8d.apps.googleusercontent.com', 'gbvuwBvUmnb9tYo1MdJgLZEb', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
