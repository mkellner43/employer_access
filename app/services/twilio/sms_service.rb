module Twilio
  class SmsService
    TWILIO_ACCOUNT_SID = Rails.application.credentials['TWILIO_ACCOUNT_SID']
    TWILIO_AUTH_TOKEN = Rails.application.credentials['TWILIO_AUTH_TOKEN']
    TWILIO_FROM_NUMBER = Rails.application.credentials['TWILIO_FROM_NUMBER']
    TWILIO_TEST_NUMBER = '+18777804236'

    def initialize(body, to_phone_number)
      @body = body
      @to_phone_number = to_phone_number
    end

    def send_sms
      @client = Twilio::REST::Client.new(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)

      message = @client.messages
                       .create(
                         body: message,
                         from: TWILIO_FROM_NUMBER,
                         to: to(@to_phone_number)
                       )

      puts message.sid
    end

    private

    def to(phone_number)
      return TWILIO_TEST_NUMBER if Rails.env.development?

      phone_number
    end
  end
end
