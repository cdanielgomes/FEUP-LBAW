<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Country extends Model
{
   
    protected $table = 'country';
    
    
    /**
    * The attributes that are mass assignable.
    *
    * @var array
    */
   protected $fillable = [
       'id', 'id_country', 'name'
   ];


   /**
    * The users that belong to the role.
    */
   public function users()
   {
       return $this->belongsToMany('App\User', 'id_user');
   }

   public function cities(){
       return $this->hasOne('App\Country', 'id_city');
   }
    
}
