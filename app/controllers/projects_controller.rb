class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  
  def index
    render :index, locals: { projects: Project.all }
  end

  def show
    render :show, locals: { project: current_project,
                            ticket: Ticket.new(new_ticket_params) }
  end

  def new
    render :new, locals: { project: Project.new(new_project_params) }
  end

  def create
    new_project = Project.new(new_project_params)
    
    if new_project.update(project_form_params)
      redirect_to projects_url, notice: 'Project created.'
    else
      render :new, locals: { project: new_project }
    end
  end

  def edit
    render :edit, locals: { project: current_project }
  end

  def update
    if current_project.update(project_form_params)
      redirect_to projects_url, notice: 'Project updated.'
    else
      render :edit, locals: { project: current_project }
    end
  end

  def destroy
    current_project.destroy
    redirect_to projects_url, notice: 'Project destroyed.'
  end

  private
    def authorize_user
      raise NotAuthorized unless current_project.owner?(current_user)
    end
    
    def current_project
      @project ||= Project.find(params[:id])
    end
    
    def new_project_params
      { owner: current_user }
    end
    
    def new_ticket_params
      { project: current_project,
        owner: current_user }
    end
    
    def project_form_params
      params.require(:project).permit(:name, :description)
    end
end
