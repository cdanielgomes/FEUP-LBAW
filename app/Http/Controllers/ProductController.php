<?php

namespace App\Http\Controllers;

use App\Product;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

use Illuminate\Http\Request;
use App\Categories;
use App\User;
use App\Review;
use App\Color;
use App\Size;

class ProductController extends Controller
{
    public function show($id)
    {

        $product = Product::find($id);

        $reviews = Review::all()->where('id_product', $id);
        $idColors = DB::table('product_color')->where('id_product', $id)->get();
        $idSizes = DB::table('product_size')->where('id_product', $id)->get();


        // Get colors of product
        $colors = array();
        foreach ($idColors as $idColor) {

            $color = Color::find($idColor->id_color);
            array_push($colors, $color);
        }
        $product->colors = $colors;

        // Get sizes of product
        $sizes = array();
        foreach ($idSizes as $idSize) {

            $size = Size::find($idSize->id_size);
            array_push($sizes, $size);
        }
        $product->sizes = $sizes;


        // Get related prodcuts
        $category = DB::table('product_categories')->where('id_product', $id)->get()->toArray();
        $relatedProducts = DB::table('product_categories')->where('id_categories', $category[0]->id_categories)->get()->toArray();

        shuffle($relatedProducts);

        foreach($relatedProducts as $rp) {

            if($rp->id_product == $id){
                $key = array_search($rp, $relatedProducts);
                unset($relatedProducts[$key]);
            }
        }

        $bestThree = array_rand($relatedProducts, 3);
        $threeProducts = array();

        foreach ($bestThree as $relatedID) {
            $pid = $relatedProducts[$relatedID]->id_product;
            array_push($threeProducts, Product::find($pid));
        }

        $product->relatedProducts = $threeProducts;

        foreach ($reviews as $review) {
            $userID = $review->id_user;
            $user = User::find($userID);
            $review->name = $user['name'];
        }

        return view('pages.product', ['categories' => Categories::all(), 'product' => $product, 'reviews' => $reviews]);
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
            'score' => 'required',
            'description' => 'nullable|string|max:255',
        ], $customMessages);
    }

    /**
     * Create a new review instance after a validation.
     *
     * @param  array  $data
     * @return \App\User
     */
    public function submitReview(Request $request, $id_product)
    {

        $review = new Review();
        $review->id = Review::max('id') + 1;
        $review->id_user = $request->id;
        $review->id_product = $id_product;
        $review->title = $request->title;
        $review->description = $request->description;
        $review->score = $request->score;

        $review->save();

        $review->name = User::find($request->id)['name'];

        return array($review);
    }



    public function store(Request $request)
    {

        //$this->authorize();

        $product = new Product;

        $product->name = $request->name;
        $product->price = $request->price;
        $product->description = $request->description;
        $product->store = $request->store;

        $product->save();

        return $product;
    }
}
