class Cliente < ApplicationRecord
  has_many :moldes, dependent: :destroy
end
