require 'spec_helper'

describe PackagesController do
  describe "index with GET" do
    before do
      Package.create! name: 'Test', updated_at: 2.days.ago
      Package.create! name: 'Test 2', updated_at: Time.now
      Package.create! name: 'Test 3'
    end

    it "assigns @latest_packages" do
      get :index
      assigns(:latest_packages).map(&:name).should eq ['Test 2', 'Test 3']
    end

    it "should be success" do
      get :index
      response.should be_success
    end

    it "renders index" do
      get :index
      response.should render_template :index
    end
  end

  describe "show with GET" do
    let(:package) { Package.create! name: 'Test' }

    it "assigns @package" do
      get :show, id: package.id
      assigns(:package).name.should eq 'Test'
    end

    it "should be success" do
      get :show, id: package.id
      response.should be_success
    end

    it "renders show" do
      get :show, id: package.id
      response.should render_template :show
    end
  end
end
