class CommentsController < ApplicationController
  def show
    locals = { ticket: ticket, project: project }
    render :show, locals: locals
  end

  def new
    locals = { comment: Comment.new(state_params), ticket: ticket,
                project: project }
    render :new, locals: locals
  end
  
  def create
    comment = Comment.new
    if comment.update(comment_params)
      redirect_to [project, ticket], notice: 'Comment created.'
    else
      locals = { comment: comment, ticket: ticket, project: project }
      render :new, locals: locals
    end
  end

  private
    def comment
      ticket.comments.find(params[:id])
    end
    
    def ticket
      Ticket.find(params[:ticket_id])
    end
    
    def project
      ticket.project
    end
    
    def state_params
      { state: ticket.state }
    end
    
    def comment_params
      [route_params, session_params, form_params].inject(:merge)
    end
    
    def route_params
      { ticket: ticket }
    end
    
    def session_params
      { owner: current_user }
    end
    
    def form_params
      params.require(:comment).permit(:body, :state_id)
    end
end
