require 'rails_helper'

RSpec.describe Pokemon, type: :model do

  context 'validations' do
    it 'should validate name minimum length' do
      (0..3).each do |count|
        expect(Pokemon.new(name: FFaker::FreedomIpsum.characters[0..count]).valid?).to be(false)
      end
    end

    it 'should validate name maximum length' do
      (4..13).each do |count|
        expect(Pokemon.new(name: FFaker::FreedomIpsum.characters[0..count]).valid?).to be(true)
      end
    end

    it 'should validate name presence' do
      expect(Pokemon.new(name: '').valid?).to be(false)
      expect(Pokemon.new(name: nil).valid?).to be(false)
      expect(Pokemon.new(name: FFaker::FreedomIpsum.characters[5..15]).valid?).to be(true)
    end
  end
end