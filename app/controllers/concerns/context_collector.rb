module ContextCollector
  extend ActiveSupport::Concern
  include Broadcast

  def collect_context
    robot = User.find_by(role: 'robot')
    last_user_message = @conversation.messages.includes(:user).where(user: { role: 'robot' }).last
    automatic_response = case last_user_message&.content
                         when "What is the members ID?"
                           @conversation.messages.create(content: "What is the members date of birth?",
                                                         user_id: robot.id)
                         when "What is the members date of birth?"
                           @conversation.messages.create(content: "What is the members zip code?",
                                                         user_id: robot.id)
                         when "What is the members zip code?"
                           @conversation.update! status: "waiting"
                           update_status
                           @conversation.messages.create(content: "Unable to locate member. Connecting to live agent...",
                                                         user_id: robot.id)
                         else
                           @conversation.messages.create(content: "What is the members ID?",
                                                         user_id: robot.id)
                         end
    update_messages_stream(automatic_response)
  end
end
