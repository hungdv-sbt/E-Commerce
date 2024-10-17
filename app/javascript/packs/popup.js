import Swal from 'sweetalert2'
const swal = Swal.mixin({
  showConfirmButton: false,
  timerProgressBar: true,
});
export default class Popup {
  alert(content, title = '', icon = 'success', option = {}) {
    swal.fire({
      title: title,
      icon: icon,
      html: content,
    });
  }

  confirm(title = '', options = {}) {
    options.cancelBtn = options.cancelBtn === 'true';
    options.successBtn = options.successBtn ? false : true;
    options.confirmText ||= "OK";
    options.cancelText ||= "Cancel";
    options.success ||= null;
    options.fail ||= null;

    swal.fire({
      title: title,
      showCancelButton: options.cancelBtn,
      showConfirmButton: options.successBtn,
      confirmButtonText: options.confirmText,
      cancelButtonText: options.cancelText,
    }).then((result) => {
      if (result.isConfirmed) {
        if (typeof options.success === 'function') options.success()
      } else if (
        (options.mustCancel && result.isDismissed && result.dismiss === 'cancel') ||
        (!options.mustCancel && result.isDismissed)
      ) {
        if (typeof options.cancel === 'function') options.cancel()
      }
    })
  }
}
