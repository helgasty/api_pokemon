require 'rails_helper'
require 'devise'

RSpec.describe Api::V1::PokemonController, type: :controller do

  describe "check role access action" do
    actions = {
      index: { 'user': 200, 'admin': 200},
      show: { 'user': 200, 'admin': 200},
      create: { 'user': 403, 'admin': 200},
      update: { 'user': 403, 'admin': 200},
      destroy: { 'user': 403, 'admin': 200}
    }

    actions.keys.each do |action|
      actions[action].keys.each do |user_role|

        it "allows #{user_role} to #{action}" do
          sign_in create(:user, user_role)

          case action
          when :index
            get action
          when :create
            post action, params: { pokemon: build(:pokemon).attributes }
          when :update
            get action, params: { id: create(:pokemon).id, pokemon: build(:pokemon).attributes }
          else
            get action, params: { id: create(:pokemon).id }
          end

          expect(response).to have_http_status(actions[action][user_role])
        end
      end
    end
  end

  describe "index action return pokemons list" do
    (0..10).map do
      build(:pokemon)
    end

    it "get pokemons list" do
      sign_in create(:user, :admin)
      get :index

      result = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(Pokemon.find(result['results'][0]['id'])).to_not be_nil
    end
  end

  describe "pokemon has been created" do
    name = FFaker::FreedomIpsum.characters[5..15]

    it "create pokemon" do
      sign_in create(:user, :admin)
      post :create, params: { pokemon: build(:pokemon, name: name).attributes }
      expect(Pokemon.last.name).to eq(name)
    end
  end

  describe "pokemon has been updated" do
    pokemon = create(:pokemon)

    it "update pokemon" do
      sign_in create(:user, :admin)
      put :update, params: { id: pokemon.id, pokemon: { name: FFaker::FreedomIpsum.characters[5..13] } }
      expect(response).to have_http_status(200)
    end

    it "update undifined pokemon" do
      sign_in create(:user, :admin)
      put :update, params: { id: 0, pokemon: { name: FFaker::FreedomIpsum.characters[5..13] } }
      expect(response).to have_http_status(404)
    end
  end

  describe "pokemon has been deleted" do
    pokemon = create(:pokemon)

    it "delete pokemon" do
      sign_in create(:user, :admin)
      get :destroy, params: { id: pokemon.id }

      expect(Pokemon.find_by_id(pokemon.id)).to be_nil
      expect(response).to have_http_status(200)
    end

    it "delete undifined pokemon" do
      sign_in create(:user, :admin)
      get :destroy, params: { id: 0 }
      expect(response).to have_http_status(404)
    end
  end
end