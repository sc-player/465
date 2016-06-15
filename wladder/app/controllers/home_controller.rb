class HomeController < ApplicationController
  def index
      
  end

  def show
    @words[0]=params[:words]
    @words[1]=params[:words]
    @words[2]=params[:words]
    @words[3]=params[:words]
    @words[4]=params[:words]
  end
end
