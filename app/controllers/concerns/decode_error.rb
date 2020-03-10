class DecodeError < CustomError
    def initialize
        super(:invalid_token, 401, 'YOur token is corrupted, please login')
    end
end
