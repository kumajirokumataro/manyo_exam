class TasksController < ApplicationController

  def index
    if params[:task].present?
      if params[:task][:name] && params[:task][:status].present?
        @tasks = current_user.tasks.search(params[:task][:name], params[:task][:status])
        #sucopeを使用しなかった時の書き方@tasks = Task.where('name LIKE ?', "%#{params[:task][:name]}%").where(status: params[:task][:status])
        #モデル名.where(A).or(モデル名.where(B))
      elsif params[:task][:name]
        @tasks = current_user.tasks.name_search(params[:task][:name])
      elsif params[:task][:status]
        @tasks = current_user.tasks.status_search(params[:task][:status])
      elsif params[:task][:id]
        label = Label.find(params[:task][:id])
        label_task_id = label.connections.pluck(:task_id)
        @tasks = Task.where(id: label_task_id)
      end
    end

    

    if params[:sort_expired]
      @tasks = current_user.tasks.all.order(timelimit: "ASC")
    elsif params[:sort_rank]
      @tasks = current_user.tasks.all.order(rank: "ASC")
    elsif params[:task]
      #@tasks = @tasksということ（検索機能で絞られたタスクがそのまま、ということ）
    elsif 
      @tasks = current_user.tasks.all.order(created_at: "DESC")
    end

    @task = Task.new

    @tasks = @tasks.page(params[:page]).per(15)

  end

  

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    #この上の1行は、この2行のこと
    #@task = Task.new(task_params)
    #@task.user_id = current_user.id 

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
    params.require(:task).permit(:name, :content, :timelimit, :status, :rank, { label_ids: [] })
  end


end
