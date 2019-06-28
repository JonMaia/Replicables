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
    # Queda pendiente
  end
end
