
 let itemCheckers = document.querySelectorAll('i.fas.fa-trash-alt.ml-auto.addr');

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
      let idAddr =  event.target.getAttribute('value');
      let idUser = document.getElementById('userId').getAttribute('value');
    sendAjaxRequest('delete', 'api/profile/' + idUser + "/address/" + idAddr, null, addressDeletedHandler(idUser));
  }

  function addressDeletedHandler(id) {
    if (this.status != 200) window.location = '/profile/' + id;
    console.log("xD")
    let item = JSON.parse(this.responseText);
    console.log("response");
    let element = document.querySelector("address-" + item.id);
    console.log(element);
    element.remove();
  }