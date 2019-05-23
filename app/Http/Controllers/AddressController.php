<?php

namespace App\Http\Controllers;

use App\Address;
use App\User;
use App\City;
use App\Country;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
class AddressController extends Controller
{

    public function _construct(){
        $this->middleware('auth');
    }


    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Request $request, $idUser)
    {

        $address = new Address();
        $address->id = Address::max('id')+1;
        $address->door_number = $request->door_number;
       
        $address->id_user = $idUser;

       /// $this->authorize('create', $address);
            //$city = City::where('name', $request->city)->get();
        $city = City::where('name', $request->city)->get();
        $country = Country::where('name', $request->country)->get();
            

        if(isset($city[0])) {
        
            $address->id_city = $city[0]->id;
            
            if(!isset($country[0])){
               $country = Country::create(['id'=>Country::max('id')+1, 'name'=>$request->country]);
            }

        }else {
            if(isset($country[0])){
               $city = City::create(['id'=>City::max('id')+1, 'id_country'=>$country[0]->id, 'name'=> $request->city]);
           
            }else{
                $country = Country::create(['id'=>Country::max('id') +1, 'name'=>$request->country]);
                $city = City::create(['id'=>City::max('id')+1, 'id_country'=>$country->id, 'name'=> $request->city]);            
            }
        
         $address->id_city = $city->id;
        }

        $address->street = $request->street;
        $address->zipcode = $request->zipCode;

        $address->type_address = 'home';
       // dd($address);

        //$country = Country::where('name', $request->country);
        $address->save();
     
    return array($address, $city->first()->name, $country->first()->name);
    
}

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Address  $address
     * @return \Illuminate\Http\Response
     */
    public function show(Address $address)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Address  $address
     * @return \Illuminate\Http\Response
     */
    public function edit(Address $address)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Address  $address
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Address $address)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Address  $address
     * @return \Illuminate\Http\Response
     */
    public function destroy(Request $request, Address $idAddr)
    {
      //dd($idAddr);
      //$addr = Address::find($idAddr);
      
      $this->authorize('delete', $idAddr);

      $idAddr->delete();

      return $idAddr;
    }
}
