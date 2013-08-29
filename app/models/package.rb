class Package
  include Mongoid::Document

  field :name, type: String
  field :versions, type: Array
  field :description, type: String

  def current_version
    versions.last
  end
end
