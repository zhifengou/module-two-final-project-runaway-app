class LikesController < ApplicationController
  before_action :find_like, only: [:destroy]

  def create
    @destination = Destination.find(params[:destination_id])
    if already_liked?
      flash[:notice] = "You can't like more than once!"
      redirect_to destination_path(@destination)
    else
      @destination.likes.create(user_id: session[:user_id])
      flash[:notice] = "You have successfully added a liked place!"
      redirect_to user_path(session[:user_id])
    end
  end

 def destroy
   # @destination = Destination.find(params[:id])
   if !(already_liked?)
     flash[:notice] = "Cannot unlike"
   else
     @like.destroy
     flash[:notice] = "You have successfully removed a liked place!"
   end
   redirect_to user_path(session[:user_id])
 end

  private

  def already_liked?
    Like.where(user_id: session[:user_id], destination_id: params[:destination_id]).exists?
  end

  def find_like
    @destination = Destination.find(params[:destination_id])
    @like = @destination.likes.find(params[:id])
  end
end
