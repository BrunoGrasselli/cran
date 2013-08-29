class Author
  include Mongoid::Document

  has_and_belongs_to_many :packages

  field :name, type: String
end
