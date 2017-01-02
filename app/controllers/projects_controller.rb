class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  
  def index
    render :index, locals: { projects: Project.all }
  end

  def show
    render :show, locals: { project: requested_project,
                            ticket: new_ticket }
  end

  def new
    render :new, locals: { project: new_project }
  end

  def create
    if new_project.update(project_form_params)
      redirect_to projects_url, notice: 'Project created.'
    else
      render :new, locals: { project: new_project }
    end
  end

  def edit
    render :edit, locals: { project: requested_project }
  end

  def update
    if requested_project.update(project_form_params)
      redirect_to projects_url, notice: 'Project updated.'
    else
      render :edit, locals: { project: requested_project }
    end
  end

  def destroy
    requested_project.destroy
    redirect_to projects_url, notice: 'Project destroyed.'
  end

  private
    def authorize_user
      raise NotAuthorized unless requested_project.owner?(current_user)
    end
    
    def requested_project
      @project ||= Project.find(params[:id])
    end
    
    def new_project
      @project ||= Project.new(new_project_params)
    end
    
    def new_ticket
      @ticket ||= Ticket.new(new_ticket_params)
    end
    
    def new_project_params
      { owner: current_user }
    end
    
    def new_ticket_params
      { project: requested_project,
        owner: current_user }
    end
    
    def project_form_params
      params.require(:project).permit(:name, :description)
    end
end
