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

  describe "attributes" do
    subject { described_class.new('Package' => 'Test', 'Version' => '1.2.3') }

    its(:name)    { should eq 'Test' }
    its(:version) { should eq '1.2.3' }
  end

  describe "#description" do
    before do
      body = %{
Package: ABCExtremes
Version: 1.0
Depends: SpatialExtremes, combinat
License: GPL-2
NeedsCompilation: no
      }
      stub_request(:get, "http://cran.r-project.org/src/contrib/PACKAGES").to_return({body: body})
      stub_request(:get, "http://cran.r-project.org/src/contrib/ABCExtremes_1.0.tar.gz").to_return({body: File.read('./spec/support/data/ABCExtremes_1.0.tar.gz')})
    end

    it "returns package description" do
      package = described_class.all.first
      package.description.should eq %{This package contains code to 1.) construct the summary statistic needed to facilitate approximate Bayesian computing for spatial extremes, and then 2.) run the ABC-Rejection method to produce a set of draws from the ABC posterior.  The intention is for the user to directly modify the command >abc.rej() to suit his or her purposes.  In general, ABC fitting of max-stable processes is very computationally expensive, and requires advanced programming skills with research computing.}
    end
  end
end
