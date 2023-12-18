class Task < ApplicationRecord
  #before_create :set_default_timelimit
  validates :name, :content, presence: true
  validates :name, length: {maximum: 100}
  validates :content, length: {maximum: 1000}

  scope :search, -> (name, status){ where('name LIKE ?',  "%#{name}%").where(status: status)}
  scope :name_search,  -> (name) { where('name LIKE ?',  "%#{name}%") }
  scope :status_search,  -> (status) { where(status: status) }

  enum rank: { "高": 0, "中": 1, "低": 2 }

  has_many :connections, dependent: :destroy
  has_many :labels, through: :connections, source: :label
  belongs_to :user

  private

  #def set_default_timelimit
    #self.timelimit ||= Date.today
  #end
end
