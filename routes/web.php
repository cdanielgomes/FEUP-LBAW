<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return redirect('/homepage');
});
Route::get('homepage', 'HomepageController@show')->name('homepage');

Route::get('/about', 'AboutController@about')->name('about');
Route::get('/faq', 'FaqController@show')->name('faq');

Route::get('profile/{id}', 'ProfileController@show');

Route::get('/product', 'ProductController@show')->name('product');
Route::get('/cart', 'CartController@show')->name('cart');

Auth::routes();

Route::delete('api/profile/{id}/address/{idAddr}','ProfileController@deleteAddress');

