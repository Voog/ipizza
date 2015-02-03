module Ipizza
  class AuthenticationResponse < Ipizza::Response
    
    def success?
      %w(3012 3013).include?(@params['VK_SERVICE'])
    end
    
    def valid?
      @valid
    end
    
    def info_social_security_id
      authentication_info.user_id
    end
    
    def info_name
      authentication_info.user_name
    end

    def authentication_info
      @authentication_info ||= Ipizza::Authentication.new(
        provider: @params['VK_SND_ID'],
        user: @params['VK_USER'],
        message_time: @params['VK_DATETIME'],
        sender_id: @params['VK_SND_ID'],
        receiver_id: @params['VK_REC_ID'],
        user_name: @params['VK_USER_NAME'],
        user_id: @params['VK_USER_ID'],
        country: @params['VK_COUNTRY'],
        other: @params['VK_OTHER'],
        authentication_identifier: @params['VK_TOKEN'],
        request_identifier: @params['VK_RID'],
        nonce: @params['VK_NONCE']
      )
    end
  end
end
