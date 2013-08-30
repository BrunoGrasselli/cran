require 'spec_helper'

describe RProject::DescriptionFile do
  describe "#attributes_from" do
    before do
      stub_request(:get, 'http://cran.r-project.org/src/contrib/TExPosition_2.0.2.tar.gz').to_return({body: File.read('./spec/support/data/TExPosition_2.0.2.tar.gz')})
    end

    subject { described_class.new('TExPosition', '2.0.2') }

    its(:description) { should eq %{TExPosition is an extension of ExPosition for two table analyses, specifically, discriminant analyses.} }
    its(:maintainer) { should eq 'Derek Beaton <exposition.software@gmail.com>' }
    its(:author) { should eq 'Derek Beaton, Jenny Rieck, Cherise R. Chin Fatt, Herve Abdi' }
  end
end
