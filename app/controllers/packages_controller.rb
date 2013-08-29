class PackagesController < ApplicationController
  def index
    @latest_packages = Package.where(:updated_at.gt => 1.day.ago.to_time).limit(5).desc(:updated_at)
  end

  def show
    @package = Package.find params[:id]
  end

  def search
    @packages = Package.where(name: /#{params[:query]}/)
  end
end
