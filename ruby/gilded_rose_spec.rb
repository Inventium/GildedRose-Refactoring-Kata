# frozen_string_literal: true

require 'byebug'
require_relative 'gilded_rose'

describe GildedRose do
  describe '#update_quality' do
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
