class RecordNotUnique < CustomError
    def initialize
        super(:unprocessable_entity, 300, 'Username/email already exists, please try again')
    end
end