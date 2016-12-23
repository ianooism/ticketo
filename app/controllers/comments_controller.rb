class CommentsController < ApplicationController
  def index
    @ticket = current_ticket
    @comments = @ticket.comments.all
  end

  def show
    @project = current_project
    @ticket = current_ticket
    @comment = current_comment
  end

  def new
    @project = current_project
    @ticket = current_ticket
    @comment = Comment.new
  end
  
  def create
    @ticket = current_ticket
    @comment = Comment.new
    
    if @comment.update(comment_params)
      redirect_to({action: 'index'}, notice: 'Comment created.')
    else
      render 'new'
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
    
    def comment_params
      form_params.merge(assoc_params)
    end
    
    def form_params
      params.require(:comment).permit(:body)
    end
    
    def assoc_params
      { ticket: current_ticket, owner: current_user }
    end
end
