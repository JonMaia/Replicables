Module.include(Replicable)
class Algo
  replicable

  attr_accessor :numero
  def setear_numero(n)
    puts "Recibo setar numero con: #{n}" # Solo para debug
    @numero = n
  end
end
