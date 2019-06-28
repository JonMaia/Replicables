require 'rspec'
require_relative '../src/Algo'


describe 'replicable' do

  context 'when condition' do
    it 'agrega a una clase el metodo replicable' do
      alguito = Algo.new

      expect(alguito.mirrors) == []
    end

    it 'guarda los copiones a los que reenviara los mensajes' do
      alguito = Algo.new
      otroAlguito = Algo.new

      expect(alguito.mirrors) == []

      alguito.addMirror(otroAlguito)
      expect(alguito.mirrors) == [otroAlguito]
    end

    it 'guarda los copiones a los que reenviara los mensajes' do
      alguito = Algo.new
      copion = Algo.new

      expect(alguito.mirrors) == []

      alguito.addMirror(copion)
      expect(alguito.mirrors) == [copion]

      alguito.setear_numero(24)
      copion.setear_numero(24)
      expect(alguito.numero).to eq 24
      expect(copion.numero).to eq 24

      alguito.setear_numero(37)
      expect(alguito.numero).to eq 37

      expect(copion.numero).to eq 37
    end


    it 'Agregar un copion y lo elimina' do
      alguito = Algo.new
      copion = Algo.new

      expect(alguito.mirrors) == []

      alguito.addMirror(copion)
      expect(alguito.mirrors) == [copion]

      alguito.deleteMirror(copion)
      expect(alguito.mirrors) == []
    end

  end

=begin
  context 'Registro de mesajes' do
    it 'objeto retorna los mensajes recibidos' do

      Monstruo.class_eval("replicable")
      monstruo = Monstruo.new
      monstruo.nombre = "James P Sullivan"
      monstruo.entrarEn("Puerta de Tomy")
      monstruo.asustarA("Tomy")
      monstruo.cobrarSueldo(1200)

      expect(monstruo.messages_history.messages_history).to eq([[:nombre=, "James P Sullivan"],
                                               [:entrarEn, "Puerta de Tomy"],
                                               [:asustarA, "Tomy"],
                                               [:cobrarSueldo, 1200]])
    end



  end
=end



end