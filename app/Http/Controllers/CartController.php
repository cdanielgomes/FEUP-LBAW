<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Product;
use App\Cart;
use App\Categories;
use App\Line_item_cart;
use App\Line_item_order;
use App\Line_item;

class CartController extends Controller
{
    public function show($id)
    {
        $line_item = array();
        $cart = Cart::find($id);
        $line_item_cart = Line_item_cart::all()->where('id_cart',$id);
        $all_lines = array();
        foreach($line_item_cart as $p){
           $line_item = $p->line()->get()->toArray();
            $all_lines = array_merge($all_lines, $line_item);
        }

        $t = array();
        $i = 0;
        $total = 0;
        foreach($all_lines as $l){
            $product = Product::find($l['id_product']);
            $name = $product['name'];
            $all_lines[$i]['name'] = $name;
            $all_lines[$i]['single_price'] = $product['price'];
            $total+=$l['price'];
            $i++;
        }

        return view('pages.cart', ['categories' => Categories::all(), 'lines' => $all_lines, 'product' => $t, 'total' => $total]);
    }

    public function addToCart($id)
    {
        $product = new Product();
        $product->productId = $id;
        $product->save();
    }
}
