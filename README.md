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

## Password Encryption with BCrypt

BCrypt works by storing a `password_digest` in our database. A password digest is made up of an encrypted version of the user's password, 

## ActiveRecord's `has_secure_password`



## Resources

[How NOT to Store Passwords!](https://www.youtube.com/watch?v=8ZtInClXe1Q) - Computerphile on Youtube