class User < ApplicationRecord
  validates :email, uniqueness: true
  before_validation { email.downcase! }
  before_destroy :not_admin_destroy
  before_update :not_admin_update
  has_many :tasks, dependent: :destroy

  has_secure_password

  private

  def not_admin_destroy
    throw (:abort) if self.admin == true && User.where(admin: true).count == 1
    #User.where(admin: true).count == 1 でもOK!!
    #User.all.count{ |item| item.admin == true} == 1 
  end

  def not_admin_update
    if self.admin_change == [true, false] && User.where(admin: true).count == 1
      throw (:abort)
      flash[:notice]="管理者は一人以上必要です！"
    end 
  end

  

end
