@extends('layouts.app', ['categories' => $categories])


@section('styles')

<link href="{{ asset('css/categories.css') }}" rel="stylesheet">

@endsection

@section('content')


<div class="mt-1">
    <nav aria-label="breadcrumb" id="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.html">Homepage</a></li>
            <li class="breadcrumb-item"><a href="categories.html">Men</a></li>
            <li class="breadcrumb-item active" aria-current="page">Pants</a></li>
        </ol>
    </nav>
</div>

<main>
    <div class="container">
        <div class="products row align-items-center">
            <div class="col text-right">
                <h1>Pants</h1>
            </div>
            <div class="col text-right"><span>100 Products</span></div>
            <div class="dropdown col w-auto text-center">
                <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Sort By
                </button>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                    <a class="dropdown-item" href="#">Oldest</a>
                    <a class="dropdown-item" href="#">Newest</a>
                    <a class="dropdown-item" href="#">Price</a>
                    <a class="dropdown-item" href="#">Alphabetically</a>

                </div>
            </div>
            <div class="col w-auto text-center">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li class="page-item">
                            <a class="page-link" href="#" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                                <span class="sr-only">Previous</span>
                            </a>
                        </li>
                        <li class="page-item">
                            <a class="page-link" href="#">1</a>
                        </li>
                        <li class="page-item">
                            <a class="page-link" href="#">2</a>
                        </li>
                        <li class="page-item">
                            <a class="page-link" href="#">3</a>
                        </li>
                        <li class="page-item">
                            <a class="page-link" href="#" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                                <span class="sr-only">Next</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
            <div class="row mt-3" id="products">
                <div class="mt-4 col-md-4 col-lg-3">
                    <div class="filters d-flex flex-column">
                        <h5>Filters</h5>
                        <h6>Brand</h6>
                        <div class="form-check">
                            <label class="form-check-label">
                                <input type="checkbox" class="form-check-input">
                                <p>Caterpillar</p>
                            </label>
                        </div>
                        <div class="form-check">
                            <label class="form-check-label">
                                <input type="checkbox" class="form-check-input">
                                <p>Carhartt</p>
                            </label>
                        </div>
                        <div class="form-check">
                            <label class="form-check-label">
                                <input type="checkbox" class="form-check-input">
                                <p>The North Face</p>
                            </label>
                        </div>
                        <div class="form-check">
                            <label class="form-check-label">
                                <input type="checkbox" class="form-check-input">
                                <p>Columbia</p>
                            </label>
                        </div>
                        <h6>Size</h6>
                        <div class="form-check">
                            <label class="form-check-label">
                                <input type="checkbox" class="form-check-input">
                                <p>32</p>
                            </label>
                        </div>
                        <div class="form-check">
                            <label class="form-check-label">
                                <input type="checkbox" class="form-check-input">
                                <p>34</p>
                            </label>
                        </div>
                        <div class="form-check">
                            <label class="form-check-label">
                                <input type="checkbox" class="form-check-input">
                                <p>36</p>
                            </label>
                        </div>
                        <div class="form-check">
                            <label class="form-check-label">
                                <input type="checkbox" class="form-check-input">
                                <p>38</p>
                            </label>
                        </div>
                        <div class="form-check">
                            <label class="form-check-label">
                                <input type="checkbox" class="form-check-input">
                                <p>40</p>
                            </label>
                        </div>
                        <div class="form-check">
                            <label class="form-check-label">
                                <input type="checkbox" class="form-check-input">
                                <p>42</p>
                            </label>
                        </div>
                        <div class="form-check">
                            <label class="form-check-label">
                                <input type="checkbox" class="form-check-input">
                                <p>44</p>
                            </label>
                        </div>
                        <h6>Color</h6>
                        <div class="form-check">
                            <label class="form-check-label">
                                <input type="checkbox" class="form-check-input">
                                <p>Dark Brown</p>
                            </label>
                        </div>
                        <div class="form-check">
                            <label class="form-check-label">
                                <input type="checkbox" class="form-check-input">
                                <p>Black</p>
                            </label>
                        </div>
                        <div class="form-check">
                            <label class="form-check-label">
                                <input type="checkbox" class="form-check-input">
                                <p>Navy</p>
                            </label>
                        </div>
                        <div class="form-check">
                            <label class="form-check-label">
                                <input type="checkbox" class="form-check-input">
                                <p>White</p>
                            </label>
                        </div>
                        <div class="form-check">
                            <label class="form-check-label">
                                <input type="checkbox" class="form-check-input">
                                <p>Red</p>
                            </label>
                        </div>
                        <div class="form-check">
                            <label class="form-check-label">
                                <input type="checkbox" class="form-check-input">
                                <p>Green</p>
                            </label>
                        </div>
                        <h6>Max Price</h6>
                        <div class="getValue d-flex justify-content-left">
                            <input type="range" class="custom-range" id="formControlRange" min=0 max=500>
                            <span class="pl-2">0</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-8 col-lg-9">
                    <div class="row">
                        <div class="mt-3 col-md-5 col-lg-4">
                            <div class="box d-flex flex-column align-items-center">
                                <img src="assets/pants.png" alt="Item 1" class="center-block" onclick="window.location='product.html'" style="cursor:pointer;">
                                <h5 onclick="window.location='product.html'" style="cursor:pointer;">Men's Sprag
                                    5-pocket Pants</h5>
                                <span>32,00 €</span>
                                <input type="button" class="AddToCart" value="Add to Cart">
                            </div>
                        </div>
                        <div class="mt-3 col-md-5 col-lg-4">
                            <div class="box d-flex flex-column align-items-center">
                                <img src="assets/pants.png" alt="Item 1" class="center-block" onclick="window.location='product.html'" style="cursor:pointer;">
                                <h5 onclick="window.location='product.html'" style="cursor:pointer;">Men's Sprag
                                    5-pocket Pants</h5>
                                <span>32,00 €</span>
                                <input type="button" class="AddToCart" value="Add to Cart">
                            </div>
                        </div>
                        <div class="mt-3 col-md-5 col-lg-4">
                            <div class="box d-flex flex-column align-items-center">
                                <img src="assets/pants.png" alt="Item 1" class="center-block" onclick="window.location='product.html'" style="cursor:pointer;">
                                <h5 onclick="window.location='product.html'" style="cursor:pointer;">Men's Sprag
                                    5-pocket Pants</h5>
                                <span>32,00 €</span>
                                <input type="button" class="AddToCart" value="Add to Cart">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="mt-3 col-md-5 col-lg-4">
                            <div class="box d-flex flex-column align-items-center">
                                <img src="assets/pants.png" alt="Item 1" class="center-block" onclick="window.location='product.html'" style="cursor:pointer;">
                                <h5 onclick="window.location='product.html'" style="cursor:pointer;">Men's Sprag
                                    5-pocket Pants</h5>
                                <span>32,00 €</span>
                                <input type="button" class="AddToCart" value="Add to Cart">
                            </div>
                        </div>
                        <div class="mt-3 col-md-5 col-lg-4">
                            <div class="box d-flex flex-column align-items-center">
                                <img src="assets/pants.png" alt="Item 1" class="center-block" onclick="window.location='product.html'" style="cursor:pointer;">
                                <h5 onclick="window.location='product.html'" style="cursor:pointer;">Men's Sprag
                                    5-pocket Pants</h5>
                                <span>32,00 €</span>
                                <input type="button" class="AddToCart" value="Add to Cart">
                            </div>
                        </div>
                        <div class="mt-3 col-md-5 col-lg-4">
                            <div class="box d-flex flex-column align-items-center">
                                <img src="assets/pants.png" alt="Item 1" class="center-block" onclick="window.location='product.html'" style="cursor:pointer;">
                                <h5 onclick="window.location='product.html'" style="cursor:pointer;">Men's Sprag
                                    5-pocket Pants</h5>
                                <span>32,00 €</span>
                                <input type="button" class="AddToCart" value="Add to Cart">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <nav class="mt-4 d-flex justify-content-end" aria-label="Page navigation">
                <ul class="pagination">
                    <li class="page-item">
                        <a class="page-link" href="#" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                            <span class="sr-only">Previous</span>
                        </a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#">1</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#">2</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#">3</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                            <span class="sr-only">Next</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
</main>

  <!-- Modal OnlineHelp -->
  <div class="button_online">
    <p class="text-secondary">
    <button type="button" class="btn" data-toggle="modal" data-target="#exampleModal">
        <div class="container topright text-aling-top">
        <i class="far topright fa-question-circle fa-2x text-top "></i>
        </div>
    </button>
    </p>
</div>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">What's the purpose of this page?</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>When <strong>searching</strong> inside a list of possible options, users are given the <strong>ability to filter roles</strong>.</p>
        <p>Included roles are <strong>Size</strong>, <strong>Brand</strong> or <strong>Color</strong> in order to <strong>give specificity in choice
    of products</strong> by limiting the original amount in the product list. Sorting items through fields regarding time and name is also a complement to a better
interaction between the user and store.</p>
        <p>Adding the products to the cart is an option aswell.</p>
     </div>
      <div class="modal-footer">
        <div class="container">
      <div class="modal-body">
      <span><a href="{{route('faq')}}"> More Questions?  </a></span> </div></div>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Got it, thanks!</button>
      </div>
    </div>
  </div>
</div>
@endsection