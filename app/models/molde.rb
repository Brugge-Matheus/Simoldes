class Molde < ApplicationRecord
  belongs_to :cliente
  has_many :manutencao, dependent: :destroy
  has_many :processo, dependent: :destroy

  scope :all_types, -> { select(:tipo).distinct }
  scope :all_status, -> { select(:status).distinct }
  scope :all_responsible, -> { select(:responsavel).distinct }
  scope :all_codes, -> { select(:codigo).distinct }

  scope :filter_moldes, lambda { |filters = {}|
    query = all
    query = query.where(cliente: filters[:cliente]) if filters[:cliente].present?
    query = query.where(tipo: filters[:tipo]) if filters[:tipo].present?
    query = query.where(status: filters[:status]) if filters[:status].present?
    query = query.where(responsavel: filters[:responsavel]) if filters[:responsavel].present?
    query = query.where(codigo: filters[:codigo]) if filters[:codigo].present?
    query
  }
end
