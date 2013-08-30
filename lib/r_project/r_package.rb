module RProject
  class RPackage
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
      description_file.description
    end

    def authors
      description_file.author.split(',').map(&:strip)
    end

    def maintainer_name
      description_file.maintainer.match(/([^<]*)<[^>]+>/)
      $1.strip
    end

    def maintainer_email
      description_file.maintainer.match(/[^<]*<([^>]+)>/)
      $1.strip
    end

    private

    def description_file
      @description_file ||= DescriptionFile.new(name, version)
    end
  end
end
