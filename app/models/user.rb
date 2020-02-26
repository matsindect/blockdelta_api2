class User < ApplicationRecord
    has_one :profile
    #Validations
    validates_presence_of :username, :email, :password_digest
    validates :email, uniqueness: true
    validates_uniqueness_of   :username
    # Basic password validation, configure to your liking.
    validates_length_of       :password, maximum: 72, minimum: 8, allow_nil: true, allow_blank: false
    validates_confirmation_of :password, allow_nil: true, allow_blank: false
    #encrypt password
    has_secure_password

    # This method gives us a simple call to check if a user has permission to modify.
    def can_modify_user?(user_id)
      role == 'admin' || id.to_s == user_id.to_s
    end

    def can_modify_event?(user1_id)
      role == 'admin' || role == 'blogger' &&  user_id.to_s == user1_id.to_s
    end

    def can_modify_candidate?(user1_id)
      role == 'admin' || role == 'candidate' &&  user_id.to_s == user1_id.to_s
    end
    # This method tells us if the user is an admin or not.
    def is_admin?
      role == 'admin'
    end

    # This method tells us if the user is an admin or not.
    def is_blogger?
      role == 'admin' || role == 'blogger'
    end

    # This method tells us if the user is an admin or not.
    def is_candidate?
      role == 'admin' || role == 'candidate'
    end
end
