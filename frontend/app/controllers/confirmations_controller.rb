class ConfirmationsController < StoreController
  def index
    Spree::Config.address_requires_state = false
    @order = current_order
  end

  def create
    @order = current_order
    country = Spree::Country.find_by(iso: 'TN')
    payment_method = Spree::PaymentMethod.find_by(name: 'Cash on Delivery')
    Rails.logger.debug { "Order state at start: #{@order.state}" }

    @order.update(
      email:"user@example.com",
      customer_metadata: {
        first_name: params[:first_name],
        last_name: params[:last_name],
        phone: params[:phone],
        address: params[:address]
      },
      ship_address_attributes: {
        name: "#{params[:first_name]} #{params[:last_name]}",
        zipcode: '0000',
        state_name: 'Tunis',
        city:"Tunis",
        address1: params[:address],
        country_id: country&.id,
        phone: params[:phone]
      },
      bill_address_attributes: {
      name: "#{params[:first_name]} #{params[:last_name]}",
      phone: params[:phone],
      zipcode: '0000',
      city: 'Tunis',
      address1: params[:address],
      country_id: country&.id
    })
    @order.payments.create!(
      payment_method: payment_method,
      amount:  @order.total
    )

    @order.next!
    @order.next!
    payment = @order.payments.last
    payment.complete!
    @order.next!
    @order.complete!
  
    redirect_to root_path, notice:'Commande effectuee avec succès'

  rescue StateMachines::InvalidTransition => e
    Rails.logger.debug { "Failed at state: #{@order.state} — #{e.message}" }
    redirect_to root_path, alert: "Erreur: #{e.message}"
  end
end
