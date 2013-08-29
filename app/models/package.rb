class Package
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :authors

  field :name, type: String
  field :versions, type: Array
  field :description, type: String
  field :current_version, type: String
end
