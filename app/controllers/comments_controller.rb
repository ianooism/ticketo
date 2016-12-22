class CommentsController < ApplicationController
  def index
    @ticket = set_ticket
    @comments = @ticket.comments.all
  end

  def show
    @ticket = set_ticket
    @project = @ticket.project
    @comment = set_comment
  end

  def new
    @ticket = set_ticket
    @project = @ticket.project
    @comment = Comment.new
  end
  
  def create
    @ticket = set_ticket
    @comment = Comment.new
    @comment.attributes = form_params.merge(assoc_params)
    if @comment.save
      redirect_to [@ticket, @comment], notice: 'Comment created.'
    else
      render 'new'
    end
  end

  private
    def set_ticket
      Ticket.find(params[:ticket_id])
    end
    
    def set_comment
      set_ticket.comments.find(params[:id])
    end
    
    def assoc_params
      { ticket: @ticket, owner: current_user }
    end
    
    def form_params
      params.require(:comment).permit(:body)
    end
end
