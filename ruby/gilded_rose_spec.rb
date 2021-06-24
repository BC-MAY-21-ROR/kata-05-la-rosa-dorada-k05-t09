
require 'rspec'
require_relative '../ruby/gilded_rose'

RSpec.describe GildedRose do
  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'foo'
    end
  end

  describe ' Ejemplo ' do
  it ' Valor sell_in puede ser negativo ' do
    items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 0)]
    GildedRose.new(items).update_quality
    expect(items[0].sell_in).to  eq (-1)
    end
  end
  
    describe ' Ejemplo ' do
    it ' Conjured Mana Cake baja su calidad el doble de rápido ' do
    items = [Item.new('Conjured Mana Cake', 3, 6)]
    GildedRose.new(items).update_quality
    expect(items[0].quality).to eq (3) 
    end
  end

end





