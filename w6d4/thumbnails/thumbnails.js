(function ($) {
  $.Thumbnails = function (el) {
    this.$el = el;
    this.$gutterImages = $('.gutter-images')
    this.$activeImg = this.$gutterImages.children().eq(0)
    this.activate(this.$activeImg);

    this.$gutterImages.on('mouseenter', 'img', function(e) {
      $img = $(e.currentTarget);
      this.activate($img);
    }.bind(this))

    this.$gutterImages.on('mouseleave', 'img', function(e) {
      $img = $(e.currentTarget);
      this.$activeImg = $img;
      this.activate(this.$activeImg);
    }.bind(this))
  }
  $.Thumbnails.prototype.activate = function (img) {
    $('div.active img').remove();
    img.clone().appendTo('div.active')
  };

  $.fn.thumbnails = function () {
    return this.each(function () {
      new $.Thumbnails(this);
    });
  }
})(jQuery)
