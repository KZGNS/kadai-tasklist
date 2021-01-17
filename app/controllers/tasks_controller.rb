class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  #logged_in 用
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :update, :destroy]
  
  def index
    #いったん消しておく@tasks = Task.all
    if logged_in?
      @task = current_user.tasks.build  # form_with 用
      @tasks = current_user.tasks.order(id: :desc) #page(params[:page])
    end
    
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    #@task = Task.new(task_params)
    
    @task = current_user.tasks.build(task_params)

    if @task.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to tasks_path
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
    end
    
  end

  def edit
  end

  def update

      if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
      else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
      end
  end

  def destroy
      @task.destroy

      flash[:success] = 'Task は正常に削除されました'
      redirect_to tasks_url
      
  end
    
    private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
    
    
end
