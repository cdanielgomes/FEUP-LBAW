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
    let currentContent = document.querySelector("payment")
    let nextContent = document.querySelector("#review")

    current.className = "nav-link"
    next.classList.add("active");
    currentContent.className = "tab-pane fade"
    nextContent.className = "tab-pane fade show active"

})
