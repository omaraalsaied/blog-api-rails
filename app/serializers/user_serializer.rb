class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :name, :avatar
end
