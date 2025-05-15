# db/seeds.rb
# Script para povoar o banco de dados com dados iniciais

# Limpa todos os registros existentes
puts "Limpando registros existentes..."
Manutencao.destroy_all
Processo.destroy_all
Molde.destroy_all
Cliente.destroy_all
User.destroy_all

# Cria usuario admin
puts "Criando usuario"
User.create(
  email: "admin@simoldes.com.br",
  password: 291005
)

User.all.map do |user_data|
  puts "Usuario criado #{user_data.email}, #{user_data.password}"
end

# Cria clientes
puts "Criando clientes..."
clientes = [
  { nome: "Auto Peças Brasil Ltda", cnpj: "12.345.678/0001-01", email: "contato@autopecas.com.br", telefone: "(41) 3333-4444", contato_principal: "João Silva" },
  { nome: "Plásticos Industriais S.A.", cnpj: "23.456.789/0001-02", email: "vendas@plasticosindustria.com.br", telefone: "(41) 4444-5555", contato_principal: "Maria Oliveira" },
  { nome: "Componentes Técnicos ME", cnpj: "34.567.890/0001-03", email: "atendimento@componentestec.com.br", telefone: "(41) 5555-6666", contato_principal: "Pedro Santos" },
  { nome: "Indústria Mecânica Paraná", cnpj: "45.678.901/0001-04", email: "comercial@impmecanica.com.br", telefone: "(41) 6666-7777", contato_principal: "Ana Costa" },
  { nome: "Metalúrgica Curitiba Ltda", cnpj: "56.789.012/0001-05", email: "contato@metalcuritiba.com.br", telefone: "(41) 7777-8888", contato_principal: "Carlos Ferreira" }
]

clientes_criados = clientes.map do |cliente_data|
  cliente = Cliente.create!(cliente_data)
  puts "Cliente criado: #{cliente.nome}"
  cliente
end

# Cria moldes
puts "Criando moldes..."
moldes = [
  { codigo: "M001-2023", descricao: "Molde para painel frontal", cliente: clientes_criados[0], tipo: "Injeção", status: "Ativo", data_criacao: "2023-01-15", data_ultima_modificacao: "2023-05-20", responsavel: "Roberto Almeida", observacoes: "Molde de alta precisão para componentes automotivos" },
  { codigo: "M002-2023", descricao: "Molde para carcaça de motor", cliente: clientes_criados[0], tipo: "Pressão", status: "Ativo", data_criacao: "2023-02-10", data_ultima_modificacao: "2023-06-15", responsavel: "Roberto Almeida", observacoes: "Resistente a altas temperaturas" },
  { codigo: "M003-2023", descricao: "Molde para embalagens plásticas", cliente: clientes_criados[1], tipo: "Injeção", status: "Em manutenção", data_criacao: "2023-03-05", data_ultima_modificacao: "2023-07-12", responsavel: "Juliana Martins", observacoes: "Molde com múltiplas cavidades" },
  { codigo: "M004-2023", descricao: "Molde para peças de precisão", cliente: clientes_criados[2], tipo: "CNC", status: "Ativo", data_criacao: "2023-04-20", data_ultima_modificacao: "2023-08-30", responsavel: "Fernando Costa", observacoes: "Tolerâncias mínimas de 0.01mm" },
  { codigo: "M005-2023", descricao: "Molde para componentes hidráulicos", cliente: clientes_criados[3], tipo: "Fundição", status: "Inativo", data_criacao: "2023-05-18", data_ultima_modificacao: "2023-09-25", responsavel: "Mariana Sousa", observacoes: "Liga especial de alumínio" },
  { codigo: "M006-2023", descricao: "Molde para peças de conexão", cliente: clientes_criados[4], tipo: "Injeção", status: "Ativo", data_criacao: "2023-06-22", data_ultima_modificacao: "2023-10-15", responsavel: "Ricardo Pereira", observacoes: "Alta durabilidade para produção contínua" },
  { codigo: "M007-2023", descricao: "Molde para tampas industriais", cliente: clientes_criados[1], tipo: "Compressão", status: "Em desenvolvimento", data_criacao: "2023-07-10", data_ultima_modificacao: "2023-11-05", responsavel: "Juliana Martins", observacoes: "Projeto com design inovador" },
  { codigo: "M008-2023", descricao: "Molde para bases de equipamentos", cliente: clientes_criados[2], tipo: "Fresagem", status: "Ativo", data_criacao: "2023-08-15", data_ultima_modificacao: "2023-12-10", responsavel: "Fernando Costa", observacoes: "Estrutura reforçada para suportar grandes cargas" },
  { codigo: "M009-2023", descricao: "Molde para acessórios automotivos", cliente: clientes_criados[0], tipo: "Injeção", status: "Em teste", data_criacao: "2023-09-20", data_ultima_modificacao: "2024-01-15", responsavel: "Roberto Almeida", observacoes: "Compatível com novos modelos de veículos" },
  { codigo: "M010-2023", descricao: "Molde para componentes eletrônicos", cliente: clientes_criados[3], tipo: "Precisão", status: "Ativo", data_criacao: "2023-10-25", data_ultima_modificacao: "2024-02-20", responsavel: "Mariana Sousa", observacoes: "Molde com sistema de refrigeração integrado" }
]

