module Ipizza
  class Payment
    
    attr_accessor :provider, :stamp, :amount, :currency, :refnum, :receiver_account, :receiver_name, :sender_account, :sender_name, :message, :transaction_id, :transaction_time
    
    def initialize(attribs = {})
      attribs.each do |key, value|
        if self.respond_to?("#{key.to_s}=".to_sym)
          v = key.to_sym == :transaction_time && value.is_a?(String) ? Time.parse(value) : value
          self.send("#{key.to_s}=".to_sym, v)
        end
      end
    end
  end
end
