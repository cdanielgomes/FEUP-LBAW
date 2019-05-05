
 let itemCheckers = document.querySelectorAll('.fas .fa-trash-alt .ml-auto');
 [].forEach.call(itemCheckers, function(checker) {
   checker.addEventListener('click', sendDeleteAddress);
 });


function encodeForAjax(data) {
    if (data == null) return null;
    return Object.keys(data).map(function(k){
      return encodeURIComponent(k) + '=' + encodeURIComponent(data[k])
    }).join('&');
  }
  
  function sendAjaxRequest(method, url, data, handler) {
    let request = new XMLHttpRequest();
  
    request.open(method, url, true);
    request.setRequestHeader('X-CSRF-TOKEN', document.querySelector('meta[name="csrf-token"]').content);
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.addEventListener('load', handler);
    request.send(encodeForAjax(data));
  }
  
  function sendDeleteAddress(event) {
      let id =  event.target.value;

    sendAjaxRequest('delete', 'api/profile/' + id + "/address/" + id, null, addressDeletedHandler);
  }

  function addressDeletedHandler() {
    if (this.status != 200) window.location = '/profile/' + ;
    let item = JSON.parse(this.responseText);
    let element = document.querySelector("address-" + item.id);
    element.remove();
  }