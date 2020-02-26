class Category < ApplicationRecord
    has_many :events
    has_many :blogs

     # This method tells us if the user is an admin or not.
     def is_admin?
        role == 'admin'
      end
end
