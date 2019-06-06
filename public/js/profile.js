let itemCheckers = document.querySelectorAll('i.fas.fa-trash-alt.ml-auto.addr');
[].forEach.call(itemCheckers, function (checker) {
  checker.addEventListener('click', sendDeleteAddress);
});

let submitAddress = document.querySelectorAll('#newAddress');
[].forEach.call(submitAddress, function (form) {
  form.addEventListener('submit', sendCreateAddress);
})

let faves = document.getElementsByClassName("fas fa-heart ml-auto");
//faves.forEach(element => {element.addEventListener()});
[].forEach.call(faves, function (elem) {
  elem.addEventListener('click', sendRemoveFav);
});


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

function sendDeleteAddress(event) {
  let idAddr = event.target.getAttribute('value');
  sendAjaxRequest('delete', "/api/address/" + idAddr, null, addressDeletedHandler);
}

function addressDeletedHandler() {
  if (this.status != 200) {
    console.log(this.status);
    return;
  }
  let item = JSON.parse(this.responseText);
  let element = document.querySelector("#address-" + item['id']);
  element.remove();
}

function sendCreateAddress(event) {
  event.preventDefault();
  //return;
  let id = document.querySelector("#userId").value;

  let city = event.target[4].value;
  let street = event.target[2].value;
  let zipCode = event.target[3].value;
  let type_address = event.target[0].value.toLowerCase();
  let country = event.target[5].value;
  let door_number = event.target[1].value;




  sendAjaxRequest('post', "/api/profile/" + id + "/address", { type_address: type_address, country: country, city: city, zipCode: zipCode, street: street, door_number: door_number }, addressCreateHandler)

}

function addressCreateHandler() {
  if (this.status != 200) {
    //window.location = '/';
    console.log(this.status);
  }

  //console.log(this.responseText);
  clearFormAddress();
  let addr = JSON.parse(this.responseText);

  let obj = document.querySelector('#addresses_title').parentElement;

  let innerHTML = createAddress(addr);
  obj.children[1].innerHTML += innerHTML;

  let itemCheckers = document.querySelectorAll('i.fas.fa-trash-alt.ml-auto.addr');

  [].forEach.call(itemCheckers, function (checker) {
    checker.addEventListener('click', sendDeleteAddress);
  });


}

function clearFormAddress() {
  let form = document.getElementById('newAddress')
  form.reset();
  $('#addAddressModal').modal('hide')
  $('.modal-backdrop').remove();
  $('body').removeClass('modal-open');
}

function createAddress(addr) {
  let div = '<div class="mt-2 col-md-6 col-lg-3" id="address-' + addr[0]['id'] + '">';
  div += '<div class="box d-flex flex-column"> <i class="fas fa-trash-alt ml-auto addr" value="' + addr[0]['id'] + '"></i>'

  div += '<div class="d-flex flex-row address-header">';

  if (addr[0]['type_address'] == 'home') {
    div += '<i class="fas fa-home pr-1"></i><h6>Home</h6>';
  } else if (addr['type_address'] == 'work') {
    div += '<i class="fas fa-briefcase pr-1"></i><h6>Work</h6>';
  } else {
    div += '<i class="fab fa-bandcamp pr-1"></i><h6>Other</h6>';
  }


  div += '</div> <h6> ' + addr[0]['door_number'] + " " + addr[0]['street'] + ", " + addr[0]['zipcode'] + " " + addr[1] + " - " + addr[2] + ' </h6></div></div>'

  return div;
}


function sendRemoveFav(event) {
  let id = document.querySelector("#userId").value;
  let helper = event.target.parentElement.parentElement;
  let idProduct = helper.getAttribute('id').split('-')[1];

  sendAjaxRequest('delete', "/api/profile/" + id + "/products/" + idProduct, null, removeFavHandler);
}

function removeFavHandler() {
  if (this.status != 200) {
    console.log("implementa tudo");
  }

  let info = JSON.parse(this.responseText);
  if (info === 0) return;
  removeCard(info);
}

function removeCard(id) {
  let i = document.getElementById("favorite-" + id)
  i.remove();

}