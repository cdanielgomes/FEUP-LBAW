<?php

namespace App\Http\Controllers;
use App\Product;
use Illuminate\Support\Facades\DB;

use Illuminate\Http\Request;
use App\Categories;

class ProductController extends Controller
{
    public function show($id)
    {

        $product = Product::find($id);

        $reviews = DB::table('review')->where('id_product', $id)->get();
        //dd($reviews);

        //return view('pages.product')->with(['product' => $product, 'reviews'=> $reviews]);
        return view('pages.product', ['categories' => Categories::all()])->with(['product' => $product, 'reviews'=> $reviews]);


    }
}
