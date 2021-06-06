class Pokemon < ApplicationRecord

  validates_uniqueness_of :name
  validates :name, presence: true
  validates :name, length: { minimum: 5, maximum: 15, allow_nil: false }
  scope :generation, ->(value){ where('generation = ?', "#{ value }")}
end
