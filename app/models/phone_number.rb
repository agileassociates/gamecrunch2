class PhoneNumber < ActiveRecord::Base
  def generate_pin
    self.pin = rand(0000..9999).to_s.rjust(4, "0")
    save
  end
  def twilio_client
    client = Twilio::REST::Client.new 'ACc37abcdd6d04384260291eb1f7075584', '8ef5aec33725886af6b1f9981bf86c0e'
  end
  def send_pin
    twilio_client.messages.create(
        to: phone_number,
        from: '14159172576',
        body: "Your PIN is #{pin}" )
  end
  def verify(entered_pin)
    update(verified: true) if self.pin == entered_pin
  end
end
