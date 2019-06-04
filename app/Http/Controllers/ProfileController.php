<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\User;
use App\Address;
use App\City;
use App\Country;
use App\Product;
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
        $city = array();
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

        
        return view('pages.profile')->with('data', ['user' => $user, 'addresses' => $addresses, 'favorites' => $prodFaves]);
    }

    public function deleteFav($idUser, $idProduct)
    {
        //this->authorize();

        $deleted = Favorites::remove($idUser, $idProduct);

        if($deleted == 1) return $idProduct;
        else return $deleted;
    }
}
