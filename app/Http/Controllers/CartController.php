<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Product;
use App\Categories;

class CartController extends Controller
{
    public function show()
    {
        return view('pages.cart', ['categories' => Categories::all()]);

    }

    public function addToCart($id)
    { 
            $product = new Product();

            $product->productId = $id;

            $product->save();
        
    }
}
