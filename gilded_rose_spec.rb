require './gilded_rose.rb'
require "rspec"

app ||= GildedRose.new

describe GildedRose do
  [:sell_in, :quality].each do |attribute|
    describe "lowers #{attribute.to_sym} value of" do
      item_names = app.items.map(&:name)
      original_values = app.items.map(&attribute)
      app.update_quality
      next_day_values = app.items.map(&attribute)
      [item_names, original_values, next_day_values].transpose.each do |name, orig, next_day|
        it "#{name} item each day" do
          next_day.should == (orig - 1)
        end
      end
    end
  end
end