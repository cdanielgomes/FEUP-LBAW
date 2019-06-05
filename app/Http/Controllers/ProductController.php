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

        foreach($reviews as $review){
            $id = $review->id_user;
            $userID = $user = User::find($id);
            $review->name = $userID['name'];
        }

        return view('pages.product', ['categories' => Categories::all()])->with(['product' => $product, 'reviews'=> $reviews]);


    }

    public function submitReview($id){

        dd('lmao');

    }

    
}
