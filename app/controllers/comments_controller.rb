class CommentsController < ApplicationController
  def show
    render :show, locals: { project: current_project,
                            ticket: current_ticket }
  end
  
  def new
    render :new, locals: { project: current_project,
                           ticket: current_ticket,
                           comment: Comment.new(new_comment_params) }
  end
  
  def create
    new_comment = Comment.new(new_comment_params)
    
    if new_comment.update(comment_form_params)
      CommentMailer.after_create(new_comment).deliver_now
      redirect_to [current_project, current_ticket], notice: 'Comment created.'
    else
      render :new, locals: { project: current_project,
                             ticket: current_ticket,
                             comment: new_comment }
    end
  end

  private
    def current_ticket
      @ticket ||= Ticket.find(params[:ticket_id])
    end
    
    def current_project
      @project ||= current_ticket.project
    end
    
    def new_comment_params
      { ticket: current_ticket,
        owner: current_user }
    end
    
    def comment_form_params
      params.require(:comment).permit(:body, :state_id, :tag_names)
    end
end
