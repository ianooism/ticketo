class TicketsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :check_authorization, only: [:edit, :update, :destroy]

  def show
    comments = ticket.comments
    new_comment = Comment.new(new_comment_params)
    render :show,
            locals: { ticket: ticket, project: project, comments: comments,
              comment: new_comment }
  end
  
  def new
    new_ticket = Ticket.new(new_ticket_params)
    render :new, locals: { ticket: new_ticket, project: project }
  end
  
  def create
    new_ticket = Ticket.new(new_ticket_params)
    if new_ticket.update(ticket_form_params)
      redirect_to project, notice: 'Ticket created.'
    else
      render :new, locals: { ticket: new_ticket, project: project }
    end
  end

  def edit
    render :edit, locals: { ticket: ticket, project: project }
  end

  def update
    if ticket.update(ticket_form_params)
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
    
    def new_comment_params
      { ticket: ticket, owner: current_user }
    end
    
    def new_ticket_params
      { project: project, owner: current_user }
    end
    
    def ticket_form_params
      params.require(:ticket).permit(:name, :description, :tag_names)
    end
end
