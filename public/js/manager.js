
function encodeForAjax(data) {
  if (data == null) return null;
  return Object.keys(data).map(function (k) {
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


let submitProduct = document.getElementById('addProduct');
submitProduct.addEventListener('submit', createProduct);

let addDiscount = document.getElementById('addDiscount');
addDiscount.addEventListener('submit', createDiscount);

function createProduct(event) {

  event.preventDefault();

  let target = event.target;

  let name = target[0].value;
  let price = target[1].value;
  let color = target[2].value;
  let description = target[3].value;
  let size = target[4].value;
  let stock = target[7].value;

  sendAjaxRequest('post', '/api/product/add', { name: name, price: price, color: color, description: description, size: size, stock: stock }, createProductHandler)

}

function createProductHandler() {
  if (this.status != 200) {
    console.log('ola')
    return;
  }

  let answer = JSON.parse(this.responseText);
  let form = document.getElementById('addProduct');
  form.reset();



  $('#addProductModal').modal('hide');
  $('.modal-backdrop').remove();
  $('body').removeClass('modal-open');
  //add to the products dropdown??

}


function createDiscount(event) {
  event.preventDefault();

  let value = event.target[0].value
  let condition = event.target[1].value

  //nao sei o que fazer para aqui
  
  sendAjaxRequest('post', '/api/discount/add', {value:value, condition:condition}, createDiscountHandler)
}


function createDiscountHandler(){

  if(this.status != 200){
    console.log(this.status);
    return ;
  }

  let answer = JSON.parse(this.responseText);

  addDiscount(answer);

}
