@extends('layouts.app', ['categories' => $categories])


@section('styles')

<link href="{{ asset('css/profile.css') }}" rel="stylesheet">
<script src="../js/link.js" defer> </script>
@endsection


@section('content')

<div class="mt-1">
    <nav aria-label="breadcrumb" id="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href={{route('homepage')}}>Homepage</a></li>
            <li class="breadcrumb-item active" aria-current="page">FAQ</li>
        </ol>
    </nav>
</div>

<div class="container">
    <div class="container scroll_nav">
        <div class="row">
            <h1 class="mx-5 col-lg col-md col-sm-12">
                Frequently Asked Questions
            </h1>

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
                            <h5 class="modal-title" id="exampleModalLabel">What is FAQ?</h5>
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
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Got it, thanks!</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<main>
    <div class="section-container">
        <table class="table">
            <div class="mt-3">
                <tbody>
                    <tr data-toggle="collapse" data-target="#faq-1" class="clickable unbold" onclick="boldUnboldLine(this)">
                        <td>
                            <i class="fas fa-circle mr-2"></i>
                            Can I ship my order to someone else?
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" class="collapse-line">
                            <div id="faq-1" class="collapse-div collapse">
                                <div class="product_list container">
                                    <div class="row">
                                        <p class="p-0 col-lg-auto col-md-auto col-sm-auto">Yes, orders can be
                                            shipped
                                            to a different address than the billing address. After you enter your
                                            billing address during checkout, you’ll have the option to enter a new
                                            shipping address.</p>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr data-toggle="collapse" data-target="#faq-2" class="clickable unbold" onclick="boldUnboldLine(this)">
                        <td>
                            <i class="fas fa-circle mr-2"></i>
                            How long will my order take to arrive?
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" class="collapse-line">
                            <div id="faq-2" class="collapse-div collapse">
                                <div class="product_list container">
                                    <div class="row">
                                        <p class="p-0 col-lg-auto col-md-auto col-sm-auto">For an estimate of
                                            shipping
                                            times, please reference the times below:</br></br>
                                            3-Day: 3-4 business days</br></br>
                                            2-Day: 2-3 business days</br></br>
                                            Overnight: 1-2 business days</br></br>

                                            Delivery time includes processing and delivery. Overnight and 2-Day
                                            delivery will ship the same day on orders placed before 3PM.
                                            Overnight and 2-Day delivery is not eligible for P.O. boxes. Signature
                                            may be required for delivery on some orders.</p>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>

                    <tr data-toggle="collapse" data-target="#faq-3" class="clickable unbold" onclick="boldUnboldLine(this)">
                        <td>
                            <i class="fas fa-circle mr-2"></i>
                            How do I know when my order ships?
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" class="collapse-line">
                            <div id="faq-3" class="collapse-div collapse">
                                <div class="product_list container">
                                    <div class="row">
                                        <p class="p-0 col-lg-auto col-md-auto col-sm-auto">When your order ships,
                                            you’ll receive an email confirmation with the tracking number(s) and
                                            estimated delivery date(s).</p>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>

                    <tr data-toggle="collapse" data-target="#faq-4" class="clickable unbold" onclick="boldUnboldLine(this)">
                        <td>
                            <i class="fas fa-circle mr-2"></i>
                            How do I track my order?</td>
                    </tr>
                    <tr>
                        <td colspan="1" class="collapse-line">
                            <div id="faq-4" class="collapse-div collapse">
                                <div class="product_list container">
                                    <div class="row">
                                        <p class="p-0 col-lg-auto col-md-auto col-sm-auto">When an order is
                                            shipped,
                                            we’ll update your account to show the tracking number(s), and send you
                                            an email with the same information. Using the tracking number(s)
                                            provided, you can follow the path of your order from our warehouse to
                                            your destination.</p>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>

                    <tr data-toggle="collapse" data-target="#faq-5" class="clickable unbold" onclick="boldUnboldLine(this)">
                        <td>
                            <i class="fas fa-circle mr-2"></i>
                            What payment methods do you accept?</td>
                    </tr>
                    <tr>
                        <td colspan="1" class="collapse-line">
                            <div id="faq-5" class="collapse-div collapse">
                                <div class="product_list container">
                                    <div class="row">
                                        <p class="p-0 col-lg-auto col-md-auto col-sm-auto">We accept Visa,
                                            MasterCard,
                                            Discover, American Express, debit cards with a Visa or MasterCard logo
                                            and PayPal. </p>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>

                    <tr data-toggle="collapse" data-target="#faq-6" class="clickable unbold" onclick="boldUnboldLine(this)">
                        <td>
                            <i class="fas fa-circle mr-2"></i>
                            Can I cancel my online order?</td>
                    </tr>
                    <tr>
                        <td colspan="1" class="collapse-line">
                            <div id="faq-6" class="collapse-div collapse">
                                <div class="product_list container">
                                    <div class="row">
                                        <p class="p-0 col-lg-auto col-md-auto col-sm-auto">We immediately start to
                                            process your order as soon as it’s placed. There isn’t a delay that
                                            allows us time to cancel or change orders once they’re submitted.</p>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </div>
        </table>
    </div>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</main>
@endsection