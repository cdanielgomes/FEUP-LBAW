<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Product;
use App\Cart;
use App\Categories;

class CartController extends Controller
{
    public function show($cart)
    {
        $category = urldecode($cart);

        foreach ($cart as $c) {

            $cart = $c->product()->get()->toArray();
       
        }

        return view('pages.cart', ['categories' => Categories::all()]);
    }

    public function addToCart($id)
    { 
            $product = new Product();
            $product->productId = $id;
            $product->save();
        
    }
}
