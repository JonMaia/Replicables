require 'rspec'
require_relative '../src/replicable'
require_relative '../src/Monstruo'
require_relative '../src/Puerta'

describe 'Branch' do

  context 'Branchs de objetos' do

    it 'se modifican dos objetos brancheados, tienen distinto historial de mensajes' do
      sully = Monstruo.new
      sully.nombre = "James P Sullivan"
      sully.energia = 200
      sully.motivacion = 100

      sully_para_puerta1 = sully.branch("puerta1")
      sully_para_puerta2 = sully.branch("puerta2")

      puerta1 = Puerta.new(true)
      puerta2 = Puerta.new(false)
      sully_para_puerta1.entrarYAsustar(puerta1)
      sully_para_puerta2.entrarYAsustar(puerta2)

      history_sully = sully.messages_history.messages_history
      history_sully_puerta1 = sully_para_puerta1.messages_history.messages_history
      history_sully_puerta2 = sully_para_puerta2.messages_history.messages_history

      expect(history_sully).not_to eq(history_sully_puerta1)
      expect(history_sully).not_to eq(history_sully_puerta2)
      expect(history_sully_puerta1).not_to eq(history_sully_puerta2)
    end


    it 'mirror de monstruoCopion recibe el fordward de los metodos aplicados al branch monstruoCopion
       de montruo, mostruo no es afectado ' do

      monstruo_master = Monstruo.new

      msg_hist_monstruo_master = monstruo_master.messages_history
      monstruo_branch_fordward = monstruo_master.branch("fordward")

      monstruo_branch_fordward.nombre = "James P Sullivan"
      monstruo_branch_fordward.entrarEn("Puerta de Tomy")
      monstruo_branch_fordward.asustarA("Tomy")
      monstruo_branch_fordward.cobrarSueldo(1200)
      monstruo_branch_fordward.entrenar
      monstruo_branch_fordward.dormir(20,"la cama de Tomy")

      mirror_monstruo_copion = Monstruo.new
      monstruo_copion = Monstruo.new
      monstruo_copion.addMirror(mirror_monstruo_copion)

      monstruo_branch_fordward.messages_history.apply_to(monstruo_copion)
      expect(monstruo_copion.messages_history.messages_history).to eq(monstruo_branch_fordward.messages_history.messages_history)
      expect(mirror_monstruo_copion.messages_history.messages_history).to eq(monstruo_branch_fordward.messages_history.messages_history)
      expect(msg_hist_monstruo_master.messages_history).not_to eq(monstruo_branch_fordward.messages_history.messages_history)

    end

    it 'se crea un branch desde otro branch' do
      monstruo_depresivo = Monstruo.new
      monstruo_depresivo.nombre = "James P Sullivan"

      monstruo_en_terapia = monstruo_depresivo.branch("branch1")
      monstruo_en_terapia.energia=75
      monstruo_en_terapia.motivacion=25

      expect(monstruo_depresivo.energia).to eq(100)
      expect(monstruo_depresivo.motivacion).to eq(0)


      monstruo_balanceado = monstruo_en_terapia.branch("branch2")
      monstruo_balanceado.energia=50
      monstruo_balanceado.motivacion=50

      expect(monstruo_depresivo.energia).to eq(100)
      expect(monstruo_en_terapia.energia).to eq(75)
      expect(monstruo_depresivo.motivacion).to eq(0)
      expect(monstruo_en_terapia.motivacion).to eq(25)


      puerta1 = Puerta.new(true)
      puerta2 = Puerta.new(false)

      monstruo_en_terapia.entrarYAsustar(puerta1)
      monstruo_balanceado.entrarYAsustar(puerta2)

      expect(monstruo_depresivo.energia).to eq(100)
      expect(monstruo_en_terapia.energia).to eq(70)
      expect(monstruo_balanceado.energia).to eq(0)

      expect(monstruo_depresivo.motivacion).to eq(0)
      expect(monstruo_en_terapia.motivacion).to eq(135)
      expect(monstruo_balanceado.motivacion).to eq(50)

    end
  end
end