class Api::V1::PokemonController < ApplicationController

  before_action :authenticate_user!
  before_action :set_pokemon_collection, only: [:index]
  before_action :set_pokemon, only: [:show, :update, :destroy]

  def index
    begin
      authorize @pokemons

      begin
        render json: { results: @pokemons }, status: 200
      rescue => e
        render json: { results: t('api.pokemons.index.error', { error_message: e.message }) }, status: 500
      end
    rescue
      render json: { results: t('api.access.not_allow') }, status: 403
    end
  end

  def show
    begin
      authorize @pokemon

      unless @pokemon.nil?
        render json: { results: @pokemon }, status: 200
      else
        render json: { results: t('api.pokemons.show.error') }, status: 404
      end
    rescue
      render json: { results: t('api.access.not_allow') }, status: 403
    end
  end

  def create
    pokemon = Pokemon.new(pokemon_params)

    begin
      authorize pokemon

      begin
        pokemon.save!
        render json: { results: pokemon }, status: 200
      rescue => e
        render json: { results: t('api.pokemons.create.error', { error_message: e.message }) }, status: 500
      end
    rescue
      render json: { results: t('api.access.not_allow') }, status: 403
    end
  end

  def update
    begin
      authorize @pokemon

      begin
        @pokemon.update(pokemon_params)
        render json: { results: t('api.pokemons.update.success') }, status: 200
      rescue => e
        render json: { results: t('api.pokemons.update.error', { error_message: e.message }) }, status: 500
      end
    rescue
      render json: { results: t('api.access.not_allow') }, status: 403
    end
  end

  def destroy
    begin
      authorize @pokemon

      # check pokemon exist before delete it
      if @pokemon.delete
        render json: { results: t('api.pokemons.destroy.success') }, status: 200
      else
        render json: { results: t('api.pokemons.destroy.error') }, status: 500
      end
    rescue
      render json: { results: t('api.access.not_allow') }, status: 403
    end
  end

  private

  def set_pokemon_collection
    @pokemons = Pokemon.all

    # filter collection by 'generation' attribute
    @pokemons = @pokemons.generation(params[:generation]) if params[:generation].present?

    # paginate collection
    if params[:page].present? && params[:limit].present?
      @pokemons = @pokemons.paginate(page: params[:page], per_page: params[:limit])
    else
      @pokemons
    end
  end

  def set_pokemon
    begin
      @pokemon = Pokemon.find(params[:id])
    rescue
      render json: { results: t('api.pokemons.error.not_exist') }, status: 404
    end
  end

  def pokemon_params
    params.require(:pokemon).permit(:name, :type_1, :type_2, :total, :hp, :attack, :defense, :sp_atk, :sp_def, :speed, :generation, :legendary)
  end
end