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
    
    it "degrades the quality twice as fast after sell_in is 0" do
      subject.quality = 0
      lambda { app.update_quality }.should_not change(subject, :quality)
    end
    
  end

  describe "Aged Brie intricacies" do
    subject { app.items.find { |i| i.name == "Aged Brie" } }
    
    it "increases the quality each day" do
      lambda { app.update_quality }.should change(subject, :quality).by(2) # existing behavior
    end
    
  end
  
end