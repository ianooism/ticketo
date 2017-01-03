class WatchersController < ApplicationController
  def create
    requested_ticket.bulk_update(ticket_update_params)
    redirect_to [current_project, requested_ticket],
                notice: "Enabled email notifications for this ticket."
  end
  
  def destroy
    requested_ticket.watchers.destroy(current_user)
    redirect_to [current_project, requested_ticket],
                notice: "Disabled email notifications for this ticket."
  end
  
  private
    def requested_ticket
      @ticket ||= Ticket.find(params[:ticket_id])
    end
    
    def current_project
      requested_ticket.project
    end
    
    def ticket_update_params
      { watcher: current_user }
    end
end
