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
                @foreach ($employees as $employee)
                <div class="mt-4 col-md-6 col-lg-3">
                    <div class="box d-flex flex-column">
                        <i class="fas fa-trash-alt ml-auto employees"></i>
                        <div class="d-flex flex-row address-header">
                            <i class="fas fa-user-tie pr-1"></i>
                            <h6>{{$employee['name']}}</h6>
                        </div>
                        <h6>Store Manager</h6>
                    </div>
                </div>

                @endforeach
            </div>

        </section>
    </div>

    <div class="modal fade" id="addManagerModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
        aria-hidden="true">
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