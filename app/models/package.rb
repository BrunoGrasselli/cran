class Package
  include Mongoid::Document

  field :name, type: String
  field :versions, type: Array
  field :description, type: String
  field :current_version, type: String
end
