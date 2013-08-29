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

  describe "simple attributes" do
    subject { described_class.new('Package' => 'Test', 'Version' => '1.2.3') }

    its(:name)    { should eq 'Test' }
    its(:version) { should eq '1.2.3' }
  end

  context "attibutes stored inside the tar.gz" do
    before do
      body = %{
Package: TExPosition
Version: 2.0.2
Depends: SpatialExtremes, combinat
License: GPL-2
NeedsCompilation: no
      }
      stub_request(:get, "http://cran.r-project.org/src/contrib/PACKAGES").to_return({body: body})
      stub_request(:get, "http://cran.r-project.org/src/contrib/TExPosition_2.0.2.tar.gz").to_return({body: File.read('./spec/support/data/TExPosition_2.0.2.tar.gz')})
    end

    subject { described_class.all.first }

    its(:description) { should eq %{TExPosition is an extension of ExPosition for two table analyses, specifically, discriminant analyses.} }

    describe "#authors" do
      it "returns package authors" do
        package = described_class.all.first
        package.authors.should eq ['Derek Beaton', 'Jenny Rieck', 'Cherise R. Chin Fatt', 'Herve Abdi']
      end
    end
  end
end
