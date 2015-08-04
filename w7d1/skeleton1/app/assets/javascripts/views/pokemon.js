Pokedex.Views.Pokemon = Backbone.View.extend({
  initialize: function () {
    this.$pokeList = this.$el.find('.pokemon-list');
    this.$pokeDetail = this.$el.find('.pokemon-detail');
    this.$newPoke = this.$el.find('.new-pokemon');
    this.$toyDetail = this.$el.find('.toy-detail');
    this.pokemon = new Pokedex.Collections.Pokemon();
    this.$pokeList.on("click", "li.poke-list-item", this.selectPokemonFromList.bind(this));
    this.$newPoke.on("submit", this.submitPokemonForm.bind(this));
    this.$pokeDetail.on("click", "li.poke-list-item", this.selectToyFromList.bind(this));
  },

  addPokemonToList: function(pokemon) {
    var li = $('<li>')
      .addClass('poke-list-item')
      .text(pokemon.escape('name') + " " + pokemon.escape('poke_type'))
      .data("id", pokemon.id);

    this.$pokeList.append(li);
  },

  addToyToList: function(toy) {
    var li = $('<li>')
      .addClass('toy-list-item')
      .text("Name: " + toy.escape('name') + " Happiness: " +
            toy.escape('happiness') + " Price: " + toy.escape('price'))
      .data("id", toy.id);

    var img = $('<img>')
      .attr('src', toy.escape('image_url'));

    li.append(img);

    this.$toyDetail.append(li);
  },

  refreshPokemon: function() {
    var view = this;

    view.pokemon.fetch({
      success: function () {
        view.pokemon.each(function (pokemon) {
          view.addPokemonToList(pokemon);
        });
      }
    });
  },

  renderPokemonDetail: function (pokemon) {
    var div = $('<div>')
      .addClass('detail');
    var img = $('<img>')
      .attr('src', pokemon.escape('image_url'));
    var ul = $('<ul>')
      .addClass('toys');

    div.append(img).append(ul);

    _.each(pokemon.attributes, function(val, attribute) {
      if (attribute !== "id" && attribute !== "image_url" && attribute !== "pokemon") {
        var par = $('<p>').text(attribute + " = " + val);
        div.append(par);
      }
    });

    var view = this;
    pokemon.fetch({
      success: function () {
        pokemon.toys().each(function (toy) {
          view.addToyToList(toy);
        });
      }
    });
    this.$pokeDetail.html(div);
  },

  renderToyDetail: function (toy) {
    var div = $('<div>')
      .addClass('detail');

    this.$toyDetail;
  },

  selectPokemonFromList: function (event) {
    var id = $(event.currentTarget).data("id");
    var pokemon = this.pokemon.get(id);
    this.renderPokemonDetail(pokemon);
  },

  selectToyFromList: function (event) {
    var id = $(event.currentTarget).data("id");
    var toy = this.toy.get(id);
    this.renderToyDetail(toy);
  },

  createPokemon: function (attributes, callback) {
    var pokemon = new Pokedex.Models.Pokemon();
    pokemon.save(attributes, {
      success: function () {
        this.pokemon.add(pokemon);
        this.addPokemonToList(pokemon);
        callback(pokemon);
      }.bind(this)
    });
  },

  submitPokemonForm: function (event) {
    event.preventDefault();
    var attributes = $(event.currentTarget).serializeJSON();
    this.createPokemon(attributes, this.renderPokemonDetail.bind(this));
  }
});
