<?php

namespace App\Http\Controllers;
use App\Categories;

use Illuminate\Http\Request;

class AboutController extends Controller
{
    public function about()
    {
        //return view('pages.product', ['categories' => Categories::all()])->with(['product' => $product, 'reviews'=> $reviews]);
        return view('pages.about',['categories' => Categories::all()]);
    }
}

