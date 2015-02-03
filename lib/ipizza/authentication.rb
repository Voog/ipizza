module Ipizza
  class Authentication
    
    attr_accessor :provider, :user, :message_time, :sender_id, :receiver_id, :user_name, :user_id, :country, :other, :authentication_identifier, :request_identifier
    
    def initialize(attribs = {})
      attribs.each do |key, value|
        if self.respond_to?("#{key.to_s}=".to_sym)
          v = key.to_sym == :message_time && value.is_a?(String) ? Time.parse(value) : value
          self.send("#{key.to_s}=".to_sym, v)
        end
      end
    end
  end
end
