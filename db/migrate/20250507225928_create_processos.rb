class CreateProcessos < ActiveRecord::Migration[7.1]
  def change
    create_table :processos do |t|
      t.references :molde, null: false, foreign_key: true
      t.string :nome_processo
      t.date :data_inicio
      t.date :data_prevista_fim
      t.date :data_fim
      t.string :status
      t.string :responsavel
      t.text :observacoes

      t.timestamps
    end
  end
end
