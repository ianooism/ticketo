class CommentsController < ApplicationController
  def show
    render :show, locals: { ticket: ticket, project: project }
  end

  def new
    comment = Comment.new(new_comment_params)
    render :new, locals: { comment: comment, ticket: ticket, project: project }
  end
  
  def create
    comment = Comment.new(new_comment_params)
    if comment.update(comment_form_params)
      redirect_to [project, ticket], notice: 'Comment created.'
    else
      render :new, locals: { comment: comment, ticket: ticket, project: project }
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
    
    def new_comment_params
      { ticket: ticket, owner: current_user }
    end
    
    def comment_form_params
      params.require(:comment).permit(:body, :state_id, :tag_names).to_h
    end
end
