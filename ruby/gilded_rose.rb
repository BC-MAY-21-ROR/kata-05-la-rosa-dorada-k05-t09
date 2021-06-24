# frozen_string_literal: true

# Comentario de prueba
class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each(&method(:update))
    self
  end

  def update(item)
    case item.name
    when 'Sulfuras, Hand of Ragnaros'
      SulfurasUpdater.new(item).update
    when 'Backstage passes to a TAFKAL80ETC concert'
      BackstagePassesUpdater.new(item).update
    when 'Aged Brie'
      AgedBrieUpdater.new(item).update
    when 'Conjured Mana Cake'
      ConjuredUpdater.new(item).update
    else
      BasicItemUpdater.new(item).update
    end
    nil
  end

  # Comentario de prueba
  class SulfurasUpdater
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def update; end
  end

  # Comentario de prueba
  class BasicItemUpdater
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def update
      item.quality -= 1 if item.quality.positive?
      item.sell_in -= 1
      item.quality -= 1 if item.sell_in.negative? && item.quality.positive?
    end
  end

  # Comentario de prueba
  class ConjuredUpdater
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def update
      item.quality /= 2 if item.quality.positive?
      item.sell_in -= 1
    end
  end

  # Comentario de prueba
  class AgedBrieUpdater
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def update
      item.quality += 1 if item.quality < 50
      item.sell_in -= 1
      item.quality += 1 if item.sell_in.negative? && (item.quality < 50)
    end
  end

  # Comentario de prueba
  class BackstagePassesUpdater
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def update
      if item.quality < 50
        item.quality += 1
        item.quality += 1 if item.sell_in < 11 && (item.quality < 50)
        item.quality += 1 if item.sell_in < 6 && (item.quality < 50)
      end
      item.sell_in -= 1
      item.quality -= item.quality if item.sell_in.negative?
    end
  end
end

# Comentario de prueba
class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
