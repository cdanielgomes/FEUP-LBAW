<?php

namespace App;

use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Cart;

class User extends Authenticatable
{
    use Notifiable;

    
    // Don't add create and update timestamps in database.
    public $timestamps  = false;


    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'id', 'name', 'username' ,'email', 'password', 'id_cart', 'is_admin', 'is_manager', 'is_premium', 'deleted', 'remember_token'
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token',
    ];

     /**
     * Get the phone record associated with the user.
     */
    public function cart()
    {
        return $this->hasOne('App\Cart');
    }

}