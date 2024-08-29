# frozen_string_literal: true

class OnlineUsersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "online_users_channel"
  end

  def unsubscribed; end
end
