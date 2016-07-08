class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.where user_id: current_user.id
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @subtasks=@task.subtasks.select{|s| s.parent_id==nil}
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @numSubTasks=(params[:number_subtasks]!=nil) ? params[:number_subtasks].to_i : 4
    (1..@numSubTasks).each do |i| @task.subtasks.new complete: false end
    @count=0
    @remainder=100 % @numSubTasks
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user=current_user
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def complete
    @subtask=Subtask.find(params[:id])
    @subtask.update_attribute :complete, true
  end

  def split
    @subtask=Subtask.find(params[:id])
    @numSubTasks=(params[:number_subtasks]).to_i
    @newSubTasks=Array.new
    (1..@numSubTasks).each do |i| @subtask.children.build(name: i.to_s, percent: 100/@numSubTasks) end
    @count=0
    @remainder= 100 % @numSubTasks
  end

  def createSubtasks
    @subtask=Subtask.find(params[:id])
    @children=params[:subtask][:children_attributes].to_a.map{|x| x[1]}
    @children.each do |x| @subtask.children.build(name: x["name"], percent: x["percent"], task_id: @subtask.task_id).save end
    redirect_to @subtask.task
  end

  helper_method :slider_string
  def slider_string id
    "task[subtasks_attributes][#{id}][percent]"
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, subtasks_attributes: [:name, :percent])
    end
end
