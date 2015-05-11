class PhotosController < ApplicationController
  
  before_action :authenticate_user!, :except => [:index, :show]

  before_action :find_pic, :only => [:show, :edit, :update, :destroy]

  def index
    @photos= Photo.all
    @title = "Photo Album"
    @comment = Comment.new
  end

  def new
    @title = "New Photo"
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user = current_user
    if @photo.save
      redirect_to photos_url
      flash[:success]="新增照片"

    else
      render :action => :new
    end
  end

  def show
    @title = @photo.title
  end

  def edit
    @title = "Edit Photo"
  end

  def update
    raise "WTF" unless @photo.can_edit_by_user?(current_user)

     if params[:destroy_pic]
       @photo.pic = nil
     end

    if @photo.update(photo_params)
      flash[:notice] = "編輯成功"
      redirect_to photos_url
    else
      render :action => :edit
    end
  end

  def destroy
    if @photo.can_edit_by_user?(current_user)
      @photo.destroy 
    end

    flash[:alert]="刪除照片"
    redirect_to photos_url
  end

  def delete_all
    Photo.destroy_all
    redirect_to photos_url
  end

  protected

  def photo_params
    params.require(:photo).permit(:user_id,:category_id,:title,:description,:published_at,:pic,:name,:email)
  end

  def find_pic
    @photo = Photo.find(params[:id])
  end

end
