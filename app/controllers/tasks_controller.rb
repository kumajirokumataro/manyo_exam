class TasksController < ApplicationController

  def index
    
    if params[:task].present?
      if params[:task][:name] && params[:task][:status]
        binding.pry
        @tasks = Task.where('name LIKE ?', "%#{params[:task][:name]}%").where(status: params[:task][:status])
        #モデル名.where(A).or(モデル名.where(B))
        #@tasks = Task.where('name LIKE ?', "%#{params[:task][:name]}%",status: params[:status])
      elsif params[:task][:name]
        @tasks = Task.where('name LIKE ?', "%#{params[:task][:name]}%")
       
      elsif params[:task][:status]
        @tasks = Task.where(status: params[:status])
      end
    end
    if params[:sort_expired]
      @tasks = Task.all.order(timelimit: "ASC")
    elsif params[:task]
      @tasks = @tasks
    elsif 
      @tasks = Task.all.order(created_at: "DESC")
    end
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
      
        redirect_to task_path(@task.id), notice: "投稿を作成しました！"
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
    params.require(:task).permit(:name, :content, :timelimit, :status)
  end


end
