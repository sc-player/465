class UsersController < ApplicationController
  def show
    @link = Link.new
    render layout: false
  end
  
  def link
    @link.url=params[:url]
    @link.save
    @link = Link.new
  end
end