moldes_criados = moldes.map do |molde_data|
  molde = Molde.create!(molde_data)
  puts "Molde criado: #{molde.codigo} - #{molde.descricao}"
  molde
end

# Cria processos
puts "Criando processos..."
processos = [
  { molde: moldes_criados[0], nome_processo: "Desenho técnico", data_inicio: "2023-01-15", data_prevista_fim: "2023-01-30", data_fim: "2023-01-28", status: "Concluído", responsavel: "Carlos Designer", observacoes: "Finalizado dentro do prazo" },
  { molde: moldes_criados[0], nome_processo: "Usinagem", data_inicio: "2023-01-31", data_prevista_fim: "2023-02-15", data_fim: "2023-02-20", status: "Concluído", responsavel: "Equipe Usinagem", observacoes: "Pequeno atraso devido à complexidade" },
  { molde: moldes_criados[0], nome_processo: "Tratamento térmico", data_inicio: "2023-02-21", data_prevista_fim: "2023-03-05", data_fim: "2023-03-04", status: "Concluído", responsavel: "Setor Térmico", observacoes: "Conforme especificações" },
  { molde: moldes_criados[0], nome_processo: "Montagem", data_inicio: "2023-03-06", data_prevista_fim: "2023-03-20", data_fim: "2023-03-18", status: "Concluído", responsavel: "Equipe Montagem", observacoes: "Montagem concluída sem problemas" },
  { molde: moldes_criados[0], nome_processo: "Teste inicial", data_inicio: "2023-03-21", data_prevista_fim: "2023-04-05", data_fim: "2023-04-10", status: "Concluído", responsavel: "Laboratório Testes", observacoes: "Pequenos ajustes necessários" },

  { molde: moldes_criados[1], nome_processo: "Desenho técnico", data_inicio: "2023-02-10", data_prevista_fim: "2023-02-25", data_fim: "2023-02-24", status: "Concluído", responsavel: "Carlos Designer", observacoes: "Concluído conforme planejado" },
  { molde: moldes_criados[1], nome_processo: "Usinagem", data_inicio: "2023-02-26", data_prevista_fim: "2023-03-15", data_fim: nil, status: "Em andamento", responsavel: "Equipe Usinagem", observacoes: "Trabalho em progresso" },

  { molde: moldes_criados[2], nome_processo: "Desenho técnico", data_inicio: "2023-03-05", data_prevista_fim: "2023-03-20", data_fim: "2023-03-19", status: "Concluído", responsavel: "Amanda Projetista", observacoes: "Finalizado conforme especificações" },
  { molde: moldes_criados[2], nome_processo: "Usinagem CNC", data_inicio: "2023-03-21", data_prevista_fim: "2023-04-10", data_fim: "2023-04-15", status: "Concluído", responsavel: "Setor CNC", observacoes: "Leve atraso devido à calibração" },

  { molde: moldes_criados[3], nome_processo: "Modelagem 3D", data_inicio: "2023-04-20", data_prevista_fim: "2023-05-10", data_fim: "2023-05-08", status: "Concluído", responsavel: "Depto. Design", observacoes: "Modelo finalizado antes do prazo" },
  { molde: moldes_criados[3], nome_processo: "Prototipagem", data_inicio: "2023-05-09", data_prevista_fim: "2023-05-30", data_fim: nil, status: "Em andamento", responsavel: "Setor Protótipos", observacoes: "Em fase de testes preliminares" },

  { molde: moldes_criados[4], nome_processo: "Desenho técnico", data_inicio: "2023-05-18", data_prevista_fim: "2023-06-01", data_fim: "2023-06-05", status: "Concluído", responsavel: "Rodrigo Desenhista", observacoes: "Pequeno atraso devido a revisões" },
  { molde: moldes_criados[4], nome_processo: "Fundição", data_inicio: "2023-06-06", data_prevista_fim: "2023-06-25", data_fim: "2023-06-30", status: "Concluído", responsavel: "Equipe Fundição", observacoes: "Realizado conforme especificações técnicas" },

  { molde: moldes_criados[5], nome_processo: "Projeto inicial", data_inicio: "2023-06-22", data_prevista_fim: "2023-07-10", data_fim: "2023-07-08", status: "Concluído", responsavel: "Time de Projetos", observacoes: "Finalizado dentro do prazo" },
  { molde: moldes_criados[5], nome_processo: "Fabricação", data_inicio: "2023-07-11", data_prevista_fim: "2023-08-15", data_fim: nil, status: "Em andamento", responsavel: "Setor Produção", observacoes: "Seguindo cronograma planejado" }
]

