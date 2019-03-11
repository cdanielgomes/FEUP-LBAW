let addressButton = document.getElementById("addressBtn");
addressButton.addEventListener("click", function (event) {
    event.preventDefault();
    let current = document.querySelector("#cart li:nth-child(1) a")
    let next = document.querySelector("#cart li:nth-child(2) a")
    let currentContent = document.querySelector("#address")
    let nextContent = document.querySelector("#payment")

    current.className = "nav-link"
    next.classList.add("active");
    currentContent.className = "tab-pane fade"
    nextContent.className = "tab-pane fade show active"

})

let paymentButton = document.getElementById("paymentBtn");
paymentButton.addEventListener("click", function (event) {
    event.preventDefault();
    let current = document.querySelector("#cart li:nth-child(2) a")
    let next = document.querySelector("#cart li:nth-child(3) a")
    let currentContent = document.querySelector("#payment")
    let nextContent = document.querySelector("#review")

    current.className = "nav-link"
    next.classList.add("active");
    currentContent.className = "tab-pane fade"
    nextContent.className = "tab-pane fade show active"

})


let prices = document.getElementsByClassName("price");
let qts = document.getElementsByClassName("quantity");
let unitPrices = document.getElementsByClassName("subtotal");
let total = document.getElementsByClassName("total");
let t = 0;


for (let i = 0; i < prices.length; i++) {
    let price = parseFloat(prices[i].innerHTML.slice(0, prices[i].innerHTML.length - 1)) * parseFloat(qts[i].innerHTML)
    unitPrices[i].innerHTML = price.toFixed(2) + "€";
    console.log(price)
    t += price;
}
total[0].innerHTML = t.toFixed(2) + "€";