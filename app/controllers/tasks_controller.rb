class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :task_find_by, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.order(id: :desc)
  end

  def show
  end

  def new
    @task = current_user.tasks.build
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
  end

  def update
    if @task.update(task_params)
      flash[:success] = "タスクが正常に更新されました"
      redirect_to task_path(@task)
    else
      flash.now[:danger] = "タスクは更新されませんでした"
      render :new
    end
  end

  def destroy
    @task.destroy
    
    flash[:success] = "タスクは正常に削除されました"
    redirect_to tasks_url
  end

  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end

end
