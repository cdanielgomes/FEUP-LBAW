let itemCheckers = document.querySelectorAll('i.fas.fa-trash-alt.ml-auto');
[].forEach.call(itemCheckers, function (checker) {
    checker.addEventListener('click', sendDeleteLine);
});

function sendDeleteLine(event) {
    let line = event.target.getAttribute('value').split("-");
    let idLine = line[0];
    let priceLine = line[1];
    sendAjaxRequest('delete', "/api/line/" + idLine, { idLine: idLine, price: priceLine }, lineDeletedHandler);
}

function lineDeletedHandler() {
    if (this.status != 200) {
        console.log(this.status);
        return;
    }
    let line = JSON.parse(this.responseText);
    let element = document.querySelector("#line" + line['idLine']);
    let total = document.querySelector(".justify-content-right.total").innerHTML.split(" ");
    total[0] -= line['price'];
    document.querySelector(".justify-content-right.total").innerHTML = total[0] + " €";
    element.remove();
}

let invoiceAddress;
let idUser;
let newLines = [];
let total;

function completePurchase(lines, t) {

    for (i = 0; i < lines.length; i++) {
        newLines[i] = lines[i].id;
    }

    total = t;
    idUser = document.querySelector('#userId').value;
    let street = document.querySelector('#iStreet').value;
    let city = document.querySelector('#iCity').value;
    let zipCode = document.querySelector('#iZip').value;
    let country = document.querySelector('#iCountry').value;
    let type_address = 'other';
    let door_number = document.querySelector('#iDoor').value;

    if (document.querySelector('#shippingAddress').getAttribute('aria-expanded') == 'true') {

        sendAjaxRequest('post', "/api/profile/" + idUser + "/address", { type_address: type_address, country: country, city: city, zipCode: zipCode, street: street, door_number: door_number }, shippingCreateHandler)

    }

    sendAjaxRequest('post', "/api/profile/" + idUser + "/address", { type_address: type_address, country: country, city: city, zipCode: zipCode, street: street, door_number: door_number }, orderHandler);
}

function shippingCreateHandler() {

    if (this.status != 200) {
        console.log(this.status);
        return;
    }

    let addr = JSON.parse(this.responseText);

    invoiceAddress = addr[0].id;

    street = document.querySelector('#sStreet').value;
    city = document.querySelector('#sCity').value;
    zipCode = document.querySelector('#sZip').value;
    country = document.querySelector('#sCountry').value;
    type_address = 'other';
    door_number = document.querySelector('#sDoor').value;

    sendAjaxRequest('post', "/api/profile/" + idUser + "/address", { type_address: type_address, country: country, city: city, zipCode: zipCode, street: street, door_number: door_number }, orderHandler);

}

function orderHandler() {
    if (this.status != 200) {
        console.log(this.status);
        return;
    }

    let addressId;
    let addr = JSON.parse(this.responseText);

    if (invoiceAddress == null) {
        invoiceAddress = addr[0].id;
        addressId = null;
    } else
        addressId = addr[0].id;

    sendAjaxRequest('post', "/api/order", { idUser: idUser, lines: newLines, total: total, invoiceAddress: invoiceAddress, addressId: addressId }, finaldHandler);
}

function finaldHandler() {
    if (this.status != 200) {
        console.log(this.status);
        return;
    }

    window.location.href = "/profile";
}

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