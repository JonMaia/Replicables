require_relative '../src/MessageHistory'


module MetodoCopiableYRegistable

  def method_added(name)
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


module Replica

  def initialize
    @mirrors =Array.new(0)
    @messages_history = MessageHistory.new
  end

  def mirrors
    # Definido solo para testing
    @mirrors
  end

  def addMirror(target)
    @mirrors.push(target)
  end

  def deleteMirror(target)
    @mirrors.delete_if {|m| m == target }
  end

  def fordward_msg_to_mirrors(method_name,*args)


    #if @mirrors.length >= 1
      @mirrors.each do |mirror|
        mirror.send(method_name,*args)
      end
    #end
  end

  def record_msg(msg,*args)
      @messages_history.add_history_record(msg,*args)
  end

  def messages_history
    @messages_history
  end
end


class Module
  def replicable
    extend(MetodoCopiableYRegistable)
    include(Replica)
  end
end
