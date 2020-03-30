class Jobsmedium < ApplicationRecord
  include Filterable
  belongs_to :job
  scope :filter_by_job_id, -> (job_id) { where job_id: job_id }
  has_attached_file :file,
                    :styles => { :thumb => "75x75>", :small => "150x150>" },
                    :path =>':rails_root/non-public/system/:class/:attachment/:id/:style/:basename.:extension',
                    :url => '/:class/:id/:basename.:extension'
  validates_attachment :file, presence: true, content_type: { content_type: "image/jpeg" }
end
