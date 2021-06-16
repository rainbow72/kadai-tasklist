class TasksController < ApplicationController
  before_action :require_user_logged_in

  def index
    @tasks = current_user.tasks.order(id: :desc)
  end

  def show
    @task = current_user.tasks.find_by(params[:id])
    if nil_task?
      redirect_to root_url
    end
  end

  def new
    @task = current_user.tasks.build
    if nil_task?
      redirect_to root_url
    end
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = "タスクが正常に登録されました"
      redirect_to task_path(@task)
    else
      flash.now[:danger] = "タスクが登録されませんでした"
      render :new
    end
  end

  def edit
    @task = current_user.tasks.find_by(params[:id])
    if nil_task?
      redirect_to root_url
    end
  end

  def update
    @task = current_user.tasks.find_by(params[:id])
    if nil_task?
      redirect_to root_url
    end
    
    if @task.update(task_params)
      flash[:success] = "タスクが正常に更新されました"
      redirect_to task_path(@task)
    else
      flash.now[:danger] = "タスクは更新されませんでした"
      render :new
    end
  end

  def destroy
    @task = current_user.tasks.find_by(params[:id])
    if nil_task?
      redirect_to root_url
    end
    @task.destroy
    
    flash[:success] = "タスクは正常に削除されました"
    redirect_to tasks_url
  end

  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def nil_task?
    if @task === nil
      return true
    else
      return false
    end
  end

end
