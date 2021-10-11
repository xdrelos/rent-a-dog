class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    # Do something later
    html = "<tr>
              <td>#{message.sender.username}</td>
              <td>#{message.content}</td>
            </tr>"
    chat_id = message.uuid
    ActionCable.server.broadcast("message_channel_#{chat_id}", html: html)
  end
end
