@extends('layouts.app')

@section('styles')
<link href="{{ asset('css/homepage.css') }}" rel="stylesheet">

@endsection

@section('content')

<div>


        <div class="video1">
          
          <div class="video-block block">
            <video src="{{asset('imgs/promovidANIMALS.mp4')}}" autoplay muted loop></video>


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
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>


          </div>

          <div class="margin-top container h-100">
            
            <div class="d-flex h-100 text-center align-items-center">
              <div class="w-100 text-white">
                <h1 class="display-3">WILDLIFE FANATIC ?</h1>
                <a class="btn btn-outline-light">SHOP NOW</a>
              </div>
            </div>
          </div>
        </div>
       </div>
    
      <div class="featuredproducts">
        <div class="mt-5 container">
          <h2>Featured Products</h2>
          <div class="row">
            <div class="mt-3 col-md-5 col-lg-4">
              <div class="box d-flex flex-column align-items-center">
                <img src="{{asset('imgs/pants.png')}}" alt="Item 1" class="center-block" onclick="window.location='product.html'"
                  style="cursor:pointer;">
                <h5 onclick="window.location='product.html'" style="cursor:pointer;">Men's Sprag 5-pocket Pants</h5>
                <span>32,00 €</span>
                <input type="button" class="AddToCart" value="Add to Cart">
              </div>
            </div>
            <div class="mt-3 col-md-5 col-lg-4">
              <div class="box d-flex flex-column align-items-center">
                <img src="{{asset('imgs/pants.png')}}" alt="Item 1" class="center-block" onclick="window.location='product.html'"
                  style="cursor:pointer;">
                <h5 onclick="window.location='product.html'" style="cursor:pointer;">Men's Sprag 5-pocket Pants</h5>
                <span>32,00 €</span>
                <input type="button" class="AddToCart" value="Add to Cart">
              </div>
            </div>
            <div class="mt-3 col-md-5 col-lg-4">
              <div class="box d-flex flex-column align-items-center">
                <img src="{{asset('imgs/pants.png')}}" alt="Item 1" class="center-block" onclick="window.location='product.html'"
                  style="cursor:pointer;">
                <h5 onclick="window.location='product.html'" style="cursor:pointer;">Men's Sprag 5-pocket Pants</h5>
                <span>32,00 €</span>
                <input type="button" class="AddToCart" value="Add to Cart">
              </div>
            </div>
          </div>
        </div>
      </div>
    
      <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
        <div class="carousel-inner" role="listbox">
          <!-- Slide One - Set the background image for this slide in the line below -->
          <div class="carousel-item active w-100" style="background-image: url({{asset('imgs/slide1.jpg')}}">
            <div class="carousel-caption d-md-block">
            </div>
          </div>
          <!-- Slide Two - Set the background image for this slide in the line below -->
          <div class="carousel-item" style="background-image: url({{asset('imgs/slide2.jpg')}})">
            <div class="carousel-caption d-none d-md-block">
            </div>
          </div>
          <!-- Slide Three - Set the background image for this slide in the line below -->
          <div class="carousel-item" style="background-image: url({{asset('imgs/slide3.png')}})">
            <div class="carousel-caption d-none d-md-block">
              <p class="lead">Any questions? Let us know!</p>
            </div>
          </div>
        </div>
        <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="sr-only">Next</span>
        </a>
      </div>
    
      <div class="video2">
        <div class="overlay"></div>
        <div class="video-block block">
        <video src="{{url('imgs/promovidOUTDOORS.mp4')}}" autoplay muted loop></video>
        </div>
    
        <div class="container h-100">
          <div class="d-flex h-100 text-center align-items-center">
            <div class="w-100 text-white">
              <h1 class="display-3">OUTDOORS EXPERTISE</h1>
    
              <a class="btn btn-outline-light">LEARN MORE</a>
            </div>
          </div>
        </div>
      </div>
      </div>
      <div class="saleproducts">
        <div class="mt-5 container">
          <h2>Products on Sale</h2>
          <div class="row">
            <div class="mt-3 col-md-5 col-lg-4">
              <div class="box d-flex flex-column align-items-center">
                <img src="{{asset('imgs/pants.png')}}" alt="Item 1" class="center-block" onclick="window.location='product.html'"
                  style="cursor:pointer;">
                <h5 onclick="window.location='product.html'" style="cursor:pointer;">Men's Sprag 5-pocket Pants</h5>
                <span>32,00 €</span>
                <input type="button" class="AddToCart" value="Add to Cart">
              </div>
            </div>
            <div class="mt-3 col-md-5 col-lg-4">
              <div class="box d-flex flex-column align-items-center">
                <img src="{{asset('imgs/pants.png')}}" alt="Item 1" class="center-block" onclick="window.location='product.html'"
                  style="cursor:pointer;">
                <h5 onclick="window.location='product.html'" style="cursor:pointer;">Men's Sprag 5-pocket Pants</h5>
                <span>32,00 €</span>
                <input type="button" class="AddToCart" value="Add to Cart">
              </div>
            </div>
            <div class="mt-3 col-md-5 col-lg-4">
              <div class="box d-flex flex-column align-items-center">
                <img src="{{asset('imgs/pants.png')}}" alt="Item 1" class="center-block" onclick="window.location='product.html'"
                  style="cursor:pointer;">
                <h5 onclick="window.location='product.html'" style="cursor:pointer;">Men's Sprag 5-pocket Pants</h5>
                <span>32,00 €</span>
                <input type="button" class="AddToCart" value="Add to Cart">
              </div>
            </div>
          </div>
        </div>
      </div>

@endsection