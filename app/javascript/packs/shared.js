export default class Shared {
  callAjaxRequest(url, data = {}, method = 'get', dataType = 'json', sendFile = false) {
    let dataSend = {
      beforeSend: function () {
        $('.preloader').prop('style', '').addClass('loading').fadeIn();
      },
      url: url,
      method: method,
      dataType: dataType,
      data: data,
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      },
      complete: function () {
        $('.preloader').fadeOut();
      }
    }

    if (sendFile) {
      dataSend["processData"] = false;
      dataSend["contentType"] = false;
    }

    return $.ajax(dataSend);
  }

  showModal(ele){
    $(ele).modal('show');
  }
}
  