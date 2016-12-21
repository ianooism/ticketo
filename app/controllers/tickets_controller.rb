class TicketsController < ApplicationController
  def index
    @tickets = Ticket.all
  end

  def show
    @ticket = set_ticket
  end

  def new
    @ticket = Ticket.new
  end

  def edit
    @ticket = set_ticket
  end

  def create
    @ticket = Ticket.new(ticket_params)
    
    if @ticket.save
      redirect_to @ticket, notice: 'Ticket created.'
    else
      render 'new'
    end
  end

  def update
    @ticket = set_ticket
    
    if @ticket.update(ticket_params)
      redirect_to @ticket, notice: 'Ticket updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @ticket = set_ticket
    
    @ticket.destroy
    redirect_to tickets_url, notice: 'Ticket destroyed.'
  end

  private
    def set_ticket
      Ticket.find(params[:id])
    end

    def ticket_params
      params.require(:ticket).permit(:name, :description, :project_id, :owner_id)
    end
end
