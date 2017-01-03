class CommentsController < ApplicationController
  def show
    render :show, locals: show_template_params
  end
  
  def new
    render :new, locals: new_template_params
  end
  
  def create
    if new_comment.update(comment_form_params)
      new_comment.ticket.bulk_update(ticket_update_params)
      CommentMailer.after_create(new_comment).deliver_now
      redirect_to [current_project, requested_ticket],
                  notice: 'Comment created.'
    else
      render :new, locals: new_template_params
    end
  end

  private
    def requested_ticket
      @ticket ||= Ticket.find(params[:ticket_id])
    end
    
    def current_project
      @project ||= requested_ticket.project
    end
    
    def new_comment
      @comment ||= Comment.new(new_comment_params)
    end
    
    def new_comment_params
      { ticket: requested_ticket,
        owner: current_user }
    end
    
    def comment_form_params
      params.require(:comment).permit(:body, :state_id, :tag_names)
    end
    
    def ticket_update_params
      { state: new_comment.state,
        tags: new_comment.tag_names,
        watcher: new_comment.owner }
    end
    
    def show_template_params
      { ticket: requested_ticket,
        project: current_project }
    end
    
    def new_template_params
      { ticket: requested_ticket,
        project: current_project,
        comment: new_comment }
    end
end
