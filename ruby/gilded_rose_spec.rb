# frozen_string_literal: true

require 'byebug'
require_relative 'gilded_rose'

describe GildedRose do
  describe '#update_quality' do
    context 'initial situation' do
      it 'starts' do
        items = [
          Item.new(name="+5 Dexterity Vest", sell_in=10, quality=20),
          Item.new(name="Aged Brie", sell_in=2, quality=0),
          Item.new(name="Elixir of the Mongoose", sell_in=5, quality=7),
          Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=0, quality=80),
          Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=-1, quality=80),
          Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=20),
          Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=10, quality=49),
          Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=5, quality=49),
          # This Conjured item does not work properly yet
          Item.new(name="Conjured Mana Cake", sell_in=3, quality=6), # <-- :O
        ]
        GildedRose.new(items).update_quality

        aggregate_failures do
          expect(items[0].name).to eq '+5 Dexterity Vest'
          expect(items[0].sell_in).to be 9
          expect(items[0].quality).to be 19

          expect(items[1].name).to eq 'Aged Brie'
          expect(items[1].sell_in).to be 1
          expect(items[1].quality).to be 1

          expect(items[2].name).to eq 'Elixir of the Mongoose'
          expect(items[2].sell_in).to be 4
          expect(items[2].quality).to be 6

          expect(items[3].name).to eq 'Sulfuras, Hand of Ragnaros'
          expect(items[3].sell_in).to be 0
          expect(items[3].quality).to be 80

          expect(items[4].name).to eq 'Sulfuras, Hand of Ragnaros'
          expect(items[4].sell_in).to be -1
          expect(items[4].quality).to be 80

          expect(items[5].name).to eq 'Backstage passes to a TAFKAL80ETC concert'
          expect(items[5].sell_in).to be 14
          expect(items[5].quality).to be 21

          expect(items[6].name).to eq 'Backstage passes to a TAFKAL80ETC concert'
          expect(items[6].sell_in).to be 9
          expect(items[6].quality).to be 50

          expect(items[7].name).to eq 'Backstage passes to a TAFKAL80ETC concert'
          expect(items[7].sell_in).to be 4
          expect(items[7].quality).to be 50

          expect(items[8].name).to eq 'Conjured Mana Cake'
          expect(items[8].sell_in).to be 2
          expect(items[8].quality).to be 5
        end
      end
    end

    context 'adjust quality' do
      let(:items) { [Item.new('fixme', 0, 0)] }
      subject(:rose) { GildedRose.new(items).update_quality }

      it 'does not change the name' do
        expect(rose[0].name).to eq 'fixme'
      end

      it 'subtracts from quality' do
        items = [
          Item.new('fixme', 0, 1)
        ]

        expect(items[0].name).to eq 'fixme'
      end
    end
  end
end
