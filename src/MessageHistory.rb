class MessageHistory

  def initialize
    @msgs_history = []
  end

  def messages_history
    @msgs_history
  end

  def add_history_record(msg,*args)
      @msgs_history.push([msg,args])
  end

  def apply_to(obj)
    @msgs_history.each do |msg_history|
      msg = msg_history[0]
      args = msg_history[1]
      obj.send(msg,*args)
    end
  end

end
