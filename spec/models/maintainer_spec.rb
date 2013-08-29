require 'spec_helper'

describe Maintainer do
  let(:maintainer) { described_class.new }

  it "has packages" do
    maintainer.packages.build.should be_a Package
  end
end
