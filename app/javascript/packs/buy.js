$(document).ready(function() {
  $(document).on('click', '.btn-buy-now', function (e) {
    e.preventDefault();

    if($(this).hasClass('disable')){
      return false;
    }
    $(document).find('.btn-buy-now').addClass('disable');
    var self=$(this);
    var parent=$(this).parents('.thumbnail');
    var src=parent.find('img').attr('src');
    var cart=$(document).find('#cart-shop');
    // alert(src);

    var parTop=parent.offset().top;
    var parLeft=parent.offset().left;

    $('<img />', { 
    class: 'img-product-fly',
      src: src
    }).appendTo('body').css({
      'top' : parTop,
      'left' : parseInt(parLeft)+parseInt(parent.width()) -50
    });

    setTimeout(function(){
      $(document).find('.img-product-fly').css({
          'top' : cart.offset().top,
          'left' : cart.offset().left
          
      });

      setTimeout(function(){
        $(document).find('.img-product-fly').remove();
        var citem=parseInt(cart.find('#count-item').data('count'))+1
        const url = Routes.cart_items_path();
        const id = e.target.dataset.product_id
    
        Shared.callAjaxRequest(url, { product_id: id, quantity: 1}, 'post')
        .done(function(data){
          Popup.alert('Add cart success')
          $('input[type=number]#quantity_'+id).val('1');
          $('.counter-shoping').html(data.cart)
        }).fail(function(data){
          Popup.alert('Error adding cart');
        });

        cart.find('#count-item').text(citem).data('count', citem);
        $(document).find('.btn-buy-now').removeClass('disable');
      },1000);
    },500);
  });
})