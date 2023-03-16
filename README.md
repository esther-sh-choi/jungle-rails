# Jungle

The purpose of this project was to add additional features, fix bugs, and add testing to an exisitng mini e-commerce application built with Rails 6.1.

This is to simulate a job where I will be required to add on to, fix, and test and exisiting application. Even when the code base and language is not familiar.

# Features Added

## 1. Sold Out Badge

- When product quantity is 0, a sold out badge is displayed on the sold out item on the project list page.

## 2. Admin Categories

- Admin users can list and create new category of plants to sell.
- Admins can add new products to sell using the new category created.
- New category get displayed on the navbar automatically.

## 3. User Authentication

- Allow visitor to access registration/login page from anywhere on the website through the navbar.
- Visitors can sign up with email, password, and name.
- Visitors can sign in using email and password.
- When logged in, their name will be displayed on the navbar and the `login` and `signup` buttons will be switched to `logout` button.

## 4. Order Detail Page

- Order page displays details about the image, name, description, quantities, and total price of each item.
- Displays the email of the purchaser.
- Displays total price of all items.

## 5. Add Admin Security

- Only users that login via HTTP auth login/password can gain access to Admin functionality.

## 6. Checking Out with Empty Cart

- When cart is empty, stripe checkout button and table that displays product content is not shown.
- Instead, a friendly message and a link to Home page is shown.

## 7. Add Automated Tests

- Rspec and Cypress was used to implement unit test and end-to-end test

## Setup

1. Run `bundle install` to install dependencies
2. Create `config/database.yml` by copying `config/database.example.yml`
3. Create `config/secrets.yml` by copying `config/secrets.example.yml`
4. Run `bin/rails db:reset` to create, load and seed db
5. Create .env file based on .env.example
6. Sign up for a Stripe account
7. Put Stripe (test) keys into appropriate .env vars
8. Run `bin/rails s -b 0.0.0.0` to start the server

## Database

If Rails is complaining about authentication to the database, uncomment the user and password fields from `config/database.yml` in the development and test sections, and replace if necessary the user and password `development` to an existing database user.

## Stripe Testing

Use Credit Card # 4111 1111 1111 1111 for testing success scenarios.

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

- Rails 6.1 [Rails Guide](http://guides.rubyonrails.org/v6.1/)
- Bootstrap 5
- PostgreSQL 9.x
- Stripe
