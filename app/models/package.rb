class Package
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :versions, type: Array
  field :description, type: String
  field :current_version, type: String
end
