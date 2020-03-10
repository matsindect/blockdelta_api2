class ExpiredSignature < CustomError
    def initialize
        super(:invalid_token, 498, 'Your token has expired, please login')
    end
end
