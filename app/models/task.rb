class Task < ApplicationRecord
  #before_create :set_default_timelimit
  validates :name, :content, presence: true
  validates :name, length: {maximum: 100}
  validates :content, length: {maximum: 1000}

  private

  #def set_default_timelimit
   
    #self.timelimit ||= Date.today

  #end
end
