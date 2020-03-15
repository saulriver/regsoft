class Incident < ApplicationRecord
  include AASM

  #Columna con la cual manejaremos los estados!
  aasm column: 'state' do 
    state :draft, initial: true
    state :verified
    state :published
    state :rejected

      event :verify do
        transitions from: :draft, to: :verified
      end
  
      event :reject do
        transitions from: :verified, to: :rejected
      end
  
      event :publish do
        transitions from: :verified, to: :published
      end
  end
  
  paginates_per 5
  max_paginates_per 100
  
  has_many :incidentfiles, dependent: :destroy
  accepts_nested_attributes_for :incidentfiles, allow_destroy: true,
    reject_if: :all_blank # Ignore the blank template record

   mount_uploader :picture, PictureUploader
  validates :description, :presence => true
  validates :area, :presence => true
  
  belongs_to :area
  belongs_to :userapplication
  belongs_to :user
  belongs_to :criticality
  has_many :incidentmanagements
  
end
