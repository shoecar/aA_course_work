Pokedex.Views.ToyDetail = Backbone.View.extend({
  template: JST['toyDetail'],

  render: function () {
    var template = this.template({ toy: this.model, pokemon: [] });
    this.$el.append(template);
    return this;
  }
});
