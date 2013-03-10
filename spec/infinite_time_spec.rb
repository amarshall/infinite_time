require './lib/infinite_time'

describe InfiniteTime do
  it "behaves like a Time" do
    InfiniteTime.new.is_a?(Time).should == true
  end

  it "is positively infinite by default" do
    itime = InfiniteTime.new
    itime.positive?.should == true
    itime.negative?.should == false
  end

  it "raises InvalidSign when given anything other than :+ or :-" do
    expect { InfiniteTime.new }.to_not raise_error InfiniteTime::InvalidSign
    expect { InfiniteTime.new :+ }.to_not raise_error InfiniteTime::InvalidSign
    expect { InfiniteTime.new :- }.to_not raise_error InfiniteTime::InvalidSign
    expect { InfiniteTime.new :~ }.to raise_error InfiniteTime::InvalidSign
  end

  it "returns an unchanged self when math is performed on it" do
    itime = InfiniteTime.new
    (itime + 1).should eql itime
    (itime - 1).should eql itime
  end

  it "cannot be compared against anything but Time objects" do
    expect { InfiniteTime.new <=> Object.new }.to raise_error TypeError
    expect { InfiniteTime.new <=> Date.new }.to raise_error TypeError
    expect { InfiniteTime.new <=> 321 }.to raise_error TypeError
  end

  describe "a positively infinite time" do
    it "is created by passing :+ to #new" do
      itime = InfiniteTime.new :+
      itime.positive?.should == true
      itime.negative?.should == false
    end

    it "is greater than all non-infinite times" do
      itime = InfiniteTime.new :+
      time = Time.now + 10000

      (itime > time).should == true
      (itime <= time).should == false
      (time < itime).should == true
      (time >= itime).should == false
    end

    it "is equal to another positively infinite time" do
      a, b = InfiniteTime.new(:+), InfiniteTime.new(:+)
      (a == b).should == true
      (a.eql? b).should == true
    end

    it "is greater than a negatively infinite time" do
      positive = InfiniteTime.new :+
      negative = InfiniteTime.new :-

      (positive > negative).should == true
    end
  end

  describe "a negatively infinite time" do
    it "is created by passing :- to #new" do
      itime = InfiniteTime.new :-
      itime.positive?.should == false
      itime.negative?.should == true
    end

    it "is less than all non-infinite times" do
      itime = InfiniteTime.new :-
      time = Time.now - 10000

      (itime < time).should == true
      (itime >= time).should == false
      (time > itime).should == true
      (time <= itime).should == false
    end

    it "is equal to another negatively infinite time" do
      a, b = InfiniteTime.new(:-), InfiniteTime.new(:-)
      (a == b).should == true
      (a.eql? b).should == true
    end

    it "is less than a positively infinite time" do
      positive = InfiniteTime.new :+
      negative = InfiniteTime.new :-

      (negative < positive).should == true
    end
  end
end
