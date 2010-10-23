module Ipizza
  class AuthenticationResponse < Ipizza::Response
    
    INFO_MATCHER = /^ISIK:(\d){11};NIMI:(.*)/i
    
    def success?
      return ['3002'].include?(@params['VK_SERVICE'])
    end
    
    def valid?
      return @valid
    end

    def authentication_info
      @params['VK_INFO']
    end
    
    def info_social_security_id
      INFO_MATCHER.match(@params['VK_INFO'])[0] if @params['VK_INFO']
    end
    
    def info_name
      INFO_MATCHER.match(@params['VK_INFO'])[1] if @params['VK_INFO']
    end
  end
end