require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
    get events_path(email: @user.email)
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should create event and not send email" do
    assert_difference('Event.count') do
      post api_events_create_event_path, params: { send_mail: false }
    end

    assert_redirected_to events_path(email: @user.email)
    assert_equal 'Event created successfully.', flash[:notice]
  end

  test "should create event and send email" do
    assert_difference('Event.count') do
      post api_events_create_event_path, params: { send_mail: true }
    end

    assert_redirected_to events_path(email: @user.email)
    assert_equal 'Event created successfully.', flash[:notice]
  end
end
