class Task < ApplicationRecord
  validates :name, :content, presence: true
  validates :name, length: {maximum: 100}
  validates :content, length: {maximum: 1000}
end
