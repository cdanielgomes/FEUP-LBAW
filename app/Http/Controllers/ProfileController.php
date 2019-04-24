<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\User;
use App\Address;

class ProfileController extends Controller
{
    public function show($id){


        $users = User::find($id);

      //  $address = Address::where('id_user', $id);
      
      $address = Address::where('id_user', 2)->get();
        
      //var_dump($address);
       
      /*foreach($address as &$a){
            $a['city'] = DB::table('city')->where('id', $a['id_city'])->get(); 
            $a['country'] = DB::table('country')->where('id',DB::table('city')->where('id', $a['id_city'])->get('id_country'))->get();
           
        }*/

        //return view('pages.profile', $address);

        return $address;
    }
}
