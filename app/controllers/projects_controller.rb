class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :check_authorization, only: [:edit, :update, :destroy]
  
  def index
    @projects = Project.all
  end

  def show
    @project = current_project
    @tickets = @project.tickets
    @ticket = Ticket.new
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new
    
    if @project.update(project_params)
      redirect_to projects_url, notice: 'Project created.'
    else
      render 'new'
    end
  end

  def edit
    @project = current_project
  end

  def update
    @project = current_project
    
    if @project.update(project_params)
      redirect_to @project, notice: 'Project updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @project = current_project
    
    @project.destroy
    redirect_to projects_url, notice: 'Project destroyed.'
  end

  private
    def current_project
      Project.find(params[:id])
    end
    
    def check_authorization
      project = current_project
      raise NotAuthorized unless project.owner?(current_user)
    end
    
    def project_params
      form_params.merge(session_params)
    end
    
    def form_params
      params.require(:project).permit(:name, :description)
    end
    
    def session_params
      { owner: current_user }
    end
end
