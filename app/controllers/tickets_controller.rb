class TicketsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :check_authorization, only: [:edit, :update, :destroy]

  def show
    comments = ticket.comments
    comment = Comment.new(state_params)
    render :show,
            locals: { ticket: ticket, project: project, comments: comments,
              comment: comment }
  end
  
  def new
    ticket = Ticket.new
    render :new, locals: { ticket: ticket, project: project }
  end
  
  def create
    ticket = Ticket.new
    if ticket.update(ticket_params)
      redirect_to project, notice: 'Ticket created.'
    else
      render :new, locals: { ticket: ticket, project: project }
    end
  end

  def edit
    render :edit, locals: { ticket: ticket, project: project }
  end

  def update
    if ticket.update(ticket_params)
      redirect_to project, notice: 'Ticket updated.'
    else
      render :edit, locals: { ticket: ticket, project: project }
    end
  end

  def destroy
    ticket.destroy
    redirect_to project, notice: 'Ticket destroyed.'
  end

  private
    def check_authorization
      raise NotAuthorized unless ticket.owner?(current_user)
    end
    
    def project
      Project.find(params[:project_id])
    end
    
    def ticket
      project.tickets.find(params[:id])
    end
    
    def state_params
      { state: ticket.state }
    end
    
    def ticket_params
      [route_params, session_params, form_params].inject(:merge)
    end
    
    def route_params
      { project: project }
    end
    
    def session_params
      { owner: current_user }
    end
    
    def form_params
      params.require(:ticket).permit(:name, :description)
    end
end
