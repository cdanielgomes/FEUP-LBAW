<?php

namespace App\Http\Controllers;
use App\Product;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

use Illuminate\Http\Request;
use App\Categories;
use App\User;
use App\Review;

class ProductController extends Controller
{
    public function show($id)
    {

        $product = Product::find($id);

        $reviews = DB::table('review')->where('id_product', $id)->get();
        $idColors = DB::table('product_color')->where('id_product', $id)->get();
        $idSizes = DB::table('product_size')->where('id_product', $id)->get();

        $colors = array();
        foreach($idColors as $idColor) {

            $color = DB::table('color')->where('id', $idColor->id_color)->get();
            array_push($colors, $color);
        }

        $product->colors = $colors;

        $sizes = array();
        foreach($idSizes as $idSize) {

            $size = DB::table('size')->where('id', $idSize->id_size)->get();
            array_push($sizes, $size);
        }

        $product->sizes = $sizes;

        foreach($reviews as $review){
            $id = $review->id_user;
            $userID = $user = User::find($id);
            $review->name = $userID['name'];
        }


        return view('pages.product', ['categories' => Categories::all()])->with(['product' => $product, 'reviews'=> $reviews]);


    }

    /**
     * Get a validator for an incoming registration request.
     *
     * @param  array  $data
     * @return \Illuminate\Contracts\Validation\Validator
     */
    protected function validator(Resquest $request)
    {
        $customMessages = [
            'required' => 'The :attribute field is required.'
        ];

        return Validator::make($request, [
            'title' => 'bail|required|string|max:255',
            'score' => 'required|max:5|min:1',
            'description' => 'string|max:255',
        ], $customMessages);
    }

    /**
     * Create a new review instance after a validation.
     *
     * @param  array  $data
     * @return \App\User
     */
    public function submitReview(Request $request, $id_product){

        $review = new Review();
        $review->id = Review::max('id')+1;
        $review->id_user = $request->id;
        $review->id_product = $id_product;
        $review->title = $request->title;
        $review->description = $request->description;
        $review->score = $request->score; 

        $review->save();

        $review->name = User::find($request->id)['name'];
     
    return array($review);

    }

    
}
