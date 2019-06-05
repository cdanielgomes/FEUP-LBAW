<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css"
        integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
    <link rel="stylesheet" href="style/header.css">
    <link rel="stylesheet" href="style/profile.css">
    <link rel="stylesheet" href="style/style.css">
    <link rel="icon" type="image/png" href="assets/logo.png" sizes="32x32" />
    <link href="https://fonts.googleapis.com/css?family=Quicksand:400,700" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="link.js" defer> </script>

    <title>Administrator Page</title>
</head>

<body>

    <header class="header_area">
        <div class="main_menu">
            <nav class="navbar navbar-expand-md navbar-light">
                <div class="container pl-0">
                    <a class="navbar-brand logo_h d-flex align-items-center" href="index.html">
                        <img class="float-left mr-3" src="assets/logo.png" alt="">
                        <h1>aurora</h1>
                    </a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse"
                        data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                        aria-expanded="false" aria-label="Toggle navigation">
                        <i class="fas fa-bars"></i>
                    </button>
                    <div class="collapse navbar-collapse offset" id="navbarSupportedContent">
                        <ul class="nav navbar-nav menu_nav px-5">
                            <li class="nav-item submenu dropdown">
                                <a href="categories.html" class="nav-link dropdown-toggle" data-toggle="dropdown"
                                    role="button" aria-haspopup="true" aria-expanded="false">Clothing</a>
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
                                <a href="categories.html" class="nav-link dropdown-toggle" data-toggle="dropdown"
                                    role="button" aria-haspopup="true" aria-expanded="false">House-Decor</a>
                                <ul class="dropdown-menu">
                                    <li class="nav-item"><a class="nav-link" href="categories.html">Bedroom</a></li>
                                    <li class="nav-item"><a class="nav-link" href="categories.html">Kitchen</a></li>
                                    <li class="nav-item"><a class="nav-link" href="categories.html">Living Room</a></li>
                                    <li class="nav-item"><a class="nav-link" href="categories.html">Outdoor</a></li>
                                </ul>
                            </li>
                            <li class="nav-item submenu dropdown">
                                <a href="categories.html" class="nav-link dropdown-toggle" data-toggle="dropdown"
                                    role="button" aria-haspopup="true" aria-expanded="false">Activities</a>
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
                                    <input class="form-control form-control-md mr-3 w-75" type="text"
                                        placeholder="Search" aria-label="Search">
                                    <i class="fas fa-search" aria-hidden="true"></i>
                                </form>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="cart.html">
                                    <h5><i class="fas fa-shopping-cart"></i> </h5>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="login.html">Sign In</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="register.html">Register</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>
    </header>

    <div class="mt-1">
        <nav aria-label="breadcrumb" id="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="index.html">Homepage</a></li>
                <li class="breadcrumb-item active" aria-current="page">Administrator</li>
            </ol>
        </nav>
    </div>

    <div class="container">
        <div class="container scroll_nav">
            <div class="row">
                <h1 class="col-lg col-md col-sm-12">
                    Administrator Area
                </h1>
                <a href="#employees_title" class="col-lg-auto col-md-auto col-sm-6 text-sm-center">
                    <i class="fas fa-arrow-alt-circle-right"></i>
                    Manage Employees
                </a>
                <a href="#employees_title" class="col-lg-auto col-md-auto col-sm-6 text-sm-center">
                    <i class="fas fa-arrow-alt-circle-right"></i>
                    Manage Users
                </a>
                <a href="#reports_title" class="col-lg-auto col-md-auto col-sm-6 text-sm-center">
                    <i class="fas fa-arrow-alt-circle-right"></i>
                    Reports
                </a>
            </div>
        </div>
    </div>

    <main>
        <div class="container">

            <section class="py-5" id="employees-section">

                <div id="employees_title" class="jumptarget">
                    <div class="cards row">
                        <div class="col-md-6 col-xl-6 ml-auto d-flex align-items-left justify-content-left">
                            <div class="box d-flex flex-column last-card">
                                <h2>Manage Employees</h2>
                            </div>
                        </div>
                        <div class="col-md-6 col-xl-6 ml-auto d-flex align-items-center justify-content-end">
                            <div id="addAlterButton" class="box d-flex flex-column last-card" data-toggle="modal"
                                data-target="#addManagerModal">
                                &#10010; Add Employees
                            </div>
                        </div>
                    </div>
                </div>

                <div class="cards row">
                    <div class="mt-4 col-md-6 col-lg-3">
                        <div class="box d-flex flex-column">
                            <i class="fas fa-trash-alt ml-auto"></i>
                            <div class="d-flex flex-row address-header">
                                <i class="fas fa-user-tie pr-1"></i>
                                <h6>Joe Doe</h6>
                            </div>
                            <h6>Store Manager</h6>
                        </div>
                    </div>
                </div>

            </section>
        </div>

        <div class="modal fade" id="addManagerModal" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Add Manager</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form>
                        <div class="modal-body section-container mt-0">
                            <div class="form-group">
                                <label for="review_title">Name</label>
                                <input type="text" class="form-control" placeholder="Employee Name">
                            </div>
                            <div class="form-group">
                                <label for="review_title">Role</label>
                                <input type="text" class="form-control" placeholder="Employee Role">
                            </div>
                            <div class="form-group">
                                <label for="review_title">Password</label>
                                <input type="password" class="form-control" placeholder="Your password" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="button" data-dismiss="modal" value="Close"></input>
                            <input type="submit" class="black-button" value="Save"></input>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="container">

            <section class="py-5" id="profile-section">

                <div id="employees_title" class="jumptarget">
                    <h2>Manage Users</h2>
                </div>

                <div class="cards row">
                    <div class="mt-4 col-md-6 col-lg-3">
                        <div class="box d-flex flex-column">
                            <i class="fas fa-trash-alt ml-auto"></i>
                            <div class="d-flex flex-row address-header">
                                <i class="fas fa-user pr-1"></i>
                                <h6>Jane Doe</h6>
                            </div>
                            <h6>Regular User</h6>
                        </div>
                    </div>
                    <div class="mt-4 col-md-6 col-lg-3">
                        <div class="box d-flex flex-column">
                            <i class="fas fa-trash-alt ml-auto"></i>
                            <div class="d-flex flex-row address-header">
                                <i class="fas fa-user pr-1"></i>
                                <h6>João Carlos Lopes</h6>
                            </div>
                            <h6>Premium User</h6>
                        </div>
                    </div>
                </div>

            </section>
        </div>

        <div class="container">
            <section class="py-5">

                <div id="reports_title" class="jumptarget pb-3">
                    <h2>Reports</h2>
                </div>

                <div class="section-container">
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Date</th>
                                <th scope="col">Type</th>
                                <th scope="col">Username</th>
                                <th scope="col">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr data-toggle="collapse" data-target="#report-1" class="clickable unbold"
                                onclick="boldUnboldLine(this)">
                                <td> <i class="fas fa-circle mr-2"></i>12/03/19</td>
                                <td>Review</td>
                                <td>janedoe</td>
                                <td>
                                    <i class="fas fa-exclamation-triangle p-1"></i>
                                    <i class="fas fa-check-circle p-1"></i>
                                    <i class="fas fa-user-lock p-1"></i>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" class="collapse-line">
                                    <div id="report-1" class="collapse-div collapse">
                                        <div class="information_list container">
                                            <div class="row" onclick="window.location='product.html#review-1'"
                                                style="cursor:pointer;">
                                                <h6>Zombie ipsum reversus ab viral inferno, nam rick grimes malum
                                                    cerebro. De carne lumbering animata corpora quaeritis. Summus
                                                    brains sit​​, morbo vel maleficia? De apocalypsi gorger omero
                                                    undead survivor dictum mauris. Hi mindless mortuis soulless
                                                    creaturas, imo evil stalking monstra adventus resi dentevil vultus
                                                    comedat cerebella viventium.</h6>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr data-toggle="collapse" data-target="#report-2" class="clickable unbold"
                                onclick="boldUnboldLine(this)">
                                <td> <i class="fas fa-circle mr-2"></i>25/02/19</td>
                                <td>Review</td>
                                <td>jonedoe</td>
                                <td>
                                    <i class="fas fa-exclamation-triangle p-1"></i>
                                    <i class="fas fa-check-circle p-1"></i>
                                    <i class="fas fa-user-lock p-1"></i>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" class="collapse-line">
                                    <div id="report-2" class="collapse-div collapse">
                                        <div class="information_list container">
                                            <div class="row" onclick="window.location='product.html#review-2'"
                                                style="cursor:pointer;">
                                                <h6>Lorem ipsum dolor amet mustache knausgaard +1, blue bottle
                                                    waistcoat tbh semiotics artisan synth stumptown gastropub cornhole
                                                    celiac swag. Brunch raclette vexillologist post-ironic glossier
                                                    ennui XOXO mlkshk godard pour-over blog tumblr humblebrag. Blue
                                                    bottle put a bird on it twee prism biodiesel brooklyn. Blue bottle
                                                    ennui tbh succulents.</h6>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>
        </div>
    </main>

    <script>
        $(document).ready(function () {
            $('.fa-exclamation-triangle').popover({
                content: "Warning User",
                trigger: "hover",
                placement: "top"
            });
            $('.fa-check-circle').popover({
                content: "Marks as resolved",
                trigger: "hover",
                placement: "top"
            });
            $('.fa-user-lock').popover({
                content: "Block User",
                trigger: "hover",
                placement: "top"
            });
        });
    </script>

    <footer class="footer pt-2 mt-5">
        <div class="container">
            <div class="row text-center">
                <div class="col">
                    <h5 class="header">Information</h5>
                    <ul class="list-group links">
                        <li class="list-group-item"> <span><a href="about.html">About Us</a> </span></li>
                    </ul>
                </div>
                <div class="col">
                    <h5 class="header">Services</h5>
                    <ul class="list-group links">
                        <li class="list-group-item"> <span></i> <a href="faq.html"> FAQ </a></span></li>
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
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous">
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous">
    </script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous">
    </script>
</body>

</html>