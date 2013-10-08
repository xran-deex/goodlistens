OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '226640817500794', '628d48762afa78aca8f4852a833d74aa'
  provider :google_oauth2, '965789525279.apps.googleusercontent.com', 'UWxvf7C4HdDW3AUeRjP6OZCn'
end