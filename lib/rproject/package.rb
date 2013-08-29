require 'open-uri'
require 'dcf'
require 'rubygems/package'
require 'zlib'

module RProject
  class Package
    CRAN_URL = 'http://cran.r-project.org/src/contrib'

    attr_reader :name, :version

    def self.all
      body = open("#{CRAN_URL}/PACKAGES").read
      Dcf.parse(body.strip).map {|content| new(content)}
    end

    def initialize(attributes={})
      @name = attributes['Package']
      @version = attributes['Version']
    end

    def description
      @description ||= load_description
    end

    private

    def load_description
      source = open("#{CRAN_URL}/#{name}_#{version}.tar.gz")
      tar = Gem::Package::TarReader.new(Zlib::GzipReader.new(source))
      tar.rewind
      description_file = ''
      tar.each { |entry| description_file = Dcf.parse(entry.read.strip).first if entry.full_name.include? "DESCRIPTION" }
      @description = description_file['Description']
    end
  end
end
