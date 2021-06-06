FactoryBot.define do

  factory :pokemon do
    name { FFaker::FreedomIpsum.characters[5..15] }
    type_1 { FFaker::FreedomIpsum.characters[1..10] }
    type_2 { FFaker::FreedomIpsum.characters[1..10] }
    total { rand(0..100) }
    hp { rand(0..100) }
    attack { rand(0..100) }
    defense { rand(0..100) }
    sp_atk { rand(0..100) }
    sp_def { rand(0..100) }
    speed { rand(0..100) }
    generation { rand(0..7) }
    legendary { rand(0..1) }
  end
end
