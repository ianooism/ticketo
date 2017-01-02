class TagsController < ApplicationController
  def destroy
    requested_ticket.tags.destroy(requested_tag)
    redirect_to project_ticket_url(current_project, requested_ticket),
      notice: "Tag destroyed."
  end
  
  private
    def requested_ticket
      @ticket ||= Ticket.find(params[:ticket_id])
    end
    
    def requested_tag
      @tag ||= requested_ticket.tags.find(params[:id])
    end
    
    def current_project
      @project ||= requested_ticket.project
    end
end
