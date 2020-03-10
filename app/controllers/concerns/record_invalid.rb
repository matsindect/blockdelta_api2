class RecordInvalid < CustomError
    def initialize
        super(:unprocessable_entity, 300, 'Your record is invalid, please login')
    end
end