<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Address extends Model
{
    protected $table = 'address';
    
    
     /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'id', 'id_user', 'id_city', 'street', 'zipCode', 'type_address'
    ];


    /**
     * The users that belong to the role.
     */
    public function users()
    {
        return $this->belongsToMany('App\User', 'id_user');
    }


    public function cities(){
        return $this->hasOne('App\City', 'id_city');
    }
}
