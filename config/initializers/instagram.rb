 Instagram.configure do |config|
  config.client_id     = ENV["CLIENT_ID"]
  config.client_secret = ENV["CLIENT_SECRET"]
  config.access_token  = ENV["ACCESS_TOKEN"]
  config.redirect_uri = "https://mighty-gorge-29532.herokuapp.com/instagram"
end

