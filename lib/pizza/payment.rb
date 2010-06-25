module Pizza
  class Payment
    
    attr_accessor :stamp, :amount, :currency, :refnum, :receiver_account, :receiver_name, :sender_account, :sender_name, :message, :transaction_id
    
    def initialize(attribs = {})
      attribs.each do |key, value|
        if self.respond_to?("#{key.to_s}=".to_sym)
          self.send("#{key.to_s}=".to_sym, value)
        end
      end
    end

  end
end