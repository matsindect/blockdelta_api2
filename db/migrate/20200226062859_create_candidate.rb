class CreateCandidate < ActiveRecord::Migration[6.0]
  def change
    create_table :candidates do |t|
      t.string :first_name
      t.string :surname
      t.string :phone
      t.belongs_to :user
      t.belongs_to :profile
      t.timestamps
    end
  end
end
