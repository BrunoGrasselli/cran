class Maintainer
  include Mongoid::Document
  
  has_many :packages

  field :email, type: String
  field :name, type: String
end
