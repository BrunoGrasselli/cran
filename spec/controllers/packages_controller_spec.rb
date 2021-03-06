require 'spec_helper'

describe PackagesController do
  describe "index with GET" do
    before do
      Package.create! name: 'Test', updated_at: 2.days.ago
      Package.create! name: 'Test 2', updated_at: 1.day.ago + 10.seconds
      Package.create! name: 'Test 3'
    end

    it "assigns @latest_packages" do
      get :index
      assigns(:latest_packages).map(&:name).should eq ['Test 3', 'Test 2']
    end

    it "limits @latest_packages to 5" do
      5.times {|n| Package.create! name: "Test #{n + 4}", updated_at: Time.now + n + 1 }
      get :index
      assigns(:latest_packages).map(&:name).should eq ['Test 8', 'Test 7', 'Test 6', 'Test 5', 'Test 4']
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

  describe "search with GET" do
    it "search packages by name" do
      Package.create! name: 'Test 123'
      Package.create! name: 'Another name'
      get :search, query: 'Test'
      assigns(:packages).map(&:name).should eq ['Test 123']
    end

    it "should be success" do
      get :search, query: 'Test'
      response.should be_success
    end

    it "renders show" do
      get :search, query: 'Test'
      response.should render_template :search
    end
  end
end
