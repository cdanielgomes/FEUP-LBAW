
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

function sendDeleteUser(userId) {

    sendAjaxRequest('delete', "/api/admin/" + userId, null, deleteHandler);
}

let review;

function sendDeleteUserReview(userId, reviewId) {

    review = reviewId;
    sendAjaxRequest('delete', "/api/admin/" + userId, null, deleteReviewHandler);
}

function sendReviewDelete(reviewId) {

    let element = document.querySelectorAll('[name="report-' + reviewId +'"]');
    
    element.forEach(function(e) {
        e.remove();
    })
}

function deleteHandler() {

    if (this.status != 200) {
        console.log(this.status);
        return;
    }
    let id = JSON.parse(this.responseText);
    let element = document.querySelector("#user" + id);
    element.remove();
}

function deleteReviewHandler() {

    if (this.status != 200) {
        console.log(this.status);
        return;
    }
    let id = JSON.parse(this.responseText);
    let element = document.querySelector("#user" + id);
    element.remove();

    sendAjaxRequest('delete', "/api/review/" + review, null, reviewHandler);
}

function reviewHandler() {

    if (this.status != 200) {
        console.log(this.status);
        return;
    }
    let id = JSON.parse(this.responseText);
    let element = document.querySelectorAll('[name="report-' + id +'"]');
    
    element.forEach(function(e) {
        e.remove();
    })
}