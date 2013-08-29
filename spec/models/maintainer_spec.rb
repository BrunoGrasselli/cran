require 'spec_helper'

describe Maintainer do
  let(:maintainer) { described_class.new }

  it "has packages" do
    maintainer.packages.build.should be_a Package
  end

  context "attributes" do
    subject { described_class.new email: 'test@gmail.com', name: 'Test' }

    its(:email) { should eq 'test@gmail.com' }
    its(:name) { should eq 'Test' }
  end
end
