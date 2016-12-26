class WatchersController < ApplicationController
  def create
  end
  
  def destroy
    current_ticket.watchers.destroy(current_watcher)
    redirect_to [current_project, current_ticket],
                notice: "Disabled email notifications for this ticket."
  end
  
  private
    def current_ticket
      @ticket ||= Ticket.find(params[:ticket_id])
    end
    
    def current_watcher
      @watcher ||= current_ticket.watchers.find(params[:id])
    end
    
    def current_project
      current_ticket.project
    end
end
