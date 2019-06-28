require_relative '../src/MessageHistory'

module Replica


  def initialize
    @mirrors =Array.new
    @messages_history = MessageHistory.new
  end

  def mirrors
    # Definido solo para testing
    @mirrors
  end

  def Replica.included(mod)
    mod.define_singleton_method(:method_added) do |name|
       return if @added
       @added = true
       original_method = "original_#{name}"
       alias_method original_method, name
       define_method(name) do |*args|
         self.fordward_msg_to_mirrors(name, *args)
         self.record_msg(name,*args)
         self.send(original_method, *args)
       end
       @added = false
     end
  end

  def addMirror(target)
    @mirrors.push(target)
  end

  def deleteMirror(target)
    @mirrors.delete_if {|m| m == target }
  end

  def fordward_msg_to_mirrors(method_name,*args)
    @mirrors.each do |mirror|
      mirror.send(method_name,*args)
    end
  end

  def record_msg(msg,*args)
      @messages_history.add_history_record(msg,*args)
  end

  def messages_history
    @messages_history
  end


end



module Replicable
  def replicable
    include(Replica)
  end
end
