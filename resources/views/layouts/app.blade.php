<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr"
      crossorigin="anonymous">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
      crossorigin="anonymous">
  
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
      crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
      crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
      crossorigin="anonymous"></script>
      <link href="https://fonts.googleapis.com/css?family=Open+Sans|Quicksand" rel="stylesheet">
    
      <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'aurora') }}</title>

    <!-- Styles -->
    <link href="{{ asset('css/style.css') }}" rel="stylesheet">
    <link href="{{ asset('css/header.css') }}" rel="stylesheet">
 

    @yield('styles')

    <!-- Scripts -->
    <script src="{{ asset('js/app.js') }}" defer></script>

  {{ csrf_field() }}

</head>
<body>

        <header class="header_area">
                <div class="main_menu">
                  <nav class="navbar navbar-expand-md navbar-light">
                    <div class="container pl-0">
                      <a class="navbar-brand logo_h d-flex align-items-center" href="{{ route('homepage') }}">
                        <img class="float-left mr-3" src="{{asset('imgs/logo.png')}}" alt="img">
                        <h1> {{ config('app.name', 'aurora') }}</h1>
                      </a>
                      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                        aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <i class="fas fa-bars"></i>
                      </button>
                      <div class="collapse navbar-collapse offset" id="navbarSupportedContent">
                        <ul class="nav navbar-nav menu_nav px-5">
                          <li class="nav-item submenu dropdown">
                            <a href="categories.html" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button"
                              aria-haspopup="true" aria-expanded="false">Clothing</a>
                            <ul class="dropdown-menu float-left">
                              <h3 class="dropdown-header">Men</h3>
                              <li class="nav-item"><a class="nav-link" href="categories.html">Tops</a></li>
                              <li class="nav-item"><a class="nav-link" href="categories.html">Bottoms</a></li>
                              <li class="nav-item"><a class="nav-link" href="categories.html">Shoes</a></li>
                              <li class="nav-item"><a class="nav-link" href="categories.html">Accesories</a></li>
                              <li class="nav-item"><a class="nav-link" href="categories.html">Shop All</a></li>
                              <h3 class="dropdown-header">Women</h3>
                              <li class="nav-item"><a class="nav-link" href="categories.html">Tops</a></li>
                              <li class="nav-item"><a class="nav-link" href="categories.html">Bottoms</a></li>
                              <li class="nav-item"><a class="nav-link" href="categories.html">Shoes</a></li>
                              <li class="nav-item"><a class="nav-link" href="categories.html">Accesories</a></li>
                              <li class="nav-item"><a class="nav-link" href="categories.html">Shop All</a></li>
                            </ul>
                          </li>
                          <li class="nav-item submenu dropdown">
                            <a href="categories.html" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button"
                              aria-haspopup="true" aria-expanded="false">House-Decor</a>
                            <ul class="dropdown-menu">
                              <li class="nav-item"><a class="nav-link" href="categories.html">Bedroom</a></li>
                              <li class="nav-item"><a class="nav-link" href="categories.html">Kitchen</a></li>
                              <li class="nav-item"><a class="nav-link" href="categories.html">Living Room</a></li>
                              <li class="nav-item"><a class="nav-link" href="categories.html">Outdoor</a></li>
                            </ul>
                          </li>
                          <li class="nav-item submenu dropdown">
                            <a href="categories.html" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button"
                              aria-haspopup="true" aria-expanded="false">Activities</a>
                            <ul class="dropdown-menu">
                              <li class="nav-item"><a class="nav-link" href="categories.html">Climbing</a></li>
                              <li class="nav-item"><a class="nav-link" href="categories.html">Hiking</a></li>
                              <li class="nav-item"><a class="nav-link" href="categories.html">Running</a></li>
                              <li class="nav-item"><a class="nav-link" href="categories.html">Fishing</a></li>
                              <li class="nav-item"><a class="nav-link" href="categories.html">Hunting</a></li>
                            </ul>
                          </li>
                        </ul>
            
                        <ul class="nav-shop navbar-nav menu_nav pl-2">
                          <li class="nav-item">
                            <form class="form-inline md-form form-lg">
                              <input class="form-control form-control-md mr-3 w-75" type="text" placeholder="Search" aria-label="Search">
                              <i class="fas fa-search" aria-hidden="true"></i>
                            </form>
                          </li>
                          <li class="nav-item">
                            <a class="nav-link" href="/cart">
                              <h5><i class="fas fa-shopping-cart"></i> </h5>
                            </a>
                          </li>
                          @guest
                          <li class="nav-item"><a class="nav-link" href="{{ route('login') }}">Login</a></li>
                          <li class="nav-item"><a class="nav-link" href="{{ route('register') }}">Register</a></li>
                      @else
                          <li class="nav-item">
                          <a href="{{route('profile', ['id' => Auth::user()->id ])}}" class="nav-link" role="button">
                              
     
                            <i class="fas fa-user pt-1"></i>
                              </a>
                            </li>

                              <li class="nav-item pt-2 pl-2">
                        
                                      <a href="{{ route('logout') }}"
                                          onclick="event.preventDefault();
                                                   document.getElementById('logout-form').submit();">
                                          Logout
                                      </a>

                                      <form id="logout-form" action="{{ route('logout') }}" method="POST" style="display: none;">
                                          {{ csrf_field() }}
                                      </form>
                                 
                                </li>
                      @endguest
                        </ul>
                      </div>
                    </div>
                  </nav>
                </div>
              </header>

        @yield('content')

    <footer class="footer pt-2 mt-5">
            <div class="container">
              <div class="row text-center">
                <div class="col">
                  <h5 class="header">Information</h5>
                  <ul class="list-group links">
                    <li class="list-group-item"> <span><a href="{{route('about')}}">About Us</a> </span></li>
                  </ul>
                </div>
                <div class="col">
                  <h5 class="header">Services</h5>
                  <ul class="list-group links">
                    <li class="list-group-item"> <span></i> <a href={{route('faq')}}> FAQ </a></span></li>
                  </ul>
                </div>
              </div>
              <div class="row ">
                <div class="col">
                </div>
                <div class="col">
                  <i class="far fa-copyright"></i> <span>copyrigth 2019 aurora. All rigths reserved </span> <br>
                </div>
                <div class="col text-center">
                </div>
              </div>
            </div>
          </footer>
</body>
</html>
