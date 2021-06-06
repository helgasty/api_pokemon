namespace :pokemon do
  desc "import pokemons list from csv"
  task import: :environment do

    require 'csv'
    batch = []

    # truncate previous pokemon
    Pokemon.delete_all

    CSV.foreach(Rails.root.join('public','pokemon.csv'), encoding:'utf-8', col_sep: ',', headers: true) do |pokemon|
      batch << {
        name: pokemon[1],
        type_1: pokemon[2],
        type_2: pokemon[3],
        total: pokemon[4],
        hp: pokemon[5],
        attack: pokemon[6],
        defense: pokemon[7],
        sp_atk: pokemon[8],
        sp_def: pokemon[9],
        speed: pokemon[10],
        generation: pokemon[11],
        legendary: pokemon[12],
        created_at: DateTime.now,
        updated_at: DateTime.now
      }
    end

    Pokemon.insert_all!(batch)
  end
end
