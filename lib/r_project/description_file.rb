module RProject
  class DescriptionFile
    attr_reader :description, :maintainer, :author

    def initialize(package, version)
      source = open("#{RProject::CRAN_URL}/#{package}_#{version}.tar.gz")

      @tar = Gem::Package::TarReader.new(Zlib::GzipReader.new(source))
    end

    def description
      attributes['Description']
    end

    def maintainer
      attributes['Maintainer']
    end

    def author
      attributes['Author']
    end

    private

    def attributes
      return @attributes if @attributes

      @tar.each do |entry|
        if entry.full_name.include? "DESCRIPTION"
          @attributes = Dcf.parse(entry.read.strip).first
        end
      end

      @attributes
    end
  end
end
