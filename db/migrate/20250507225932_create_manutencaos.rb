class CreateManutencaos < ActiveRecord::Migration[7.1]
  def change
    create_table :manutencaos do |t|
      t.references :molde, null: false, foreign_key: true
      t.string :tipo_manutencao
      t.date :data_manutencao
      t.text :descricao
      t.decimal :custo
      t.string :responsavel

      t.timestamps
    end
  end
end
