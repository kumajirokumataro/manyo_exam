class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    #@task.user_id = current_user.id 
    #if params[:back]
      #render :new
    #else 
      if @task.save
        redirect_to new_task_path, notice: "投稿を作成しました！"
      else
        render :new
      end
    #end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice:"削除しました！"
  end


  private

  def task_params
    params.require(:task).permit(:name, :content)
  end


end
