Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    'click li.poke-list-item': 'selectPokemonFromList'
  },

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon();
    this.listenTo(this.collection, "sync", this.render.bind(this));
  },

  render: function () {
    this.$el.empty();
    this.collection.each(function (pokemon) {
      this.addPokemonToList(pokemon);
    }.bind(this));
  },

  addPokemonToList: function (pokemon) {
    var content = JST["pokemonListItem"]({ pokemon: pokemon });
    this.$el.append(content);
  },

  refreshPokemon: function (callback) {
    this.collection.fetch({
      success: callback
    });
  },

  selectPokemonFromList: function (e) {
    var id = $(e.currentTarget).data('id');
    Backbone.history.navigate("pokemon/" + id, { trigger: true });
  }
});
