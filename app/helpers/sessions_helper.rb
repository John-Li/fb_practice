module SessionsHelper
  
  def parse_omniauth(omniauth)
    { provider: omniauth['provider'],
      uid: omniauth['uid'],
      name: omniauth['info']['name'],
      gender: omniauth['extra']['raw_info']['gender'],
      link: omniauth['extra']['raw_info']['link'],
      picture: omniauth['info']['image'],
      oauth_token: omniauth['credentials']['token'],
      oauth_expires_at: Time.at(omniauth['credentials']['expires_at']) }
  end
end