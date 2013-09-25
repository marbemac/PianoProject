class DonationsController < ApplicationController

  def create
    # Amount in cents
    @amount = params[:donation][:amount].to_i*100

    customer = Stripe::Customer.create(
        :email => params[:donation][:email],
        :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => 'Piano Project Donation',
        :currency    => 'usd'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to get_involved_path
  else
    redirect_to donation_success_path
  end

  def success

  end

end
