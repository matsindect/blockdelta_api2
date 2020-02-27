class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :role, :created_at, :updated_at, :last_login, :reset_password_token, :reset_password_sent_at
end
