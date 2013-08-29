class Author
  include Mongoid::Document

  belongs_to :package

  field :name, type: String
end
