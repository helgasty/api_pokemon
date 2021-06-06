class AddIndexToPokemonGenerationField < ActiveRecord::Migration[6.1]
  def change
    add_index :pokemons, :generation
  end
end
