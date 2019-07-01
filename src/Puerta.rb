class Puerta

  attr_accessor :ninio_asustable

  def initialize(ninio_asustable)
    @ninio_asustable = ninio_asustable
  end

  def entroMonstruo(unMonstruo)
    if @ninio_asustable
      unMonstruo.consumirEnergia(5)
      unMonstruo.motivar(110)
    else
      unMonstruo.consumirEnergia(unMonstruo.energia)
    end
  end

end
