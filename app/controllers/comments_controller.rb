class CommentsController < ApplicationController
  def show
    render :show, locals: { ticket: ticket, project: project }
  end

  def new
    new_comment = Comment.new(new_comment_params)
    render :new,
            locals: { comment: new_comment, ticket: ticket, project: project }
  end
  
  def create
    new_comment = Comment.new(new_comment_params)
    if new_comment.update(comment_form_params)
      redirect_to [project, ticket], notice: 'Comment created.'
    else
      render :new,
              locals: { comment: new_comment, ticket: ticket, project: project }
    end
  end

  private
    def ticket
      Ticket.find(params[:ticket_id])
    end
    
    def comment
      ticket.comments.find(params[:id])
    end
    
    def project
      ticket.project
    end
    
    def new_comment_params
      { ticket: ticket, owner: current_user }
    end
    
    def comment_form_params
      params.require(:comment).permit(:body, :state_id, :tag_names)
    end
end
