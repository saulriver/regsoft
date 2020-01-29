class Incidentmanagement < ApplicationRecord
  has_many :managefiles, dependent: :destroy
  accepts_nested_attributes_for :managefiles, allow_destroy: true,
    reject_if: :all_blank # Ignore the blank template record

   mount_uploader :picture, PictureUploader
   
  paginates_per 5
  max_paginates_per 100
  #validates :picture, :presence => true
  #validates :description, :presence => true
  belongs_to :user
  belongs_to :incident
end