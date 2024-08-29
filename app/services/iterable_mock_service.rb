# frozen_string_literal: true
require 'webmock'

class IterableMockService
  include WebMock::API

  def initialize(event, user, send_mail)
    @user = user
    @event = event
    @send_mail = send_mail
  end

  def track_event 
    create_event

    send_email if @send_email
  end

  private

  def create_event
    stub_event_api
    response = HTTParty.post(
      "https://api.iterable.com/api/events/track",
      body: {
        user: @user,
        name: @event.name
      }.to_json,
      headers: {
        'Content-Type' => 'application/json'
      }
    )

    response.body
  end

  def send_email
    stub_email_api
    response = HTTParty.post(
      "https://api.iterable.com/api/email/target",
      body: {
        "eventId": @event.id,
        "recipientEmail": @user.email,
        "recipientUserId": @user.id
      }.to_json,
      headers: {
        'Content-Type' => 'application/json'
      }
    )

    response.body
  end

  def stub_event_api
    WebMock.stub_request(:post, "https://api.iterable.com/api/events/track")
    .with(
      body: {
        user: @user,
        name: @event.name
      }.to_json,
      headers: {
        'Content-Type' => 'application/json'
      }
    )
    .to_return(status: 200, body: event_response_body.to_json, headers: {})
  end

  def stub_email_api
    WebMock.stub_request(:post, "https://api.iterable.com/api/email/target")
    .with(
      body: {
        "eventId": @event.id,
        "recipientEmail": @user.email,
        "recipientUserId": @user.id
      }.to_json,
      headers: {
        'Content-Type' => 'application/json'
      }
    )
    .to_return(status: 200, body: email_send_response.to_json, headers: {})
  end

  def event_response_body
    {
      "msg": "Event with id: #{@event.id} tracked.",
      "code": "Success",
      "params": {
        "id": @event.id
      }
    }
  end

  def email_send_response
    {
      "msg": "Email sent successfully.",
      "code": "Success",
      "params": {}
    }
  end
end
