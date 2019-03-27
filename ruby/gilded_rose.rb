class GildedRose

  def initialize(items)
    @items = items.collect{|i| ItemOp.new(i)}
  end

  def update_quality()
    @items.each { |item| item.update_quality! }
  end
end

class ItemOp
  LEGENDARY_ARRAY = ['Sulfuras, Hand of Ragnaros']
  WELL_AGED_ARRAY = ['Aged Brie']
  BACKSTAGE_ARRAY = ['Backstage passes to a TAFKAL80ETC concert']
  MAX_QUALITY = 50

  attr_reader :item

  def initialize(item)
    @item = item
    #----
    @type = 'normal'
    @type = 'legendary' if LEGENDARY_ARRAY.include?(item.name)
    @type = 'well_aged' if WELL_AGED_ARRAY.include?(item.name)
    @type = 'backstage' if BACKSTAGE_ARRAY.include?(item.name)
    #-----
  end

  def update_quality!
    return true if @type == 'legendary'

    qlty_taken = 0
    si_taken = 1

    if @type == 'normal'
      qlty_taken = 1
      qlty_taken = 2 if @item.sell_in < 0
    end


    if @type == 'well_aged'
      qlty_taken = -1
    end

    if @type == 'backstage'
      qlty_taken = -1
      qlty_taken = -2 if @item.sell_in < 11
      qlty_taken = -3 if @item.sell_in < 6
      qlty_taken = @item.quality if @item.sell_in < 0
    end

    qlty_taken = 0 if @item.quality.zero? and qlty_taken > 0
    qlty_taken = 0 if @item.quality == MAX_QUALITY and qlty_taken < 0

    @item.quality = @item.quality - qlty_taken
    @item.sell_in = @item.sell_in - si_taken

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