class Label < ApplicationRecord
  has_many :connections, dependent: :destroy
  has_many :tasks, through: :connections
end
