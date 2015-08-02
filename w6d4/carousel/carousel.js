(function ( $ ) {
  $.Carousel = function (el) {
    this.$el = $(el);
    this.activeIdx = 0;
    this.numItems = $('.items img').length;
    this.transitioning = false;
    $('.items img').eq(0).addClass('active');
    $('.slide-right').on('click', function (e) {
      if(this.transitioning) {
        return;
      }
      var oldSlide = $('.items img').eq(this.activeIdx);
      // $('.items img').eq(this.activeIdx).removeClass('active');
      this.activeIdx++;
      if (this.activeIdx === this.numItems) { this.activeIdx = 0; }
      $('.items img').eq(this.activeIdx).addClass('active');
      this.slide('right', oldSlide);
    }.bind(this));

    $('.slide-left').on('click', function (e) {
      if(this.transitioning) {
        return;
      }
      var oldSlide = $('.items img').eq(this.activeIdx);
      // $('.items img').eq(this.activeIdx).removeClass('active');
      this.activeIdx--;
      if (this.activeIdx === -1) { this.activeIdx = this.numItems - 1; }
      $('.items img').eq(this.activeIdx).addClass('active');
      this.slide('left', oldSlide);
    }.bind(this));
  }

  $.Carousel.prototype.slide = function (dir, oldSlide) {

    this.transitioning = true;

    $('.items img').removeClass('left right');
    if (dir === 'left') {
      oldSlide.addClass('right');
    } else {
      oldSlide.addClass('left');
    }

    $('.items img').eq(this.activeIdx).addClass(dir);
    setTimeout(function () {
      $('.items img').eq(this.activeIdx).removeClass(dir);
    }.bind(this), 0);

    oldSlide.one('transitionend', function (e) {
      oldSlide.removeClass('left right active');
      this.transitioning = false;
    }.bind(this));

  };

  $.fn.carousel = function () {
    return this.each(function () {
      new $.Carousel(this);
    });
  }
})(jQuery)
