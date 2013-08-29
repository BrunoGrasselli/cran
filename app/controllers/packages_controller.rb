class PackagesController < ApplicationController
  def index
    @latest_packages = Package.where(:updated_at.gt => 1.day.ago.to_time)
  end

  def show
    @package = Package.find params[:id]
  end
end
