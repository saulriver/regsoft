class Incident < ApplicationRecord
  has_many :managefiles, dependent: :destroy
  accepts_nested_attributes_for :managefiles, allow_destroy: true,
    reject_if: :all_blank # Ignore the blank template record

    mount_uploader :picture, PictureUploader
  paginates_per 5
  max_paginates_per 100
  validates :description, :presence => true
  belongs_to :area
  belongs_to :userapplication
  belongs_to :user
  belongs_to :criticality
  has_many :incidentfiles
  has_many :incidentmanagements
end
