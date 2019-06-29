require 'rspec'
require_relative '../src/Algo'
require_relative '../src/replicable'


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

      copion.setear_numero(15)
      alguito.setear_numero(37)

      expect(copion.numero).to eq(15)

    end

  end


end