module Ipizza
  class AuthenticationResponse < Ipizza::Response
    
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
      /ISIK:([^;.]+)/i.match(@params['VK_INFO'])[1] if @params['VK_INFO']
    end
    
    def info_name
      /NIMI:([^;.]+)/.match(@params['VK_INFO'])[1] if @params['VK_INFO']
    end
  end
end