class ChargesController < ApplicationController

def create
  customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    customer: customer.id,
    amount: Amount.default,
    description: "Premium Membership - #{current_user.email}",
    currency: 'usd'
  )

  flash[:notice] = "Thanks for all the money, #{current_user.email}! Enjoy the service."
  redirect_to user_path(current_user) # or wherever

  rescue Stripe::CardError => e
    flash.now[:alert] = e.message
    redirect_to new_charge_path
  end

  def new
    @amount = 15_00
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership - #{current_user.email}",
      amount: @amount
    }
  end

  def downgrade
    customer = Stripe::Customer.retrieve(current_user.customer_id)

    subscription_id = customer.subscriptions.data.first.id
    customer.subscriptions.retrieve(subscription_id).delete
    current_user.update_attributes(role: 'standard')
    current_user.make_wikis_public
    redirect_to edit_user_registration_path
  end
end
