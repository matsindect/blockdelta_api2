class AuthenticationError < CustomError
    def initialize
        super(:unauthorized, 401, 'Incorrect email or password, please try again')
    end
end