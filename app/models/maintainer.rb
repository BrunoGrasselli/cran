class Maintainer
  include Mongoid::Document
  
  has_many :packages
end
