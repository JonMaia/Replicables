require_relative '../src/replicable'

Module.include(Replicable)

class Algo
  replicable

  attr_accessor :numero
  def setear_numero(n)
    @numero = n
  end
end
