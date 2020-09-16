class Admin::UsersController < ApplicationController
  def index
    @users = User.page(params[:page] || 1).per_page(params[:per_page] || 10)
      .order("id asc")
  end

  def search 
  	@users = User.page(params[:page] || 1).per_page(params[:per_page] || 10)
      .order("id asc").where(["username like ?", "%#{params[:username]}%"])
      render action: :index
  end
end
