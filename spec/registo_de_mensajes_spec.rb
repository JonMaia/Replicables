require 'rspec'
require_relative '../src/Monstruo'

describe 'replicable con registro de mensajes' do

  context 'Registro de mesajes' do
    it 'objeto retorna los mensajes recibidos' do

      monstruo = Monstruo.new
      monstruo.nombre = "James P Sullivan"
      monstruo.entrarEn("Puerta de Tomy")
      monstruo.asustarA("Tomy")
      monstruo.cobrarSueldo(1200)
      monstruo.entrenar
      monstruo.dormir(20,"la cama de Tomy")

      expect(monstruo.messages_history.messages_history).to eq([[:nombre=, ["James P Sullivan"]],
                                                                [:entrarEn, ["Puerta de Tomy"]],
                                                                [:asustarA, ["Tomy"]],
                                                                [:cobrarSueldo, [1200]],
                                                                [:entrenar, []],
                                                                [:dormir, [20, "la cama de Tomy"]]
                                                               ])
    end


    it 'monstruoCopion luego de ser aplicado por con los mensajes de ' do

      monstruo = Monstruo.new
      monstruo.nombre = "James P Sullivan"
      monstruo.entrarEn("Puerta de Tomy")
      monstruo.asustarA("Tomy")
      monstruo.cobrarSueldo(1200)
      monstruo.entrenar
      monstruo.dormir(20,"la cama de Tomy")

      monstruo_copion = Monstruo.new

      monstruo.messages_history.apply_to(monstruo_copion)
      expect(monstruo_copion.messages_history.messages_history).to eq(monstruo.messages_history.messages_history)

    end


  end
end
