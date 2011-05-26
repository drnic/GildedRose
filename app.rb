require './gilded_rose.rb'

system = GildedRose.new
day = 0
while true
  puts "Day #{day}"
  puts system.to_s
  sleep 1
  system.update_quality
end
