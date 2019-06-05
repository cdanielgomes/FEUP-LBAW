@extends('layouts.app', ['categories' = $categories])

@section('styles')

<link href="{{ asset('css/cart.css') }}" rel="stylesheet">

@endsection


@section('content')

<main class="cart">
  <section class="container">
    <div class="row my-3">
    <h1 class="my-2"> Checkout </h1>


    <!-- Button trigger modal -->
    <button type="button" class="btn overlay text-right" data-toggle="modal" data-target="#exampleModal">
        <div class="container topright text-aling-top">
          <i class="far topright fa-question-circle fa-2x text-top "></i>
        </div>
      </button>


      <!-- Modal -->
      <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLabel">What is Checkout?</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              Egestas integer eget aliquet nibh praesent tristique. Libero justo laoreet sit amet cursus sit amet
              dictum.
              Sed ullamcorper morbi tincidunt ornare massa. Nisi vitae suscipit tellus mauris a diam maecenas. Justo
              donec enim diam vulputate ut pharetra sit amet aliquam. Nunc sed id semper risus in hendrerit gravida
              rutrum.
            </div>
            <div class="modal-footer">
              <div class="container">
                <div class="modal-body">
                  <span><a href="{{route('faq')}}"> More Questions? </a></span> </div>
              </div>
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Got it, thanks!</button>
            </div>
          </div>
        </div>
      </div>


    </div>
    <ul class="nav nav-tabs navbar-expand-md flex-column flex-sm-row" id="cart">
      <li class="nav-item">
        <a class="nav-link active" id="address-tab" data-toggle="tab" href="#address" role="tab" aria-controls="Address" aria-selected="true">Address</a>
      </li>

      <li class="nav-item">
        <a class="nav-link" id="payment-tab" data-toggle="tab" href="#payment" role="tab" aria-controls="Payment Method" aria-selected="false">Payment Method</a>
      </li>

      <li class="nav-item">
        <a class="nav-link" id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="Order Review" aria-selected="false">Order Review</a>
      </li>
    </ul>

    <div class="tab-content" id="cartContent">

      <div class="tab-pane fade show active" id="address" role="tabpanel" aria-labelledby="address-tab">

        <div class="progress" style="height: 2px;">
          <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
        </div>

        <div class="my-3">
          <h4>Invoice</h4>
        </div>


        <form action="#">
          <div class="row">
            <div class="form-group col-lg-6 col-xs-12">
              <label for="FirstName"> First Name </label>
              <input type="text" class=form-control>
            </div>

            <div class="form-group col-lg-6">
              <label for="LastName"> Last Name </label>
              <input type="text" class=form-control>
            </div>
          </div>
          <div class="row">
            <div class="form-group col-lg-4 col-xs-12">
              <label for="Email"> Email </label>
              <input type="email" class=form-control>
            </div>

            <div class="form-group col-lg-8 col-xs-12">
              <label for="StreetAdress"> Street Address </label>
              <input type="text" class=form-control>
            </div>
          </div>
          <div class="row">
            <div class="form-group col-lg-3 col-xs-12">
              <label for="City"> City </label>
              <input type="text" class=form-control>
            </div>

            <div class="form-group col-lg-3 col-xs-12">
              <label for="ZIPCode"> ZIP Code </label>
              <input type="text" class=form-control>
            </div>
          </div>

          <div class="row">
            <div class="form-group col-lg-3 col-xs-12">
              <label for="country"> Country </label>
              <input type="text" class=form-control>
            </div>

            <div class="form-group col-lg-3 col-xs-12">
              <label for="country"> Phone Number </label>
              <input type="tel" class=form-control>
            </div>
          </div>
          <div class="form-group mt-3">
            <input type="checkbox" name="shippingAddress" id="differentSAdd" data-toggle="collapse" data-target="#shippingAddress" aria-controls="shippingAddress">
            <label for="differentSAdd" name="differentSAdd" data-toggle="collapse" data-target="#shippingAddress" aria-controls="shippingAddress">
              Give a different address for shipping
            </label>
          </div>

          <div id="shippingAddress" class="collapse" aria-expanded="false">
            <div class="my-3">
              <h4>Shipping Address</h4>
            </div>

            <div class="row">
              <div class="form-group col-md-6 col-xs-12 ">
                <label for="FirstName"> First Name </label>
                <input type="text" class=form-control>
              </div>

              <div class="form-group col-md-6 col-xs-12">
                <label for="LastName"> Last Name </label>
                <input type="text" class=form-control>
              </div>
            </div>
            <div class="row">
              <div class="form-group col-md-4 col-xs-12">
                <label for="Email"> Email </label>
                <input type="email" class=form-control>
              </div>

              <div class="form-group col-md-8 col-xs-12">
                <label for="StreetAdress"> Street Address </label>
                <input type="text" class=form-control>
              </div>
            </div>
            <div class="row">
              <div class="form-group col-md-3 col-xs-12">
                <label for="City"> City </label>
                <input type="text" class=form-control>
              </div>

              <div class="form-group col-md-3 col-xs-12">
                <label for="ZIPCode"> ZIP Code </label>
                <input type="text" class=form-control>
              </div>
            </div>

            <div class="row">
              <div class="form-group col-md-3 col-xs-12">
                <label for="country"> Country </label>
                <input type="text" class=form-control>
              </div>

              <div class="form-group col-md-3 col-xs-12">
                <label for="country"> Phone Number </label>
                <input type="tel" class=form-control>
              </div>
            </div>
          </div>

          <div class="row">
            <button id="addressBtn" type="button" class="btn col-md-6 col-lg-2 offset-md-8 next">
              <span class="text-justify"> Delivery Method <i class="fas fa-chevron-right pl-2"></i> </span>
            </button>
          </div>
        </form>
      </div>
      <div class="tab-pane fade" id="payment" role="tabpanel" aria-labelledby="payment-tab">
        <div class="progress" style="height: 2px;">
          <div class="progress-bar" role="progressbar" style="width: 66%;" aria-valuenow="66" aria-valuemin="0" aria-valuemax="100"></div>
        </div>

        <form class="row" action="#">
            <div class="container pt-3">
              <div class="col-lg-6 col-xs-12">

                <div class="form-group">
                  <label class="form-label" for="cardNumber"> Card Number </label>
                  <input class="form-control" type="text" id="cardNumber">
                </div>
                <div class="form-group">
                  <label for="expDate"> Expiration Date </label>
                  <input id="cardNumber" type="date" class="form-control" placeholder="Your expiration date">
                </div>

                <div class="form-group">
                  <label for="ccv"> CCV </label>
                  <input class="form-control" type="text" id="cardNumber">
                </div>
              </div>
            </div>

            <div class="container-btn pl-5 pt-3">
                <script src="https://www.paypal.com/sdk/js?client-id=sb"></script>
                <div id="paypal-button-container"></div>
                <script>paypal.Buttons().render('#paypal-button-container');</script>
            </div>

          </form>

        <div class="row">
          <button type="button" id="back-button" class="btn col-lg-2 offset-md-2 back-button col-xs-2">
            <a href="#">Back</a>
          </button>
          <button id="paymentBtn" type="button" class="btn col-lg-2 offset-md-4 col-xs-2 next">
            <span class="text-justify">Order Review <i class="fas fa-chevron-right pl-2"></i> </span>
          </button>
        </div>
      </div>

      <div class="tab-pane fade" id="review" role="tabpanel" aria-labelledby="review-tab">
        <div class="progress" style="height: 2px;">
          <div class="progress-bar" role="progressbar" style="width: 100%;" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
        </div>
        <table class="table table-responsive-sm">
          <thead>
            <tr>
              <th scope="col">Product</th>
              <th scope="col">Name</th>
              <th scope="col">Price</th>
              <th scope="col">Quantity</th>
              <th scope="col">Total</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <th scope="row"><img class="img-fluid w-25 h-20" src="assets/pants.png" alt="pants"></th>
              <td class="name">Pants</td>

              <td class="price">32.00€</td>
              <td class="quantity">2</td>
              <td class="subtotal">64.00€</td>
            </tr>
            <tr>
              <th scope="row"><img class="img-fluid w-25 h-20" src="assets/jacket.jpg" alt="jacket"></th>
              <td class="name">Jacket</td>

              <td class="price">26.00€</td>
              <td class="quantity">1</td>
              <td class="subtotal">26.00€</td>
            </tr>
            <tr>
              <td colspan="4" class="justify-content-left"> Total</th>
              <td class="justify-content-right total"> Total2</th>
            </tr>
          </tbody>
        </table>

        <div class="row mt-2">
          <button type="button" id="back-button" class="btn col-lg-2 col-md-3 offset-md-2 back-button">
            <a href="#">Back</a>
          </button>
          <button id="checkoutBtn" type="button" class="btn col-lg-2 col-md-3 offset-md-4 justify-content-center next">
            <span class="text-justify"> Complete Purchase</span>
          </button>
        </div>
      </div>
    </div>
  </section>
</main>

@endsection