class TagsController < ApplicationController
  def destroy
  end
  
  private
    def ticket
      Ticket.find(params[:ticket_id])
    end
    
    def tag
      ticket.tags.find(params[:id])
    end
end
