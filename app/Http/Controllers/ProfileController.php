<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\User;
use App\Address;
use App\City;
use App\Country;
use Illuminate\Support\Facades\Auth;
class ProfileController extends Controller
{
    public function show($id){

        $user = User::find($id);

        
        
        $address = $user->addresses()->get();
        $addresses =$address->toArray(); 
       
        $city = array();
        foreach ($addresses as &$value) {
        $array = City::find($value['id_city'])->get()->toArray()[0];
            $value['city'] = $array['name'];
            $value['country'] = Country::find($array['id_country'])->get()->toArray()[0]['name'];
        }

        $country = 2;

        
        //$country = $city->countries();
      /*foreach($address as &$a){
            $a['city'] = DB::table('city')->where('id', $a['id_city'])->get(); 
            $a['country'] = DB::table('country')->where('id',DB::table('city')->where('id', $a['id_city'])->get('id_country'))->get();
           
        }*/

       return view('pages.profile')->with('data', ['user' => $user, 'addresses' => $addresses]);

       
    }

}
