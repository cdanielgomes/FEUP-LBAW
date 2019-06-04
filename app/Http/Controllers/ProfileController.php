<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\User;
use App\Address;
use App\City;
use App\Country;
use App\Product;
use App\Categories;
use App\Favorites;
use Illuminate\Support\Facades\Auth;
use SebastianBergmann\CodeCoverage\Report\Xml\Facade;

class ProfileController extends Controller
{
    public function show($id)
    {

        $user = User::find($id);

        // $this->authorize($user);

        $address = $user->addresses()->get();

        $addresses = $address->toArray();
        foreach ($addresses as &$value) {
            $array = City::where('id', $value['id_city'])->get()->toArray()[0];
            $value['city'] = $array['name'];
            $value['country'] = Country::where('id', $array['id_country'])->get()->toArray()[0]['name'];
        }


        $favs = $user->myFavs()->get();
        $prodFaves = array();

        foreach ($favs as $v) {

            $product = Product::find($v['id_product']);
            array_push($prodFaves, $product);
        }

        $orders = $user->orders()->get();

        $delivered = array();
        $hold = array();

        foreach ($orders as &$order) {

            $lines_order = $order->lines()->get();
            $lines = array();
            foreach ($lines_order as &$line_order) {
                $line = $line_order->line()->first();
                $l = array();

                $product = Product::find($line['id_product'], ['name', 'price']);

                array_push($l, ['productPrice' => $product['price'], 'productName' => $product['name'], 'price' => $line['price'], 'quantity' => $line['quantity']]);
                array_push($lines, $l);
            }
            $order['lines'] = $lines;
            if ($order['state'] == 'Delivered') array_push($delivered, $order);
            else array_push($hold, $order);
        }

       // dd($delivered);
        return view('pages.profile', ['categories' => Categories::all()])->with('data', ['user' => $user, 'addresses' => $addresses, 'favorites' => $prodFaves, 'delivered' => $delivered, 'hold' => $hold]);
    }

    public function deleteFav($idUser, $idProduct)
    {
        //this->authorize();

        $deleted = Favorites::remove($idUser, $idProduct);

        if ($deleted == 1) return $idProduct;
        else return $deleted;
    }
}
