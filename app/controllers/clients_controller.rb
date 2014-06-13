class ClientsController < ApplicationController
  before_filter :authenticate_user!, :varify_admin
  
  def index
    @clients = User.joins(:role).where("roles.name = ? ", "Client",)
  end

  def show
    @client = User.where(:id => params[:id]).first
  end

  def mark_as_deleted
    user = User.where(:id => params[:client_id]).first
    user.update_column(:mark_as_deleted, true)
    redirect_to clients_path
  end

  private

  def varify_admin
    if current_user && current_user.role.name != "Admin"
      flash[:error] = "Data is not available."
      redirect_to :back
    end
  end
end
