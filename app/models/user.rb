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
    def can_modify_blog?(user_id)
        role == 'admin' || role == 'blogger' && id.to_s == user_id.to_s
    end
    # This method tells us if the user is an admin or not.
    def is_blogger?
      role == 'admin' || role == 'blogger'
    end

    # This method tells us if the user is an admin or not.
    def is_candidate?
      role == 'admin' || role == 'candidate'
    end

    def generate_password_token!
      self.reset_password_token = generate_token
      self.reset_password_sent_at = Time.now.utc
      save!
    end
     
    def password_token_valid?
      (self.reset_password_sent_at + 4.hours) > Time.now.utc
    end
     
    def reset_password!(password)
      self.reset_password_token = nil
      self.password = password
      save!
    end
     
     private
     
    def generate_token
      SecureRandom.hex(10)
    end
end
