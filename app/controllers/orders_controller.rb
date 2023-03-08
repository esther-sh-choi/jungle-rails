class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
  end

  def create
    charge = perform_stripe_charge
    order  = create_order(charge)

    if order.valid?
      empty_cart!
      redirect_to order, notice: 'Your Order has been placed.'
    else
      redirect_to cart_path, flash: { error: order.errors.full_messages.first }
    end

  rescue Stripe::CardError => e
    redirect_to cart_path, flash: { error: e.message }
  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  def perform_stripe_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_subtotal_cents,
      description: "Khurram Virani's Jungle Order",
      currency:    'cad'
    )
  end

  def create_order(stripe_charge)
    order = Order.new(
      email: params[:stripeEmail],
      total_cents: cart_subtotal_cents,
      stripe_charge_id: stripe_charge.id, # returned by stripe
    )

    enhanced_cart.each do |entry|
      product = entry[:product]
      puts "here", product
      quantity = entry[:quantity]
      order.line_items.new(
        product: product,
        quantity: quantity,
        item_price: product.price,
        total_price: product.price * quantity
      )
    end
    order.save!
    order
  end

end

#<ActiveRecord::Associations::CollectionProxy [#<LineItem id: 1, order_id: 1, product_id: 3, quantity: 1, item_price_cents: 3449, total_price_cents: 3449, created_at: "2023-03-08 02:54:45.930205000 +0000", updated_at: "2023-03-08 02:54:45.930205000 +0000">, #<LineItem id: 2, order_id: 1, product_id: 8, quantity: 1, item_price_cents: 2499, total_price_cents: 2499, created_at: "2023-03-08 02:54:45.950707000 +0000", updated_at: "2023-03-08 02:54:45.950707000 +0000">, #<LineItem id: 3, order_id: 1, product_id: 12, quantity: 1, item_price_cents: 7999, total_price_cents: 7999, created_at: "2023-03-08 02:54:45.955339000 +0000", updated_at: "2023-03-08 02:54:45.955339000 +0000">]>

#   <div>
# <p><%= @order.line_items[0].name %></p>
# <p><%= @order.line_items[0].description %></p>
# <p><%= @order.line_items[0].name %></p>
# </div>

#<Product id: 3, name: "Lion Grapevine", description: "The Lion Grapevine is an uncommon, modest plant an...", image: "plante_3.jpg", price_cents: 3449, quantity: 4, created_at: "2023-03-07 07:27:53.994297000 +0000", updated_at: "2023-03-07 07:27:53.994297000 +0000", category_id: 1>
