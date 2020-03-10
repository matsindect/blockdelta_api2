class RecordNotFound < CustomError
    def initialize
        super(:not_found, 404, 'Could not find Blog with that id')
    end
end