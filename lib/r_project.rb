module RProject
  CRAN_URL = 'http://cran.r-project.org/src/contrib'

  require 'open-uri'
  require 'dcf'
  require 'rubygems/package'
  require 'zlib'
  require 'r_project/r_package'
  require 'r_project/description_file'
end
