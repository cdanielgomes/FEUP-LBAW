let submitReview = document.querySelectorAll('#makeReview');
[].forEach.call(submitReview, function (e) {
  e.addEventListener('submit', sendCreateReview);
})
function sendCreateReview(event)
  {
    event.preventDefault();

    let id = document.querySelector("#userId").value;
    let title = event.target[0].value;
    if(title == "") {
      createError();
    }
    let score = event.target[1].value;
    let description = event.target[2].value;
    let productId = document.getElementById('productId').value;

    sendAjaxRequest('post', "/api/product/" + productId + "/review", {id:id, title:title, score:score, description:description}, reviewAddHandler)

    return false;
  }

  function reviewAddHandler(){

    if(this.status != 200){
      console.log(this.status);
    }
  
    clearFormReview();
    let review = JSON.parse(this.responseText);
  
    let obj = document.querySelector('#reviews').children[1];
  
    innerHTML = createReview(review);
    obj.innerHTML += innerHTML;

    return false;
  }

  function createError() {

    let div = '<span class="help-block"><strong>Invalid Title</strong></span>';

    let obj = document.querySelector("#reviewTitle");

    obj.innerHTML += div;

  }

  function createReview(review){

    let div = '<li class="list-group-item pt-4">';
    div += '<div id="review-'+ review[0]['id'] +'" class="jumptarget">' 
    div += '<h5>' + review[0]['title'] + '</h5>';
    div += '<div class="pontuation">';
    div += '<label>' + review[0]['score'] + '/5</label>';
    div += '<img src="../imgs/star.png" alt="star">';
    div += '</div>';
    div += '<p>';
    if(review[0]['description'] == null)
    review[0]['description'] = "";
    div += review[0]['description'] + '</p>';
    div += '<h5 class="author">'+ review[0]['name'] + '</h5>';
    div += '</div>';
    div += '<div class="report mt-1 pt-5 ml-auto d-flex align-items-end justify-content-end">';
    div += '<div id="report" class="box d-flex flex-column last-card" data-toggle="modal" data-target="#alertReview">Report Review</div>'
    div+= '</div></li>'
      
    return div;
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
