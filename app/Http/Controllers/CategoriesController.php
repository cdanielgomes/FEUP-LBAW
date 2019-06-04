<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Categories;

class CategoriesController extends Controller
{
    public function show()
    {
        return view('pages.categories', ['categories' => Categories::all()]);
    }
}