processos.each do |processo_data|
  processo = Processo.create!(processo_data)
  puts "Processo criado: #{processo.nome_processo} para o molde #{processo.molde.codigo}"
end

# Cria manutenções
puts "Criando manutenções..."
manutencoes = [
  { molde: moldes_criados[0], tipo_manutencao: "Preventiva", data_manutencao: "2023-06-10", descricao: "Limpeza e lubrificação geral", custo: 850.00, responsavel: "Equipe Manutenção" },
  { molde: moldes_criados[0], tipo_manutencao: "Corretiva", data_manutencao: "2023-09-15", descricao: "Substituição de componentes desgastados", custo: 1200.00, responsavel: "Técnico Especialista" },

  { molde: moldes_criados[1], tipo_manutencao: "Preventiva", data_manutencao: "2023-07-20", descricao: "Verificação de alinhamento e calibração", custo: 650.00, responsavel: "Equipe Manutenção" },

  { molde: moldes_criados[2], tipo_manutencao: "Corretiva", data_manutencao: "2023-08-05", descricao: "Reparo de sistema de ejeção", custo: 1500.00, responsavel: "Especialista Externo" },
  { molde: moldes_criados[2], tipo_manutencao: "Preventiva", data_manutencao: "2023-11-10", descricao: "Manutenção programada semestral", custo: 950.00, responsavel: "Equipe Manutenção" },

  { molde: moldes_criados[3], tipo_manutencao: "Preditiva", data_manutencao: "2023-10-15", descricao: "Análise de desgaste e durabilidade", custo: 750.00, responsavel: "Laboratório Técnico" },

  { molde: moldes_criados[4], tipo_manutencao: "Corretiva", data_manutencao: "2023-11-25", descricao: "Substituição de buchas e guias", custo: 1800.00, responsavel: "Equipe Especializada" },

  { molde: moldes_criados[5], tipo_manutencao: "Preventiva", data_manutencao: "2024-01-05", descricao: "Limpeza de canais e verificação geral", custo: 950.00, responsavel: "Equipe Manutenção" },

  { molde: moldes_criados[6], tipo_manutencao: "Preditiva", data_manutencao: "2024-02-10", descricao: "Análise termográfica e de vibrações", custo: 1100.00, responsavel: "Técnico Especializado" },

  { molde: moldes_criados[7], tipo_manutencao: "Preventiva", data_manutencao: "2024-01-20", descricao: "Manutenção preventiva programada", custo: 800.00, responsavel: "Equipe Manutenção" }
]

manutencoes.each do |manutencao_data|
  manutencao = Manutencao.create!(manutencao_data)
  puts "Manutenção criada: #{manutencao.tipo_manutencao} para o molde #{manutencao.molde.codigo} em #{manutencao.data_manutencao}"
end

puts "Seed finalizado com sucesso!"
puts "Total de registros criados:"
puts "- Clientes: #{Cliente.count}"
puts "- Moldes: #{Molde.count}"
puts "- Processos: #{Processo.count}"
puts "- Manutenções: #{Manutencao.count}"