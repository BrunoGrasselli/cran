require 'spec_helper'

describe RProject::Package do
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

  describe "#name" do
    it "returns package name" do
      described_class.new('Package' => 'Test').name.should eq 'Test'
    end
  end
end
