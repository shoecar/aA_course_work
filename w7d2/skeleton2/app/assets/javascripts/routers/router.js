Pokedex.Routers.Router = Backbone.Router.extend({
  routes: {
    '': 'pokemonIndex',
    'pokemon/:id': 'pokemonDetail',
    'pokemon/:pokemonId/toys/:toyId': 'toyDetail'
  },

  pokemonIndex: function (callback) {
    this._pokemonIndex = new Pokedex.Views.PokemonIndex();
    this._pokemonIndex.refreshPokemon(callback);
    $("#pokedex .pokemon-list").html(this._pokemonIndex.$el);
  },

  pokemonDetail: function (id, callback) {
    if (!this._pokemonIndex) {
      this.pokemonIndex(this.pokemonDetail.bind(this, id));
      if (callback) {
        this.pokemonIndex(callback);
      }
      return;
    }

    var poke = this._pokemonIndex.collection.get(id);
    this._pokemonDetail = new Pokedex.Views.PokemonDetail({ model: poke });
    $('#pokedex .pokemon-detail').html(this._pokemonDetail.$el);
    poke.fetch();
  },

  toyDetail: function (pokemonId, toyId) {
    if (!this._pokemonDetail) {
      this.pokemonDetail(pokemonId, this.toyDetail.bind(this, pokemonId, toyId));
      return;
    }
    var poke = this._pokemonDetail.model;
    var toy = poke.toys().get(toyId);

    var toyView = new Pokedex.Views.ToyDetail({ model: toy });
    $('#pokedex .toy-detail').html(toyView.render.bind(toyView)().$el);
  }
});
