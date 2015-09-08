# Outline

1. Why should a password be secure? What does is mean to encrypt a password?
2. How does BCrypt work? Really broad strokes: it takes the password, creates a salt and maps that salt to the orig. password using a hash. Then, we you log in and validate a user, it will compare the password they submit, located in params, to the salt that it stored
3. AR's has_secure_password: how does it work? What steps will you go through to implement secure passwords when setting up user auth?

# Securing Passwords

## Objectives

1. Learn about bcrypt, a gem that works to encrypt passwords
2. Learn about Active Record's `has_secure_password` method
3. Sign up and in a user with a secure, encrypted password. 

## Password Encryption with BCrypt

## Active Record's `has_secure_password`

## Instructions