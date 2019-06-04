<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Categories;
class HomepageController extends Controller
{
    

    public function show(){
        return view('pages.homepage', ['categories' => Categories::all()]);
    }
}
