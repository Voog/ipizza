module Ipizza
  module Provider

    class << self
      def get(provider_name)
        case provider_name.to_s.downcase
        when 'swedbank', 'hp'
          Ipizza::Provider::Swedbank.new
        when 'eyp', 'seb'
          Ipizza::Provider::Seb.new
        when 'sampo', 'sampopank'
          Ipizza::Provider::Sampo.new
        when 'nordea'
          Ipizza::Provider::Nordea.new
        end
      end
    end
  end
end
