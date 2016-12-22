class TicketsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :check_authorization, only: [:edit, :update, :destroy]

  def show
    @project = set_project
    @ticket = set_ticket(@project)
  end

  def new
    @project = set_project
    @ticket = @project.tickets.new
  end

  def edit
    @project = set_project
    @ticket = set_ticket(@project)
  end

  def create
    @project = set_project
    @ticket = @project.tickets.new(form_params)
    
    @ticket.owner = current_user
    
    if @ticket.save
      redirect_to @project, notice: 'Ticket created.'
    else
      render 'new'
    end
  end

  def update
    @project = set_project
    @ticket = set_ticket(@project)
    
    if @ticket.update(form_params)
      redirect_to [@project, @ticket], notice: 'Ticket updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @project = set_project
    @ticket = set_ticket(@project)
    
    @ticket.destroy
    redirect_to @project, notice: 'Ticket destroyed.'
  end

  private
    def set_project
      Project.find(params[:project_id])
    end
    
    def set_ticket(project)
      project.tickets.find(params[:id])
    end
    
    def check_authorization
      project = set_project
      ticket = set_ticket(project)
      raise NotAuthorized unless ticket.owner?(current_user)
    end

    def form_params
      params.require(:ticket).permit(:name, :description)
    end
end
