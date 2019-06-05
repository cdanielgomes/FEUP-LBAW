<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Product;
use App\Cart;

class CartController extends Controller
{
    public function show($id)
    {

        $cart = Cart::find($id);
        $line_item_cart = DB::table('line_item_cart')->where('id_cart', $id)->get()->toArray();
        $line_item = DB::table('line_item')->where('id', $line_item_cart->id_line_item)->get()->toArray();
        dd(line_item);

        return view('pages.cart', ['categories' => Categories::all()])->with(['cart' => $cart]);
    }

    public function addToCart($id)
    { 
            $product = new Product();
            $product->productId = $id;
            $product->save();
        
    }
}
