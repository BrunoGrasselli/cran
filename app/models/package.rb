class Package
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :authors
  belongs_to :maintainer

  field :name, type: String
  field :versions, type: Array
  field :description, type: String
  field :current_version, type: String
end
