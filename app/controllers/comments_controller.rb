class CommentsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_comments

  def create
    @comment = @photo.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to photos_url
    else
      render :template => "photos/index"
    end
  end

  def update
    @comment = current_user.comments.find(params[:id])

    if @comment.update(comment_params)
      redirect_to photos_url
    else
      render :template => "photos/index"
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])

    @comment.destroy

    respond_to do |format|
      format.html { redirect_to photos_url }
      format.js # destroy.js.erb
    end

  end

  protected

  def comment_params
    params.require(:comment).permit(:user_id,:photo_id,:contents,:created_at,:updated_at)
  end

  def set_comments
    @photo = Photo.find(params[:photo_id])
  end


end
