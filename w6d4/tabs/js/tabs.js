(function ($) {
  $.Tabs = function (el) {
    this.$el = $('el');
    this.$contentTabs = $(this.$el.data('content-tabs'));
    this.$activeTab = this.$contentTabs.find('.active');
    $("ul").on("click", "a", this.clickTab);
  };

  $.Tabs.prototype.clickTab = function (e) {
    var that = this;
    e.preventDefault();
    var $tab = $(e.currentTarget);
    $('div .active').removeClass('active').addClass('transitioning');
    $('.active').removeClass('active');
    $('.transitioning').one("transitionend", function (e) {
      var $trans = $(e.currentTarget);
      $trans.removeClass('transitioning');
      // that.$activeTab = that.$contentTabs.find('.active');
      $tab.parent().addClass('active');
      // transitioning

      var $tabID = $($tab.attr('for'));
      $tabID.parent().addClass('transitioning');
      $tabID.parent().addClass('active');
      setTimeout(function() {$tabID.parent().removeClass('transitioning')},0);
    })
  };

  $.fn.tabs = function () {
    return this.each(function () {
      new $.Tabs(this);
    });
  };
})(jQuery);
