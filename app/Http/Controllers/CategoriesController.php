<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Categories;
use App\Brand;
use App\Size;
use App\Color;


class CategoriesController extends Controller
{
    public function show()
    {


        
        
        return view('pages.categories', ['categories' => Categories::all(), 'brands'=> Brand::all(), 'colors' => Color::all(), 'sizes' => Size::all()]);
    }
}
