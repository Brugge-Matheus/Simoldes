json.extract! processo, :id, :molde_id, :nome_processo, :data_inicio, :data_prevista_fim, :data_fim, :status, :responsavel, :observacoes, :created_at, :updated_at
json.url processo_url(processo, format: :json)
