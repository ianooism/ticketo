class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :check_authorization, only: [:edit, :update, :destroy]
  
  def index
    @projects = Project.all
  end

  def show
    @project = set_project
    @tickets = @project.tickets
    # don't put unpersisted ticket into project.tickets collection
    @ticket = Ticket.new(project: @project)
  end

  def new
    @project = Project.new
  end

  def edit
    @project = set_project
  end

  def create
    @project = Project.new(form_params)
    
    @project.owner = current_user
    
    if @project.save
      redirect_to projects_url, notice: 'Project created.'
    else
      render 'new'
    end
  end

  def update
    @project = set_project
    
    if @project.update(form_params)
      redirect_to @project, notice: 'Project updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @project = set_project
    
    @project.destroy
    redirect_to projects_url, notice: 'Project destroyed.'
  end

  private
    def set_project
      Project.find(params[:id])
    end
    
    def check_authorization
      project = set_project
      raise NotAuthorized unless project.owner?(current_user)
    end

    def form_params
      params.require(:project).permit(:name, :description)
    end
end
