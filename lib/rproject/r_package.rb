require 'open-uri'
require 'dcf'
require 'rubygems/package'
require 'zlib'

module RProject
  class RPackage
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
      return @description if @description
      load_info
      @description
    end

    def authors
      return @authors if @authors
      load_info
      @authors
    end

    private

    def load_info
      source = open("#{CRAN_URL}/#{name}_#{version}.tar.gz")
      tar = Gem::Package::TarReader.new(Zlib::GzipReader.new(source))
      tar.rewind
      description_file = ''

      tar.each { |entry| description_file = Dcf.parse(entry.read.strip).first if entry.full_name.include? "DESCRIPTION" }

      load_attributes_from(description_file)
    end

    def load_attributes_from(description_file)
      @authors = description_file['Author'].split(',').map(&:strip)
      @description = description_file['Description']
    end
  end
end
