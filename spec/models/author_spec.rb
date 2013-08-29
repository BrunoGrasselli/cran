require 'spec_helper'

describe Author do
  describe "attributes" do
    subject { described_class.new name: 'Test' }

    its(:name) { should eq 'Test' }
  end

  it "belongs to package" do
    described_class.new.build_package.should be_a Package
  end
end
