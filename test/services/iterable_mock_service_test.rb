require 'test_helper'
require 'webmock/minitest'

class IterableMockServiceTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @event = @user.events.create(name: "Test Event")
  end

  test "should track event successfully" do
    service = IterableMockService.new(@event, @user, false)

    WebMock.stub_request(:post, "https://api.iterable.com/api/events/track")
           .to_return(status: 200, body: service.send(:event_response_body).to_json)

    response = service.send(:create_event)
    assert_includes response, "Event with id: #{@event.id} tracked."
  end

  test "should send email successfully" do
    service = IterableMockService.new(@event, @user, true)

    WebMock.stub_request(:post, "https://api.iterable.com/api/email/target")
           .to_return(status: 200, body: service.send(:email_send_response).to_json)

    response = service.send(:send_email)
    assert_includes response, "Email sent successfully."
  end
end
