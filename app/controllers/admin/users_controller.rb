class Admin::UsersController < ApplicationController
  before_action :not_admin_taskspath

  def index
    @users = User.preload(:tasks).all
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "編集しました！"
    else
      render :edit
    end
  end


  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_path, notice:"削除しました！"
    else
      redirect_to admin_users_path, notice:"削除できませんでした！"
    end    
  end

  def not_admin_taskspath
    if current_user.admin == false
      flash[:notice]="管理者以外はアクセスできません"
      redirect_to tasks_path
    end
  end

end



