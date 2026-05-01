# frozen_string_literal: true

Devise.secret_key = '766d728b4a1d71327272b3d2d395eae71a08777ca979eb43bbdc09f55f39c466274bf43f921a32a5a963201522cb9a5e799c27cd97be3e1be49bdc48bf418842'
Devise.email_regexp = Spree::Config[:default_email_regexp]
Devise.setup do |config|
  config.parent_controller = 'StoreDeviseController'
  config.mailer = 'UserMailer'
end
