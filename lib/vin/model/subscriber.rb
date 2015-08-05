class Subscriber
  @@ID = 0
  attr_reader :id
  attr_accessor :name, :email, :address, :phone, :facebook, :twitter

  def initialize (name, email, address, phone, facebook="", twitter="")
    @id = @@ID
    @@ID += 1
    @name = name
    @email = email
    @address = address
    @phone = phone
    @facebook = facebook
    @twitter = twitter
  end
end
