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

Route::get('/profile', 'ProfileController@show')->name('profile');

Route::get('/product/{id}', 'ProductController@show')->name('product');
Route::get('/cart/{id}', 'CartController@show')->name('cart');
Route::post('api/product/{id}/review', 'ProductController@submitReview');
Route::post('api/product/{id}/addToCart', 'CartController@addToCart');
Route::delete('api/line/{idLine}', 'CartController@destroyLine');


Route::get('/products/{category}/{subcategoty}', 'CategoriesController@show');
Route::get('/categories', 'CategoriesController@show')->name('categories');
Route::get('/search', 'CategoriesController@search_products')->name('search');
Route::post('api/products/{category}/{subcategoty}', 'CategoriesController@show');
Route::post('api/search/{id}/review', 'CategoriesController@search_products');

Auth::routes();

Route::delete('api/address/{idAddr}', 'AddressController@destroy');
Route::post('api/profile/{idUser}/address', 'AddressController@create');
Route::delete('api/profile/{idUser}/products/{idProduct}', 'ProfileController@deleteFav');
Route::post('api/product/add', 'ProductController@store');
Route::put('api/profile', 'ProfileController@update');
Route::delete('profile/delete', 'ProfileController@delete');