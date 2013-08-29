require 'spec_helper'

describe PackagesUpdater do
  describe "#update" do
    before do
      packages = [
        stub(name: 'Test 1', version: '1.2.0', description: 'Test'),
        stub(name: 'Test 2', version: '1.3.3', description: 'Test...')
      ]
      RProject::RPackage.stub(:all).and_return(packages)
    end

    after do
      RProject::RPackage.unstub(:all)
    end

    it "adds new repositories" do
      described_class.new.update

      packages = Package.all

      packages.map(&:name).should eq ['Test 1', 'Test 2']
      packages.map(&:versions).should eq [['1.2.0'], ['1.3.3']]
      packages.map(&:current_version).should eq ['1.2.0', '1.3.3']
      packages.map(&:description).should eq ['Test', 'Test...']
    end

    it "updates existing repositories" do
      Package.create! name: 'Test 1', current_version: '1.1.0', versions: ['1.1.0'], description: 'Another description'
      described_class.new.update

      packages = Package.all

      packages.map(&:name).should eq ['Test 1', 'Test 2']
      packages.map(&:versions).should eq [['1.1.0','1.2.0'], ['1.3.3']]
      packages.map(&:current_version).should eq ['1.2.0', '1.3.3']
      packages.map(&:description).should eq ['Test', 'Test...']
    end

    context "if existing version" do
      it "doesn't update the package" do
        Package.create! name: 'Test 1', current_version: '1.2.0', versions: ['1.2.0'], description: 'Another description'
        described_class.new.update

        packages = Package.all

        packages.map(&:versions).should eq [['1.2.0'], ['1.3.3']]
        packages.map(&:description).should eq ['Another description', 'Test...']
      end
    end
  end
end
