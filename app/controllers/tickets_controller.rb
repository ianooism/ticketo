class TicketsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  
  def show
    render :show, locals: { project: current_project,
                            ticket: current_ticket,
                            comment: new_comment }
  end
  
  def new
    render :new, locals: { project: current_project,
                           ticket: new_ticket }
  end
  
  def create
    if new_ticket.update(ticket_form_params)
      redirect_to current_project, notice: 'Ticket created.'
    else
      render :new, locals: { project: current_project,
                             ticket: new_ticket }
    end
  end

  def edit
    render :edit, locals: { project: current_project,
                            ticket: current_ticket }
  end

  def update
    if current_ticket.update(ticket_form_params)
      redirect_to current_project, notice: 'Ticket updated.'
    else
      render :edit, locals: { project: current_project,
                              ticket: current_ticket }
    end
  end

  def destroy
    current_ticket.destroy
    redirect_to current_project, notice: 'Ticket destroyed.'
  end

  private
    def authorize_user
      raise NotAuthorized unless current_ticket.owner?(current_user)
    end
    
    def current_project
      @project ||= Project.find(params[:project_id])
    end
    
    def current_ticket
      @ticket ||= current_project.tickets.find(params[:id])
    end
    
    def new_ticket
      @ticket ||= Ticket.new(new_ticket_params)
    end
    
    def new_comment
      @comment ||= Comment.new(new_comment_params)
    end
    
    def new_comment_params
      { ticket: current_ticket,
        owner: current_user }
    end
    
    def new_ticket_params
      { project: current_project,
        owner: current_user }
    end
    
    def ticket_form_params
      params.require(:ticket).permit(:name, :description, :tag_names)
    end
end
