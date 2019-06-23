module Replica

  def initialize
    var_name = "@mirrors"
    self.instance_variable_set(var_name.to_sym,Array.new)
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
      puts "Reenvio mensaje #{method_name.to_s}"
      mirror.send(method_name,*args)
    end
  end

  # Esto no pisa el metodo y no se por que, si anda esto anda el TP
  def self.method_added(name)
  #define_method(:method_added)do |name| # Otra forma de definirlo
    puts "Metodo a agregar #{name.to_s}"
    return if @added
    @added = true
    original_method = "original_#{name}"
    alias_method original_method, name
    define_method(name) do |*args|
      self.fordward_msg_to_mirrors(name, *args)
      self.send(original_method, *args)
    end
    @added = false
  end

end



module Replicable
  def replicable
    include(Replica)
  end
end
