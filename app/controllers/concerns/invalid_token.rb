module Error
    class InvalidToken < CustomError
        def initialize
            super(:invalid_token, 401, 'Your token is invalid, please login')
        end
    end
end