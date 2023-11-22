class Task < ApplicationRecord
  validates :name, :content, presence: true
  validates :name, length: {minimum: 100}
  validates :content, length: {minimum: 1000}
end
