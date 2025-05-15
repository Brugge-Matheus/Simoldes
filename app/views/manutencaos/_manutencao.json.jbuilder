json.extract! manutencao, :id, :molde_id, :tipo_manutencao, :data_manutencao, :descricao, :custo, :responsavel, :created_at, :updated_at
json.url manutencao_url(manutencao, format: :json)
