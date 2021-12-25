# frozen_string_literal: true

require_relative 'gilded_rose'

describe GildedRose do
  describe '#update_quality' do
    let(:items) { [Item.new('fixme', 0, 0)] }
    subject(:rose) { GildedRose.new(items).update_quality }

    it 'does not change the name' do
      expect(rose[0].name).to eq 'fixme'
    end
  end
end
