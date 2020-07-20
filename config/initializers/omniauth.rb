Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
    ENV["GOOGLE_CLIENT_ID"] = "1034385630020-9auir9964t23q61jsfqm17jrca4ve4i0.apps.googleusercontent.com",
    ENV["GOOGLE_SECRET"] = "SExvN7P511PuVe7ry-lua4dc",
    scope: "email"
  provider :facebook, ENV["FACEBOOK_APP_ID"] = "1223342678015094", ENV["FACEBOOK_APP_SECRET"] = "f8513434726c49752ee930a6d72fad71", scope: "email", info_fields: "email,name"
end
