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
    (itime + 1).should equal itime
    (itime - 1).should eql itime
    (itime - 1).should equal itime
    itime.round.should eql itime
    itime.round.should equal itime
    itime.round(0).should eql itime
    itime.round(0).should equal itime
    itime.succ.should eql itime
    itime.succ.should equal itime
  end

  it "returns an unchanged self when timezone conversion is performed on it" do
    itime = InfiniteTime.new
    itime.getgm.should eql itime
    itime.getutc.should eql itime
    itime.getlocal.should eql itime
    itime.getlocal('+01:00').should eql itime
    itime.localtime.should eql itime
    itime.localtime('+01:00').should eql itime

    itime.gmtime.should eql itime
    itime.utc.should eql itime
  end

  it "cannot be compared against anything but Time objects" do
    expect { InfiniteTime.new <=> Object.new }.to raise_error ArgumentError
    expect { InfiniteTime.new <=> Date.new }.to raise_error ArgumentError
    expect { InfiniteTime.new <=> 321 }.to raise_error ArgumentError
  end

  describe "time compatibility" do
    it "returns nil for all day of the week predicate methods" do
      positive = InfiniteTime.new :+
      negative = InfiniteTime.new :-

      [positive, negative].each do |itime|
        itime.monday?.should == nil
        itime.tuesday?.should == nil
        itime.wednesday?.should == nil
        itime.thursday?.should == nil
        itime.friday?.should == nil
        itime.saturday?.should == nil
        itime.sunday?.should == nil
      end
    end

    it "returns nil for all time zone inquiry methods" do
      positive = InfiniteTime.new :+
      negative = InfiniteTime.new :-

      [positive, negative].each do |itime|
        itime.dst?.should == nil
        itime.isdst.should == nil

        itime.gmt?.should == nil
        itime.utc?.should == nil
        itime.zone.should == nil

        itime.gmt_offset.should == nil
        itime.gmtoff.should == nil
        itime.utc_offset.should == nil
      end
    end

    it "returns the appropriate infinity for time/date inquiry methods" do
      positive = InfiniteTime.new :+
      negative = InfiniteTime.new :-

      positive.year.should    == +Float::INFINITY
      positive.month.should   == +Float::INFINITY
      positive.mon.should     == +Float::INFINITY
      positive.day.should     == +Float::INFINITY
      positive.yday.should    == +Float::INFINITY
      positive.mday.should    == +Float::INFINITY
      positive.wday.should    == +Float::INFINITY
      positive.hour.should    == +Float::INFINITY
      positive.minute.should  == +Float::INFINITY
      positive.second.should  == +Float::INFINITY
      positive.sec.should     == +Float::INFINITY
      positive.subsec.should  == +Float::INFINITY
      positive.nsec.should    == +Float::INFINITY
      positive.usec.should    == +Float::INFINITY
      positive.tv_nsec.should == +Float::INFINITY
      positive.tv_usec.should == +Float::INFINITY

      negative.year.should    == -Float::INFINITY
      negative.month.should   == -Float::INFINITY
      negative.mon.should     == -Float::INFINITY
      negative.day.should     == -Float::INFINITY
      negative.yday.should     == -Float::INFINITY
      negative.mday.should    == -Float::INFINITY
      negative.wday.should    == -Float::INFINITY
      negative.hour.should    == -Float::INFINITY
      negative.minute.should  == -Float::INFINITY
      negative.second.should  == -Float::INFINITY
      negative.sec.should     == -Float::INFINITY
      negative.subsec.should  == -Float::INFINITY
      negative.nsec.should    == -Float::INFINITY
      negative.usec.should    == -Float::INFINITY
      negative.tv_nsec.should == -Float::INFINITY
      negative.tv_usec.should == -Float::INFINITY
    end

    it "returns a TypeError for impossible numeric conversions" do
      itime = InfiniteTime.new

      expect { itime.to_i }.to raise_error TypeError
      expect { itime.to_r }.to raise_error TypeError
    end

    it "has sensible string representations" do
      positive = InfiniteTime.new :+
      negative = InfiniteTime.new :-

      plus_∞ = '+∞'
      minus_∞ = '-∞'

      positive.asctime.should      == plus_∞
      positive.ctime.should        == plus_∞
      positive.inspect.should      == plus_∞
      positive.strftime('').should == plus_∞
      positive.to_s.should         == plus_∞

      negative.asctime.should      == minus_∞
      negative.ctime.should        == minus_∞
      negative.inspect.should      == minus_∞
      negative.strftime('').should == minus_∞
      negative.to_s.should         == minus_∞
    end

    (Time.methods - Time.superclass.methods).each do |method|
      it "undefines the class method '#{method}' since it makes no sense" do
        expect { InfiniteTime.public_send method }.to raise_error NoMethodError
      end
    end
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
      (a.equal? b).should == false
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
      (a.equal? b).should == false
    end

    it "is less than a positively infinite time" do
      positive = InfiniteTime.new :+
      negative = InfiniteTime.new :-

      (negative < positive).should == true
    end
  end
end
