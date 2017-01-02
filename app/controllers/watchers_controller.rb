class WatchersController < ApplicationController
  def create
    requested_ticket.update_via_interface(ticket_update_params)
    redirect_to [current_project, requested_ticket],
                notice: "Enabled email notifications for this ticket."
  end
  
  def destroy
    requested_ticket.watchers.destroy(requested_watcher)
    redirect_to [current_project, requested_ticket],
                notice: "Disabled email notifications for this ticket."
  end
  
  private
    def requested_ticket
      @ticket ||= Ticket.find(params[:ticket_id])
    end
    
    def requested_watcher
      @watcher ||= requested_ticket.watchers.find(params[:id])
    end
    
    def current_project
      requested_ticket.project
    end
    
    def ticket_update_params
      { watcher: current_user }
    end
end
