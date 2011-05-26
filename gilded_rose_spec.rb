require './gilded_rose.rb'
require "rspec"

app ||= GildedRose.new

describe GildedRose do
  describe "an item" do
    subject { app.items.find { |i| i.name == "+5 Dexterity Vest" } }
    
    it "degrades the sell_in each day" do
      lambda { app.update_quality }.should change(subject, :sell_in).by(-1)
    end
    
    it "degrades the quality each day" do
      lambda { app.update_quality }.should change(subject, :quality).by(-1)
    end
    
    it "degrades the quality twice as fast after sell_in is 0" do
      subject.sell_in = 0
      lambda { app.update_quality }.should change(subject, :quality).by(-2)
    end
    
    it "never drops below 0 quality" do
      subject.quality = 0
      lambda { app.update_quality }.should_not change(subject, :quality)
    end
    
  end

  describe "Aged Brie intricacies" do
    subject { app.items.find { |i| i.name == "Aged Brie" } }
    
    it "increases the quality each day" do
      lambda { app.update_quality }.should change(subject, :quality).by(2) # existing behavior
    end
    
    it "never has quality above 50" do
      subject.quality = 50
      lambda { app.update_quality }.should_not change(subject, :quality)
    end
  end
  
  describe "Sulfuras intricacies" do
    subject { app.items.find { |i| i.name =~ /Sulfuras/ } }
    
    it "never has to be sold" do
      lambda { app.update_quality }.should_not change(subject, :sell_in)
    end
    it "never decreases in quality" do
      lambda { app.update_quality }.should_not change(subject, :quality)
    end
  end
  
  describe "Backstage passes intricacies" do
    subject { app.items.find { |i| i.name =~ /Backstage passes/ } }
    
    describe "increases in quality" do
      
      it "increases the quality by 1 when 11 days or more" do
        [11, 12, 20].each do |days_remaining|
          subject.sell_in = days_remaining
          lambda { app.update_quality }.should change(subject, :quality).by(1)
        end
      end

      it "increases the quality by 2 when 10 days or less" do
        [9, 10].each do |days_remaining|
          subject.sell_in = days_remaining
          lambda { app.update_quality }.should change(subject, :quality).by(2)
        end
      end

      it "increases the quality by 3 when 5 days or less" do
        [4, 5].each do |days_remaining|
          subject.sell_in = days_remaining
          lambda { app.update_quality }.should change(subject, :quality).by(3)
        end
      end
    end
    
    describe "sets quality to 0 after expiry date" do
      it "set the quality to 0 when after sell_in date" do
        subject.sell_in = 0
        app.update_quality
        subject.quality.should == 0
      end
    end
  end
  
  describe "Conjured item intricacies" do
    subject { app.items.find { |i| i.name =~ /Conjured Mana Cake/ } }
    
    it "degrades the quality by 2 each day" do
      lambda { app.update_quality }.should change(subject, :quality).by(-2)
    end
    
    it "degrades the quality twice as fast after sell_in is 0" do
      subject.sell_in = 0
      lambda { app.update_quality }.should change(subject, :quality).by(-4)
    end
    
    it "never drops below 0 quality" do
      subject.quality = 0
      lambda { app.update_quality }.should_not change(subject, :quality)
    end
    
  end
  
end