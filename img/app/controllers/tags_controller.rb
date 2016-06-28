class TagsController < ApplicationController
  before_action :set_tag, only: [:edit, :update, :destroy]

  def new
    @image=Image.find params[:image_id]
    @tag=@image.tags.new
  end

  def edit

  end

  def create
    @image=Image.find params[:image_id]
    @tag = @image.tags.new(tag_params)

    if @tag.save
      redirect_to image_url(@image), notice: 'Tag was successfully created.'
    else
      render :new
    end
  end

  def update
    if @tag.update(tag_params)
      redirect_to image_url(@tag.image), notice: 'Tag updated.'
    else
      render :edit
    end
  end

  def destroy
    @tag.destroy
    redirect_to image_url(@tag.image)
  end

  private
    def set_tag
      @tag=Tag.find(params[:id])
    end

    def tag_params
      params.require(:tag).permit(:str, :image_id)
    end
end
