require 'spec_helper'

describe Package do
  describe 'attributes' do
    subject { described_class.new name: 'Test', versions: ['1.2.3', '1.3.0'], description: 'Some description' }

    its(:name)            { should eq 'Test' }
    its(:versions)        { should eq ['1.2.3', '1.3.0'] }
    its(:description)     { should eq 'Some description' }
    its(:current_version) { should eq '1.3.0' }
  end
end
