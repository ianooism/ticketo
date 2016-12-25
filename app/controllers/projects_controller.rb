class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :check_authorization, only: [:edit, :update, :destroy]
  
  def index
    projects = Project.all.order('created_at desc')
    render :index, locals: { projects: projects }
  end

  def show
    tickets = project.tickets.order('created_at desc')
    ticket = Ticket.new(new_ticket_params)
    render :show,
            locals: { project: project, tickets: tickets, ticket: ticket }
  end

  def new
    project = Project.new(new_project_params)
    render :new, locals: { project: project }
  end

  def create
    project = Project.new(new_project_params)
    if project.update(form_params)
      redirect_to projects_url, notice: 'Project created.'
    else
      render :new, locals: { project: project }
    end
  end

  def edit
    render :edit, locals: { project: project }
  end

  def update
    if project.update(form_params)
      redirect_to projects_url, notice: 'Project updated.'
    else
      render :edit, locals: { project: project }
    end
  end

  def destroy
    project.destroy
    redirect_to projects_url, notice: 'Project destroyed.'
  end

  private
    def project
      Project.find(params[:id])
    end
    
    def check_authorization
      raise NotAuthorized unless project.owner?(current_user)
    end
    
    def new_project_params
      { owner: current_user }
    end
    
    def new_ticket_params
      { project: project, owner: current_user }
    end
    
    def form_params
      params.require(:project).permit(:name, :description)
    end
end
