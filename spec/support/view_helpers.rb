require 'action_view'
require 'nokogiri'

module ViewHelpers
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::UrlHelper

  attr_accessor :output_buffer
  def protect_against_forgery?; false; end
end
