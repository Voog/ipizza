class Ipizza::PaymentResponse < Ipizza::Response

  def success?
    return ['1101'].include?(@params['VK_SERVICE'])
  end

  def valid?
    return @valid
  end

  def automatic_message?
    @params['VK_AUTO'] and @params['VK_AUTO'] == 'Y'
  end

  def payment_info
    @payment_info ||= Ipizza::Payment.new(
      :stamp => @params['VK_STAMP'], :amount => @params['VK_AMOUNT'], :currency => @params['VK_CURR'],
      :refnum => @params['VK_REF'], :message => @params['VK_MSG'], :transaction_id => @params['VK_T_NO'],
      :receiver_account => @params['VK_REC_ACC'], :receiver_name => @params['VK_REC_NAME'],
      :sender_account => @params['VK_SND_ACC'], :sender_name => @params['VK_SND_NAME']
    )
  end
end
