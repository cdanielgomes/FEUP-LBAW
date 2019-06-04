<?php

namespace App\Http\Controllers;
use App\Product;

use Illuminate\Http\Request;
use App\Categories;

class ProductController extends Controller
{
    public function show($id)
    {

        $product = Product::find($id);

        //dd($product);

        return view('pages.product', ['categories' => Categories::all()])->with(['product' => $product]);


    }
}
