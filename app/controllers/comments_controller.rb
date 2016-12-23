class CommentsController < ApplicationController
  def show
    @project = current_project
    @ticket = current_ticket
    @comment = current_comment
  end

  def new
    @project = current_project
    @ticket = current_ticket
    @comment = Comment.new(state_params)
  end
  
  def create
    @project = current_project
    @ticket = current_ticket
    @comment = Comment.new
    
    if @comment.update(comment_params)
      redirect_to [@project, @ticket], notice: 'Comment created.'
    else
      render :new
    end
  end

  private
    def current_ticket
      Ticket.find(params[:ticket_id])
    end
    
    def current_project
      current_ticket.project
    end
    
    def current_comment
      current_ticket.comments.find(params[:id])
    end
    
    def state_params
      { state: current_ticket.state }
    end
    
    def comment_params
      form_params.merge(assoc_params)
    end
    
    def form_params
      params.require(:comment).permit(:body, :state_id)
    end
    
    def assoc_params
      { ticket: current_ticket, owner: current_user }
    end
end
