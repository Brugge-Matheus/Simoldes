module MoldesHelper
  def filter_status_to_show(status)
    case status
    when "em-desenvolvimento"
      "Em desenvolvimento"
    when "ativo"
      "Ativo"
    when "inativo"
      "Inativo"
    when "em-teste"
      "Em teste"
    when "em-manutencao"
      "Em manutenção"
    end
  end

  def filter_types_to_show(types)
    case types
    when "fundicao"
      "Fundição"
    when "precisao"
      "Precisão"
    when "pressao"
      "Pressão"
    when "compressao"
      "Compressão"
    when "cnc"
      "CNC"
    when "injecao"
      "Injeção"
    when "fresagem"
      "Fresagem"
    end
  end

  def filter_responsibles_to_show(responsibles)
    case responsibles
    when "fernando-costa"
      "Fernando Costa"
    when "roberto-almeida"
      "Roberto Almeida"
    when "ricardo-pereira"
      "Ricardo Pereira"
    when "mariana-sousa"
      "Mariana Sousa"
    when "juliana-martins"
      "Juliana Martins"
    end
  end
end
