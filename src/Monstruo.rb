class Monstruo

  replicable
  attr_accessor :nombre,:energia,:motivacion

  def initialize(energia=100,motivacion=0)
    @energia = energia
    @motivacion = motivacion
  end

  def entrarEn(puerta)
  end

  def asustarA(unNinio)
  end

  def cobrarSueldo(unSueldo)
  end

  def entrenar
  end

  def dormir(unasHoras,unaCama)
  end

  def entrarYAsustar(unaPurta)
    unaPurta.entroMonstruo(self)
  end

  def consumirEnergia(unaCantidad)
    @energia -= unaCantidad
  end

  def motivar(unaCantidad)
    @motivacion += unaCantidad
  end
end
