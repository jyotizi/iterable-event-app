# frozen_string_literal: true

class ActiveInstructionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "active_instruction_channel"
    return unless current_user&.admin && current_user&.current_instruction

    data = User.online_admins.with_active_instruction
    ActionCable.server.broadcast('active_instruction_channel', data)
  end

  def unsubscribed; end
end
