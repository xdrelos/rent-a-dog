class MessagesController < ApplicationController
  skip_after_action :verify_authorized
  before_action :set_message, only: :show

  def new
    @message = Message.new
    @message.receiver = User.find(params[:user_id])
  end

  def create
    @message = Message.new(message_params)
    @message.sender = current_user
    @message.uuid = set_uuid unless params[:message][:uuid]
    if @message.save
      flash[:notice] = "Message sent to #{@message.receiver.username}."
      SendMessageJob.perform_later(@message)
      redirect_to messages_path unless params[:message][:uuid]
    else
      flash[:alert] = "Message not sent."
      render :new
    end
  end

  def index
    @pagy_received, @messages_received = pagy(policy_scope(Message).where(receiver_id: current_user).order('updated_at DESC'), items: 5)
    @pagy_sent, @messages_sent = pagy(policy_scope(Message).where(sender_id: current_user).order('updated_at DESC'), page_param: :page_sent, items: 5)
  end

  def show
    @messages = Message.where('uuid = ?', @message.uuid).order(:created_at)
    @reply = Message.new(uuid: @message.uuid, topic: @message.topic, receiver: @message.receiver == current_user ? @message.sender : @message.receiver, sender: current_user)
  end

  private

  def message_params
    params.require(:message).permit(:receiver_id, :topic, :content, :uuid)
  end

  def set_uuid
    loop do
      @uuid = Digest::UUID.uuid_v4()
      break unless Message.all.exists?(uuid: @uuid)
    end
    @uuid
  end

  def set_message
    @message = Message.find(params[:id])
  end
end
