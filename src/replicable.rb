require_relative '../src/MessageHistory'
require_relative '../src/Branch'

module MetodoCopiableYRegistable

  def method_added(name)
    return if @added
    @added = true
      original_method = "original_#{name}"
      alias_method original_method, name
      if name.to_s != "initialize"
      define_method(name) do |*args|
        self.fordward_msg_to_mirrors(name, *args)
        self.record_msg(name,*args)
        self.send(original_method,*args)
      end
      else
      define_method(name) do |*args|
        self.not_inheritance_initialize
        self.send(original_method,*args)
      end
      end
    @added = false
  end
end


module Replica

  def initialize
    @mirrors = Array.new
    @messages_history = MessageHistory.new
  end

  def not_inheritance_initialize
    @mirrors = Array.new
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

  def branch(branch_name)
    obj = Marshal.load(Marshal.dump(self))
    Branch.new(branch_name,obj)
  end

end


class Module

  def replicable
    include(Replica)
    extend(MetodoCopiableYRegistable)
  end
end
