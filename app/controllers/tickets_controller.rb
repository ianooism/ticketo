class TicketsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :check_authorization, only: [:edit, :update, :destroy]

  def show
    @project = current_project
    @ticket = current_ticket
    @comments = @ticket.comments
    @comment = Comment.new(state_params)
  end
  
  def new
    @project = current_project
    @ticket = Ticket.new(state_params)
  end
  
  def create
    @project = current_project
    @ticket = Ticket.new
    
    if @ticket.update(ticket_params)
      redirect_to @project, notice: 'Ticket created.'
    else
      render 'new'
    end
  end

  def edit
    @project = current_project
    @ticket = current_ticket
  end

  def update
    @project = current_project
    @ticket = current_ticket
    
    if @ticket.update(ticket_params)
      redirect_to @project, notice: 'Ticket updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @project = current_project
    @ticket = current_ticket
    
    @ticket.destroy
    redirect_to @project, notice: 'Ticket destroyed.'
  end

  private
    def check_authorization
      raise NotAuthorized unless current_ticket.owner?(current_user)
    end
    
    def current_project
      Project.find(params[:project_id])
    end
    
    def current_ticket
      current_project.tickets.find(params[:id])
    end
    
    def state_params
      { state: current_ticket.state }
    end
    
    def ticket_params
      form_params.merge(association_params)
    end
    
    def form_params
      params.require(:ticket).permit(:name, :description)
    end
    
    def association_params
      { project: current_project, owner: current_user }
    end
end
