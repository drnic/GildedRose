require './gilded_rose.rb'
require "rspec"

app ||= GildedRose.new

generic_item = app.items.first

describe GildedRose do
  
  
  # Daily delta of type vs attribute
  #
  #         | AgedBrie | Sulfuras | BackstagePasses | Conjured | Item |
  # sell_in |   -1     |   0      |   -1            |   -1     |  -1  |
  # quality |   +1     |   0      |    1,2,3        |   -1     |  -1  |
  
  # Other tests
  # If sell_in == 0; then quality is x2 the above
  [:sell_in, :quality]
  [AgedBrie, Sulfuras, BackstagePasses, Conjured, Item].each do |item_type|
  end
  
  describe "an item" do
    
    it "degrades the sell_in each day" do
      lambda { app.update_quality }.should change(generic_item, :sell_in).by(-1)
    end
    
    it "degrades the quality each day" do
      lambda { app.update_quality }.should change(generic_item, :quality).by(-1)
    end
    
    it "degrades the quality twice as fast after sell_in is 0" do
      generic_item.sell_in = 0
      lambda { app.update_quality }.should change(generic_item, :quality).by(-2)
    end
    
    it "degrades the quality twice as fast after sell_in is 0" do
      generic_item.quality = 0
      lambda { app.update_quality }.should_not change(generic_item, :quality)
    end
    
  end

  describe "Aged Brie intricacies" do
    subject { app.items.find { |i| i.name == "Aged Brie" } }
    
    it "increases the quality each day" do
      lambda { app.update_quality }.should change(subject, :quality).by(2) # existing behavior
    end
    
  end
  
end