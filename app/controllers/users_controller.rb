class UsersController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def show
    user = User.find_by(id: params[:id])
    render json: user, include: :items
  end

  def item_index
    user = User.find(params[:user_id])
    items = user.items
    render json: items, include: :user
  end

  def item
    render json: User.find(params[:user_id]).items.find(params[:id])
  end

  def new_item
    item = User.find(params[:user_id]).items.create(item_params)
    render json: item, status: :created
  end

  private

  def item_params
    params.permit(:name, :description, :price)
  end

  def render_not_found_response
    render json: {error: "User not found"}, status: :not_found
  end

end
