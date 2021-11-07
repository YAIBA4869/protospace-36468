class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  # before_action :set_tweet, only: [:edit, :show]
  # before_action :move_to_index, except: [:index, :show]

  def index
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    prototype = Prototype.new(prototype_params)
    if prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    # @comments = @prototype.comments.includes(:user)
    @comments = @prototype.comments
  end

  def edit
    @prototype = Prototype.find(params[:id])
    redirect_to root_path unless current_user == @prototype.user
    # unless @prototype.user_id == current_user.id
  end


  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
    else
      render :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    if @prototype.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end


  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  
end
