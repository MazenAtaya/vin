require 'json'
class Error
  attr_accessor :code, :message

  def initialize (code, message)
    @code = code
    @message = message
  end

  def to_json (something)
    {'code' => @code, 'message' => @message}.to_json
  end

end
