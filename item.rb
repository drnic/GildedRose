class Item

  attr_accessor :name, :sell_in, :quality
        
  def initialize (name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end


end

class AgedBrie < Item
end

class Sulfuras < Item
end

class BackstagePasses < Item
end

class Conjured < Item
end