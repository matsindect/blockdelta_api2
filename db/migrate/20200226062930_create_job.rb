class CreateJob < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :job_title
      t.string :job_location
      t.datetime :job_deadline
      t.string :job_role
      t.string :job_salary
      t.string :job_description
      t.belongs_to :sector
      t.belongs_to :category
      t.timestamps
    end
  end
end
