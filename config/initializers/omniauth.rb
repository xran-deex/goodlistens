OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '226640817500794', '628d48762afa78aca8f4852a833d74aa'
end