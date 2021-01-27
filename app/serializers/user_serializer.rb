class UserSerializer
  include JSONAPI::Serializer
  attributes  :id, :name, :login, :provider, :url, :avatar_url
end