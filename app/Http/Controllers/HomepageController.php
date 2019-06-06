<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Categories;
use App\Product;

class HomepageController extends Controller
{
    

    public function show(){

        // Get featured prodcuts
        $products = Product::all()->where('score', 5)->toArray();

        shuffle($products);
        $randomProducts = array_rand($products, 3);

        $featuredProducts = array();

        foreach ($randomProducts as $product) {
            array_push($featuredProducts, $products[$product]);
        }
        
        return view('pages.homepage', ['categories' => Categories::all(), 'featuredProducts' => $featuredProducts]);
    }
}
