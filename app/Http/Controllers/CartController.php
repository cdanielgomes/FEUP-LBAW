<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Product;

class CartController extends Controller
{
    public function show()
    {
        return view('pages.cart');
    }

    public function addToCart($id)
    { 
            $product = new Product();

            $product->productId = $id;

            $product->save();
        
    }
}
