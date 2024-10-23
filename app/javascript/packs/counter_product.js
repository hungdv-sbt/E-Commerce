export default class CounterProduct {
  addQuantity(id) {
    let number_old = $("input[type='number']#quantity_" + id);
    Shared.callAjaxRequest(Routes.update_quantity_cart_items_path(), {cart_item_id: id, quantity: 'add'}, 'post')
    .done(function(data){
      $('#show-cart-items').html(data.cart_items)
      $('.woocommerce-Price-amount.amount.total').html(CounterProduct._formatNumberWithDots(data.total_price))
      let number_new = Number(number_old.val()) + 1;
      number_old.val(number_new)
    });
  }

  removeQuantity(id) {
    let number_old = $("input[type='number']#quantity_" + id);
    if (number_old.val() == 1) return $("input[type='number']#quantity_" + id).focus();
    Shared.callAjaxRequest(Routes.update_quantity_cart_items_path(), {cart_item_id: id, quantity: 'remove'}, 'post')
    .done(function(data){
      $('#show-cart-items').html(data.cart_items)
      $('.woocommerce-Price-amount.amount.total').html(CounterProduct._formatNumberWithDots(data.total_price))
      let number_new = Number(number_old.val()) - 1;
      number_old.val(number_new)
    });
  }

  removeCart(id){
    Popup.confirm('Are you sure you want to remove', {
      success: () => {
        Shared.callAjaxRequest(Routes.cart_item_path(id), {cart_item_id: id}, 'delete')
        .done(function(data){
          Popup.alert('Remove cart succes')
          $('#show-cart-items').html(data.cart_items)
          $('.woocommerce-Price-amount.amount.total').html(CounterProduct._formatNumberWithDots(data.total_price))
          $('.counter-shoping').html(data.count)
        });
      }
    })
  }

  payment(){
    const totalPrice = $('#total-price').val();
    const url = Routes.orders_path()
    Popup.confirm('Are you sure you want to remove', {
      success: () => {
        Shared.callAjaxRequest(url, {total_price: totalPrice}, 'post')
        .done(function(){
          window.location.href = Routes.orders_path();
        })
        .fail(function(data){
          console.log(data);
          if (data.responseJSON.error == 'not_found') {
            Popup.alert('Not found', '', 'error')
          }
        })
      }
    })
  }

  static _formatNumberWithDots(number) {
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".") + '&nbsp;₫'
  }
}