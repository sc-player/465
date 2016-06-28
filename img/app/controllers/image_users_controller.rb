class ImageUsersController < ApplicationController
  # POST /image_users
  # POST /image_users.json
  def create
    @image_user = ImageUser.new(image_user_params)
    @image_user.image_id=params[:image_id]
    respond_to do |format|
      if @image_user.save
        format.html { redirect_to image_path(@image_user.image_id) }
      else
        format.html { redirect_to image_path(@image_user.image_id) }
      end
    end
  end

  # DELETE /image_users/1
  # DELETE /image_users/1.json
  def destroy
    set_image_user
    id=@image_user.image_id
    name=@image_user.user.name
    @image_user.destroy
    respond_to do |format|
      format.html { redirect_to image_url(id), notice: "#{name} can no longer access this image." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_user
      @image_user = ImageUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_user_params
      params.require(:image_user).permit(:image_id, :user_id)
    end
end
