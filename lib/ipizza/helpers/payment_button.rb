module Ipizza
  module Helpers
    module PaymentButton
      def payment_button(payment, provider_name, opts = {})
        submit_value = opts.delete(:value) { provider_name }

        provider = Provider.get(provider_name)
        request = provider.payment_request(payment, 1002, opts)

        form_tag request.service_url, :class => "#{provider_name}_payment" do
          request.request_params.each do |field, value|
            concat hidden_field_tag(field, value)
          end

          concat submit_tag(submit_value)
        end
      end
    end
  end
end
