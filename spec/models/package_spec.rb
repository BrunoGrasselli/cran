require 'spec_helper'

describe Package do
  describe 'attributes' do
    subject { described_class.new name: 'Test', versions: ['1.2.3', '1.3.0'], description: 'Some description', current_version: '1.3.0' }

    its(:name)            { should eq 'Test' }
    its(:versions)        { should eq ['1.2.3', '1.3.0'] }
    its(:description)     { should eq 'Some description' }
    its(:current_version) { should eq '1.3.0' }
  end

  it "has authors" do
    described_class.new.authors.build.should be_a Author
  end

  it "has maintainer" do
    described_class.new.build_maintainer.should be_a Maintainer
  end
end
