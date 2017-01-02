class TicketsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  
  def show
    render :show, locals: { project: requested_project,
                            ticket: requested_ticket,
                            comment: new_comment }
  end
  
  def new
    render :new, locals: { project: requested_project,
                           ticket: new_ticket }
  end
  
  def create
    if new_ticket.update(ticket_form_params)
      redirect_to requested_project, notice: 'Ticket created.'
    else
      render :new, locals: { project: requested_project,
                             ticket: new_ticket }
    end
  end

  def edit
    render :edit, locals: { project: requested_project,
                            ticket: requested_ticket }
  end

  def update
    if requested_ticket.update(ticket_form_params)
      redirect_to requested_project, notice: 'Ticket updated.'
    else
      render :edit, locals: { project: requested_project,
                              ticket: requested_ticket }
    end
  end

  def destroy
    requested_ticket.destroy
    redirect_to requested_project, notice: 'Ticket destroyed.'
  end

  private
    def authorize_user
      raise NotAuthorized unless requested_ticket.owner?(current_user)
    end
    
    def requested_project
      @project ||= Project.find(params[:project_id])
    end
    
    def requested_ticket
      @ticket ||= requested_project.tickets.find(params[:id])
    end
    
    def new_ticket
      @ticket ||= Ticket.new(new_ticket_params)
    end
    
    def new_comment
      @comment ||= Comment.new(new_comment_params)
    end
    
    def new_comment_params
      { ticket: requested_ticket,
        owner: current_user }
    end
    
    def new_ticket_params
      { project: requested_project,
        owner: current_user }
    end
    
    def ticket_form_params
      params.require(:ticket).permit(:name, :description, :tag_names)
    end
end
