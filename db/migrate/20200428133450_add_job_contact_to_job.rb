class AddJobContactToJob < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :job_contact, :string
    add_column :jobs, :job_email, :string
  end
end
