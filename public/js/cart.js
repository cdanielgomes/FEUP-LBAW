let itemCheckers = document.querySelectorAll('i.fas.fa-trash-alt.ml-auto');
[].forEach.call(itemCheckers, function (checker) {
    checker.addEventListener('click', sendDeleteLine);
});

function sendDeleteLine(event) {
    let line = event.target.getAttribute('value').split("-");
    let idLine = line[0];
    let priceLine = line[1];
    sendAjaxRequest('delete', "/api/line/" + idLine, {idLine : idLine, price: priceLine}, lineDeletedHandler);
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