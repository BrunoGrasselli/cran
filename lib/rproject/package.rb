require "open-uri"
require "dcf"

module RProject
  class Package
    URL = "http://cran.r-project.org/src/contrib/PACKAGES"

    attr_reader :name

    def self.all
      body = open(URL).read

      Dcf.parse(body.strip).map {|content| new(content)}
    end

    def initialize(attributes={})
      @name = attributes['Package']
    end
  end
end
