<?php

namespace App\Http\Controllers;
use App\Product;
use Illuminate\Support\Facades\DB;

use Illuminate\Http\Request;
use App\Categories;
use App\User;

class ProductController extends Controller
{
    public function show($id)
    {

        $product = Product::find($id);

        $reviews = DB::table('review')->where('id_product', $id)->get();

        /*
        $users = array();
        foreach($reviews as $review){
           array_push($users, DB::table('user')->where('id', $review['id_user'])->get());
        }   */
       // dd($reviews);
        //dd($product);
        //return view('pages.product')->with(['product' => $product, 'reviews'=> $reviews]);
        return view('pages.product', ['categories' => Categories::all()])->with(['product' => $product, 'reviews'=> $reviews]);


    }
}
