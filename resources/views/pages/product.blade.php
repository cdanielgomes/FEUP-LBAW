@extends('layouts.app')

@section('styles')
    
<link href="{{ asset('css/product.css') }}" rel="stylesheet">

@endsection


@section('content')

<div class="mt-1">
    <nav aria-label="breadcrumb" id="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="index.html">Homepage</a></li>
        <li class="breadcrumb-item active" aria-current="page">Product</li>
      </ol>
    </nav>
</div>

</main>
<div class="media pl-5">
        <div id="product-images" class="carousel slide carousel-fade" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#product-images" data-slide-to="0" class="active"></li>
                <li data-target="#product-images" data-slide-to="1"></li>
                <li data-target="#product-images" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
                <div class="carousel-item active d-flex justify-content-center">
                    <img src="assets/pants.png" class="center-block" alt="...">
                </div>
                <div class="carousel-item d-flex justify-content-center">
                    <img src="assets/pants2.png" class="center-block" alt="...">
                </div>
                <div class="carousel-item d-flex justify-content-center">
                    <img src="assets/pants3.png" class="center-block" alt="...">
                </div>
            </div>
            <a class="carousel-control-prev" href="#product-images" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#product-images" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>

        <div class="media-body pl-3">
            <h3 class="mt-0 product-title">Men's Sprag 5-pocket Pants</h3>
            <div id="cart">
                <form method="post" action="" id="AddToCartForm" class="product_form">
                    <p id="product-price">
                        <span class="price">32,00€</span>
                    </p>
                    <p class="favorites" data-toggle="modal" data-target="#alertFavorite"><i class="fas fa-heart pr-1"></i>Add
                        to favorites</p>
                    <div class="product-add">
                        <label for="quantity">Quantity</label>
                        <input min="1" type="number" id="quantity" name="quantity" value="1">
                        <div class="dropdown">
                            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Color
                            </button>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <a class="dropdown-item" href="#">Dark Brown <span class="px-2 ml-2" id="option1"></span></a>
                                <a class="dropdown-item" href="#">Black <span class="px-2 ml-2" id="option2"></span></a>
                                <a class="dropdown-item" href="#">Navy <span class="px-2 ml-2" id="option3"></span></a>
                            </div>
                        </div>
                        <div class="dropdown">
                            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Size
                            </button>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <a class="dropdown-item" href="#">36</a>
                                <a class="dropdown-item" href="#">38</a>
                                <a class="dropdown-item" href="#">40</a>
                                <a class="dropdown-item" href="#">42</a>
                                <a class="dropdown-item" href="#">44</a>
                            </div>
                        </div>
                        <input type="submit" name="button" class="AddtoCart" value="Add to Cart">
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal fade" id="alertFavorite" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Added to favorites!</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div id="informations">
        <ul class="list-group list-group-flush">
            <li class="list-group-item pt-4">
                <h6>Description</h6>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore
                    et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut
                    aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
                    cillum dolore eu fugiat nulla pariatur.</p>
            </li>
            <li class="list-group-item pt-4">
                <div id="reviews" class="jumptarget">
                    <h6>Reviews</h6>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item pt-4">
                            <form method="post" action="" id="makeReview">
                                <h6>Make your review</h6>
                                <div>Title<br />
                                    <input type="text" id="data" name="data" class="form-control" />
                                </div>
                                <div>Rating<br />
                                    <div class="getValue d-flex justify-content-center">
                                        <span class="value">1</span>
                                        <input type="range" class="custom-range" id="formControlRange" min=1 max=5>
                                        <span class="value">5</span>
                                    </div>
                                </div>
                                <div>Review<br />
                                    <textarea id="data_8" false name="data_8" rows="5" maxlength="250" class="form-control">Maximum 250 characters...</textarea>
                                </div>
                                <div><input name="Submit" value="Submit" type="submit" /></div>
                            </form>
                        </li>
                        <li class="list-group-item pt-4">
                            <div id="review-1" class="jumptarget">
                                <h5>Zombie Ipsum</h5>
                                <div class="pontuation">
                                    <label>4/5</label>
                                    <img src="assets\star.png" alt="star">
                                </div>
                                <p>Zombie ipsum reversus ab viral inferno, nam rick grimes malum cerebro. De carne
                                    lumbering
                                    animata corpora quaeritis. Summus brains sit​​, morbo vel maleficia? De apocalypsi
                                    gorger
                                    omero undead survivor dictum mauris. Hi mindless mortuis soulless creaturas, imo
                                    evil
                                    stalking monstra adventus resi dentevil vultus comedat cerebella viventium.</p>
                                <h5 class="author">Jane Doe</h5>
                            </div>
                            <div class="report mt-1 pt-5 ml-auto d-flex align-items-end justify-content-end">
                                <div id="report" class="box d-flex flex-column last-card" data-toggle="modal"
                                    data-target="#alertReview">
                                    Report Review
                                </div>
                            </div>
                        </li>
                        <li class="list-group-item pt-4">
                            <div id="review-2" class="jumptarget">
                                <h5>Hipster Ipsum</h5>
                                <div class="pontuation">
                                    <label>5/5</label>
                                    <img src="assets\star.png" alt="star">
                                </div>
                                <p>Lorem ipsum dolor amet mustache knausgaard +1, blue bottle waistcoat tbh semiotics
                                    artisan
                                    synth stumptown gastropub cornhole celiac swag. Brunch raclette vexillologist
                                    post-ironic
                                    glossier ennui XOXO mlkshk godard pour-over blog tumblr humblebrag. Blue bottle put
                                    a
                                    bird
                                    on it twee prism biodiesel brooklyn. Blue bottle ennui tbh succulents.</p>
                                <h5 class="author">Jone Doe</h5>
                            </div>
                            <div class="report mt-4 pt-5 ml-auto d-flex align-items-end justify-content-end">
                                <div id="report" class="box d-flex flex-column last-card" data-toggle="modal"
                                    data-target="#alertReview">
                                    Report Review
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </li>

            <div class="modal fade" id="alertReview" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
                aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">Review Reported!</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <li class="list-group-item">
                <div class="featuredproducts">
                    <div class="mt-3 container">
                        <h6>Related Products</h6>
                        <div class="row">
                            <div class="mt-3 col-md-5 col-lg-4">
                                <div class="box d-flex flex-column align-items-center">
                                    <img src="assets/pants.png" alt="Item 1" class="center-block" onclick="window.location='product.html'"
                                        style="cursor:pointer;">
                                    <h5 onclick="window.location='product.html'" style="cursor:pointer;">Men's Sprag
                                        5-pocket Pants</h5>
                                    <span>32,00 €</span>
                                    <input type="button" class="AddToCart" value="Add to Cart">
                                </div>
                            </div>
                            <div class="mt-3 col-md-5 col-lg-4">
                                <div class="box d-flex flex-column align-items-center">
                                    <img src="assets/pants.png" alt="Item 1" class="center-block" onclick="window.location='product.html'"
                                        style="cursor:pointer;">
                                    <h5 onclick="window.location='product.html'" style="cursor:pointer;">Men's Sprag
                                        5-pocket Pants</h5>
                                    <span>32,00 €</span>
                                    <input type="button" class="AddToCart" value="Add to Cart">
                                </div>
                            </div>
                            <div class="mt-3 col-md-5 col-lg-4">
                                <div class="box d-flex flex-column align-items-center">
                                    <img src="assets/pants.png" alt="Item 1" class="center-block" onclick="window.location='product.html'"
                                        style="cursor:pointer;">
                                    <h5 onclick="window.location='product.html'" style="cursor:pointer;">Men's Sprag
                                        5-pocket Pants</h5>
                                    <span>32,00 €</span>
                                    <input type="button" class="AddToCart" value="Add to Cart">
                                </div>
                            </div>
                        </div>
                    </div>
            </li>
        </ul>
    </div>
</main>

  @endsection