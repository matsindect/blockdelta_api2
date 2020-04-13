class Eventsmediaupload < ApplicationRecord
  has_attached_file :file,
                    :styles => { :thumb => "75x75>", :small => "150x150>" },
                    :path =>':rails_root/non-public/system/:class/:attachment/:id/:style/:basename.:extension',
                    :url => '/:class/:id/:basename.:extension'
  validates_attachment :file, presence: true
  do_not_validate_attachment_file_type :file
end
