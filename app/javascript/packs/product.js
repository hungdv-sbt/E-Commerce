export default class Product {
  addCart(id, detail = false) {
    const url = Routes.cart_items_path();
    let quantity = detail ? $(`input[type=number]#quantity_${id}`).val() : 1

    Popup.confirm('Are you sure you', {
      success: () => {
        Shared.callAjaxRequest(url, { product_id: id, quantity: quantity}, 'post')
        .done(function(data){
          $('input[type=number]#quantity_'+id).val('1');
          $('.counter-shoping').html(data.cart)
        }).fail(function(data){
          Popup.alert('Error adding cart');
        });
      }
    })
  }

  addQuantity(id) {
    const price = $('input#price').val();
    let number_old = $("input[type='number']#quantity_" + id);
    let number_new = Number(number_old.val()) + 1;
    let price_new = price * number_new;

    $('.popup_quickbuy_total_calc').html(Product._formatNumberWithDots(price_new));
    $(`input[type=hidden]#total_price_${id}`).val(price_new)
    number_old.val(number_new)
  }

  removeQuantity(id) {
    const price = $('input#price').val();
    let number_old = $("input[type='number']#quantity_" + id);
    if (number_old.val() == 1) return $("input[type='number']#quantity_" + id).focus();

    let number_new = Number(number_old.val()) - 1;
    let price_new = price * number_new

    $('.popup_quickbuy_total_calc').html(Product._formatNumberWithDots(price_new));
    $(`input[type=hidden]#total_price_${id}`).val(price_new)
    number_old.val(number_new)
  }

  orderProduct(id) {
    const quantity = $(`input[type=number]#quantity_${id}`).val();
    const total_price = $(`input[type=hidden]#total_price_${id}`).val();

    Shared.callAjaxRequest(Routes.order_product_path(), {quantity: quantity, product_id: id, total_price: total_price}, 'post')
    .done(function(data){
      window.location.href = Routes.orders_path();
    })
    .fail(function(data){})

  }

  static _formatNumberWithDots(number) {
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".") + '&nbsp;₫'
  }
}