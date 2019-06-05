let submitReview = document.querySelectorAll('#makeReview');
[].forEach.call(submitReview, function (e) {
  e.addEventListener('submit', sendCreateReview);
})
function sendCreateReview(event)
  {
    event.preventDefault();

    let id = document.querySelector("#userId").value;
    let title = event.target[0].value;
    let score = event.target[1].value;
    let description = event.target[2].value;
    let productId = document.getElementById('productId').value;

    sendAjaxRequest('post', "/api/product/" + productId + "/review", {id:id, title:title, score:score, description:description}, reviewAddHandler)

  }


  function reviewAddHandler(){

    if(this.status != 200){
      console.log(this.status);
    }
  
    clearFormAddress();
    let addr = JSON.parse(this.responseText);
  
    let obj = document.querySelector('#addresses_title').parentElement;
  
    let innerHTML = createAddress(addr);
    obj.children[1].innerHTML += innerHTML;

  }

  function clearFormReview(){
    let form = document.getElementById('makeReview')
    form.reset();
  
  }

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
