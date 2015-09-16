# Outline

1. Why should a password be secure? What does is mean to encrypt a password?
2. How does BCrypt work? Really broad strokes: it takes the password, creates a salt and maps that salt to the orig. password using a hash. Then, we you log in and validate a user, it will compare the password they submit, located in params, to the salt that it stored
3. AR's has_secure_password: how does it work? What steps will you go through to implement secure passwords when setting up user auth?

# Securing Passwords

## Objectives

1. Learn about bcrypt, a gem that works to encrypt passwords
2. Learn about Active Record's `has_secure_password` method
3. Sign up and in a user with a secure, encrypted password. 

## Overview

Securing users data is one of the most important jobs of a web developer. Despite frequent warnings against it, many people use the same username and password combination for many different websites. This means that, in general, people will use the same password for our applications that they do for their bank. 

Because of this, we never want to store our users passwords in plain text in our database. Instead, we store and encrypted version of the user's password in our database. We'll use an open-source gem, `bcrypt`, to implement this strategy. This is much more secure than anything we would build out ourselves. 

## Starter Code

We've got a basic Sinatra MVC Sinatra application. In our `application_controller` we have two helper methods defined: `logged_in?` returns true or false based on the presence of a `session[:user_id]` and `current_user` returns the instance of the logged in user, based on the `session[:user_id]`. We have four actions defined: `get "/" do` renders an `index.erb` file with links to signup or login. `get '/signup'` renders a form to create a new user, and `get '/login'` renders a form for logging in. 
## Password Encryption with BCrypt

BCrypt works by storing a `password_digest` in our database. A password digest is made up of an encrypted version of the user's password, as well as a random string of characters. That way, two users with the password of "123456" will have different `password_digest` values. 

Essentially, once a password is encrypted using the salted hash, there is no way for anyone to de-encrypt it. This method requires that hackers use a "brute force" approach to gain access to someone's account - still possible, but much more difficult. 

### Implementing BCrypt
First, let's create a migration for our users table using `rake db:create_migration NAME=create_users`. We'll have two columns: one for `username` and one for `password_digest`. 

```ruby
class CreateUsers < ActiveRecord::Migration
  def up
  	create_table :users do |t|
  		t.string :username
  		t.string :password_digest
  	end
  end

  def down
  	drop_table :users
  end
end
```

Run this migration using `rake db:migrate`. Awesome job!


### ActiveRecord's `has_secure_password`

Next, let's update our user model so that it includes the macro `has_secure_password`. This ActiveRecord macro gives us access to a few new methods. It works in conjunction with bcrypt and gives us the ability to update a password and authenticate a user. 


```ruby
class User < ActiveRecord::Base

	has_secure_password
	
end

```

Next, let's handle signing up. In our `post '/signup'` action, let's make a new instance of our user class with a username and password from params. 

```ruby
	post "/signup" do
		user = User.new(:username => params[:username], :password => params[:password])
	end
```
Because we our user `has_secure_password`, we won't be able to save this to the database unless our user filled out the password field. Calling `user.save` will return false if the user can't be persisted. Let's update this route so that we redirect to `'/login'` if the user is saved, or `'/failure'` if the user can't be saved. 

```ruby
	post "/signup" do
		user = User.new(:username => params[:username], :password => params[:password])
		if user.save
			redirect "/login"
		else
			redirect "/failure"
		end
	end
```

Awesome! Test this feature out in your browser. Leaving the password field blank should land you at the "failure" page, while creating a valid user should take you to login. Create at least one valid user, then let's build out our login action. In `post '/login'`, let's find the user by username.

```ruby
	post "/login" do
		user = User.find_by(:username => params[:username])
	end
```

Next, we need to check two conditions: first, did we find a user with that username? This can be written as `user != nil`, or simply `user`. 

```ruby
	post "/login" do
		user = User.find_by(:username => params[:username])
		if user
			redirect "/success"
		else
			redirect "/failure"
		end
	end
```

We also need to check if that user's password matches up with our password_digest. We can use a method called `authenticate`. Our `authenticate` takes a string as an argument. If the string aligns with the password digest, it will return the user object, otherwise it will return false.

```ruby
	post "/login" do
		user = User.find_by(:username => params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect "/success"
		else
			redirect "failure"
		end
	end
```

Awesome job! We've now built out a basic authentication system for a user without storing a plain-text password in our database.  
## Resources


+ [BCrypt Ruby](https://github.com/codahale/bcrypt-ruby)
+ [How NOT to Store Passwords!](https://www.youtube.com/watch?v=8ZtInClXe1Q) - Computerphile on Youtube