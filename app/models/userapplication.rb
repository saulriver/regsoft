class Userapplication < ApplicationRecord
  belongs_to :user
  belongs_to :applicationclient
  has_many :incidents
  has_many :users
  def lista_appclient
    "#{applicationclient.application.name} | ANS(#{applicationclient.servicelevel} hrs) | #{applicationclient.client.name} "
  end
end
