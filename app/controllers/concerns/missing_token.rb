class MissingToken < CustomError
    def initialize
        super(:unprocessable_entity, 422, 'Missing token, please login')
    end
end