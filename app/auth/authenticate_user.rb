class AuthenticateUser
    prepend SimpleCommand
    attr_accessor :email, :password
  
    #this is where parameters are taken when the command is called
    def initialize(email, password)
      @email = email
      @password = password
    end
    
    #this is where the result gets returned
    def call
      if user
        {access_token:JsonWebToken.encode(user_id: user.id),
        user_role: user.role}
      end 
    end
  
    private
  
    def user
      user = User.find_by_email(email)
      if user && user.authenticate(password)
        # if user.approved == true
          return user 
        # else
        #   errors.add :user_authentication, 'User not approved'
        # end
      else
        errors.add :user_authentication, 'Invalid credentials'
        nil
      end
    end
end  