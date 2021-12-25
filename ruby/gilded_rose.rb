class GildedRose
  CONCERT = 'Backstage passes to a TAFKAL80ETC concert'
  BRIE = 'Aged Brie'

  def initialize(items)
    @items = items
  end

  def not_brie?(name)
    name != BRIE
  end

  def brie?(name)
    name == BRIE
  end

  def concert?(name)
    name == CONCERT
  end

  def not_concert?(name)
    !concert?(name)
  end

  def adjust_quality(item)
    if not_brie?(item.name) && not_concert?(item.name)
      if item.quality > 0
        if item.name != "Sulfuras, Hand of Ragnaros"
          item.quality = item.quality - 1
        end
      end
    else
      if item.quality < 50
        item.quality = item.quality + 1
        if concert?(item.name)
          if item.sell_in < 11
            if item.quality < 50
              item.quality = item.quality + 1
            end
          end
          if item.sell_in < 6
            if item.quality < 50
              item.quality = item.quality + 1
            end
          end
        end
      end
    end
  end

  def update_quality()
    @items.each do |item|
      adjust_quality(item)

      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in - 1
      end

      if item.sell_in < 0
        if not_brie?(item.name)
          if item.name != CONCERT
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
                item.quality = item.quality - 1
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
