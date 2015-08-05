Pokedex.Views.PokemonDetail = Backbone.View.extend({
  template: JST['pokemonDetail'],

  events: {
    'click .toy-list-item': 'selectToyFromList'
  },

  initialize: function () {
    this.listenTo(this.model, "sync", this.render.bind(this));
  },

  render: function () {
    this.$el.append(this.template({ pokemon: this.model }));

    this.model.toys().each(function (toy) {
      var content = JST['toyListItem']({ toy: toy });
      this.$el.append(content);
    }.bind(this));

    return this;
  },

  selectToyFromList: function (e) {
    var toyId = $(e.currentTarget).data('toy-id');
    var pokeId = this.model.get('id');

    Backbone.history.navigate('pokemon/' + pokeId + '/toys/' + toyId, { trigger: true });
  }
});
