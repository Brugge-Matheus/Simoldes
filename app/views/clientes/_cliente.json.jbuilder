json.extract! cliente, :id, :nome, :cnpj, :email, :telefone, :contato_principal, :created_at, :updated_at
json.url cliente_url(cliente, format: :json)
