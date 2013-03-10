describe Time do
  describe "#infinite?" do
    it "is true when an infinite time" do
      InfiniteTime.new.infinite?.should == true
    end

    it "is false when not an infinite time" do
      Time.new.infinite?.should == false
    end
  end

  describe "comparison" do
    it "still works against other times" do
      (Time.now < Time.now).should be_true
    end
  end
end
