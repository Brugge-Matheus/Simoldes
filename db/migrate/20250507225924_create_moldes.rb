class CreateMoldes < ActiveRecord::Migration[7.1]
  def change
    create_table :moldes do |t|
      t.string :codigo
      t.text :descricao
      t.references :cliente, null: false, foreign_key: true
      t.string :tipo
      t.string :status
      t.date :data_criacao
      t.date :data_ultima_modificacao
      t.string :responsavel
      t.text :observacoes

      t.timestamps
    end
  end
end
