@extends('layouts.app')

@section('styles')
    
<link href="{{ asset('css/login.css') }}" rel="stylesheet">

@endsection


@section('content')

<div class="container mt-5">
		<div class="d-flex justify-content-center vertical-center">
			<div class="card">
				<div class="card-header">
					<h3>Login</h3>
					<div class="d-flex justify-content-end social_icon">
					</div>
				</div>
				<div class="card-body">
                    <form method="POST" action="{{ route('login') }}">
                            {{ csrf_field() }}
                            
						<div class="input-group form-group">
							<div class="input-group-prepend">
								<span class="input-group-text"><i class="fas fa-user"></i></span>
							</div>
							<input type="text" class="form-control" placeholder="username" value="{{ old('email') }}" required autofocus>
                           
                            @if ($errors->has('username'))
                            <span class="help-block">
                                <strong>{{ $errors->first('email') }}</strong>
                            </span>
                        @endif

						</div>
						<div class="input-group form-group">
							<div class="input-group-prepend">
								<span class="input-group-text"><i class="fas fa-key"></i></span>
							</div>
							<input type="password" class="form-control" placeholder="password" name="password" required>
                    
                            @if ($errors->has('password'))
                            <span class="help-block">
                                <strong>{{ $errors->first('password') }}</strong>
                            </span>
                        @endif
                        </div>

						<div class="row align-items-center remember">
                            <label>    
                            <input type="checkbox" name="remember" {{ old('remember') ? 'checked' : '' }}> Remember Me
                        </label>

                        </div>
                        
						<div class="form-group">
							<input type="submit" value="Login" class="btn float-right login_btn">
                        </div>
                        
					</form>
				</div>
				<div class="card-footer">
					<div class="d-flex justify-content-center links">
						Don't have an account?<a href="{{ route('register') }}">Sign Up</a>
					</div>
					<div class="d-flex justify-content-center">
						<a href="#"> Forgot your password?</a>
					</div>
				</div>
			</div>
		</div>
    </div>
    
@endsection
