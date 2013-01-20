require 'ipizza/config'
require 'ipizza/util'
require 'ipizza/payment'
require 'ipizza/request'
require 'ipizza/response'
require 'ipizza/payment_request'
require 'ipizza/payment_response'
require 'ipizza/authentication_request'
require 'ipizza/authentication_response'
require 'ipizza/provider'
require 'ipizza/provider/swedbank'
require 'ipizza/provider/seb'
require 'ipizza/provider/sampo'
require 'ipizza/provider/nordea'

if defined?(Rails)
  require 'ipizza/rails'
end
