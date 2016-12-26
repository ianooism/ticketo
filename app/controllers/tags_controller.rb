class TagsController < ApplicationController
  def destroy
    current_ticket.tags.destroy(current_tag)
    redirect_to project_ticket_url(current_project, current_ticket),
      notice: "Tag destroyed."
  end
  
  private
    def current_ticket
      @ticket ||= Ticket.find(params[:ticket_id])
    end
    
    def current_tag
      @tag ||= current_ticket.tags.find(params[:id])
    end
    
    def current_project
      @project ||= current_ticket.project
    end
end
