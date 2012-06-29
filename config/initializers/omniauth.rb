OmniAuth.config.logger = Rails.logger
ENV['FACEBOOK_KEY'] ||= '202474143212080'
ENV['FACEBOOK_SECRET'] ||= 'd62c0b8ab6b60dc3e9373a855e0ce131'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
end