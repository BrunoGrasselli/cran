require 'spec_helper'

describe Author do
  describe "attributes" do
    subject { described_class.new name: 'Test' }

    its(:name) { should eq 'Test' }
  end

  it "has packages" do
    described_class.new.packages.build.should be_a Package
  end
end
