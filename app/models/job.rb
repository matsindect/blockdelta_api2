class Job < ApplicationRecord
    belongs_to :sector
    belongs_to :category

     # This method tells us if the user is an admin or not.
    def is_admin?
        role == 'admin'
    end
end
