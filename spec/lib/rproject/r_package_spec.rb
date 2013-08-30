require 'spec_helper'

describe RProject::RPackage do
  describe ".all" do
    before do
      body = %{
Package: A3
Version: 0.9.2
Depends: R (>= 2.15.0), xtable, pbapply
Suggests: randomForest, e1071
License: GPL (>= 2)
NeedsCompilation: no

Package: ABCExtremes
Version: 1.0
Depends: SpatialExtremes, combinat
License: GPL-2
NeedsCompilation: no

Package: abf2
Version: 0.7-0
License: Artistic-2.0
NeedsCompilation: no
      }
      stub_request(:get, "http://cran.r-project.org/src/contrib/PACKAGES").to_return({body: body})
    end

    it "lists all packages" do
      described_class.all.map(&:name).should eq ['A3', 'ABCExtremes', 'abf2']
    end
  end

  context "attributes" do
    let(:description_file) {}
    subject { described_class.new('Package' => 'Test', 'Version' => '1.2.3') }

    its(:name)    { should eq 'Test' }
    its(:version) { should eq '1.2.3' }
  end

  context "attibutes from the description file" do
    let(:description_file) { mock({
      author: 'Author 1, Author 2',
      description: 'Text',
      email: 'test@email.com',
      maintainer: 'Maintainer 1 <test2@email.com>'
    }) }

    before do
      body = %{
Package: TExPosition
Version: 2.0.2
Depends: SpatialExtremes, combinat
License: GPL-2
NeedsCompilation: no
      }
      stub_request(:get, "http://cran.r-project.org/src/contrib/PACKAGES").to_return({body: body})
      RProject::DescriptionFile.stub(:new).with('TExPosition', '2.0.2').and_return(description_file)
    end

    after do
      RProject::DescriptionFile.unstub(:new)
    end

    subject { described_class.all.first }

    its(:description)      { should eq 'Text' }
    its(:maintainer_name)  { should eq 'Maintainer 1' }
    its(:maintainer_email) { should eq 'test2@email.com' }
    its(:authors)          { should eq ['Author 1', 'Author 2'] }
  end
end
