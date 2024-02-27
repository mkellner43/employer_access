class ChatChannel < ApplicationCable::Channel
  def subscribed
    # stream_from 'chat_channel'
    stream_from "chat"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def get_user_data
    puts "Gets here"
    data = {
      id: current_user.id,
      email: current_user.email,
      username: current_user.email.split('@')[0],
    }
    ActionCable.server.broadcast 'chat_channel', data
  end
end
