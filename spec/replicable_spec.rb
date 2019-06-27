require 'rspec'
require_relative '../src/replicable'
require_relative '../src/Algo'

describe 'replicable' do

  context 'when condition' do
    it 'agrega a una clase el metodo replicable' do

      Algo.class_eval("replicable")
      alguito = Algo.new

      expect(alguito.mirrors) == []
    end

    it 'guarda los copiones a los que reenviara los mensajes' do
      Algo.class_eval("replicable")
      alguito = Algo.new
      otroAlguito = Algo.new

      expect(alguito.mirrors) == []

      alguito.addMirror(otroAlguito)
      expect(alguito.mirrors) == [otroAlguito]
    end

    it 'guarda los copiones a los que reenviara los mensajes' do
      Algo.class_eval("replicable")
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
      Algo.class_eval("replicable")
      alguito = Algo.new
      copion = Algo.new

      expect(alguito.mirrors) == []

      alguito.addMirror(copion)
      expect(alguito.mirrors) == [copion]

      alguito.deleteMirror(copion)
      expect(alguito.mirrors) == []
    end

  end
end