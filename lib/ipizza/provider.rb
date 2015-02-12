module Ipizza
  module Provider

    class << self
      def get(provider_name)
        case provider_name.to_s.downcase
        when 'lhv'
          Ipizza::Provider::Lhv.new
        when 'swedbank', 'hp'
          Ipizza::Provider::Swedbank.new
        when 'eyp', 'seb'
          Ipizza::Provider::Seb.new
        when 'sampo', 'sampopank', 'danske'
          Ipizza::Provider::Sampo.new
        when 'krep', 'krediidipank'
          Ipizza::Provider::Krediidipank.new
        when 'nordea'
          Ipizza::Provider::Nordea.new
        end
      end
    end
  end
end
