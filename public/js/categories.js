$(".1").click(function() {
    let sort_by_name = function(a, b) {
        return a.getAttribute('data-name').toLowerCase().localeCompare(b.getAttribute('data-name').toLowerCase());
    }
  
    let list = document.querySelectorAll(".products_onrow");
    let list_param = document.querySelectorAll(".products_onrow .product_onrow");
  
    let list_paramArr = [].slice.call(list_param).sort(sort_by_name);
  
  
    for (let i = 0; i < list.length; i++) {
        list[i].appendChild(list_paramArr[i]);
        console.log(list[i]);
    }
  
  })
  
  $(".2").click(function() {  
    let sort_by_price = function(a, b) {
      return b.getAttribute('data-name').toLowerCase().localeCompare(a.getAttribute('data-name').toLowerCase());
    }
    let list = document.querySelectorAll(".products_onrow");
    let list_param = document.querySelectorAll(".products_onrow .product_onrow");
    let list_paramArr = [].slice.call(list_param).sort(sort_by_price);
  
  
    for (let i = 0; i < list.length; i++) {
        list[i].appendChild(list_paramArr[i]);
    }
  })
  
  $(".3").click(function() {
    let sort_by_price = function(a, b) {
      return parseInt($(a).find("span").text(), 10) - parseInt($(b).find('span').text(), 10);
    }
    let list = document.querySelectorAll(".products_onrow");
    let list_param = document.querySelectorAll(".products_onrow .product_onrow");
  
    let list_paramArr = [].slice.call(list_param).sort(sort_by_price);
  
  
    for (let i = 0; i < list.length; i++) {
        list[i].appendChild(list_paramArr[i]);
    }
  })