require 'ipizza/helpers/payment_button'

module Ipizza
  class Engine < ::Rails::Engine
    initializer "ipizza.view_helpers" do
      ActionView::Base.send(:include, Helpers::PaymentButton)
    end
  end
end
