load "#{Rails.root}/lib/ladder.rb"
@dict_size=false
class HomeController < ApplicationController
  def index
    if params[:dictSize]!=""
      @dict_size=params[:dictSize] 
    else
      @dict_size=false
    end
    logger.debug @dict_size
    switchDict @dict_size
    @startend=wldictionary.shuffle.take(2)
  end

  def show
    @words=Array.new
    @words << params[:word0]
    @words << params[:word1] if params[:word1]!=""
    @words << params[:word2] if params[:word2]!=""
    @words << params[:word3] if params[:word3]!=""
    @words << params[:word4] if params[:word4]!=""
    @words << params[:word5] if params[:word5]!=""
    @words << params[:goal]
    @victory=legal @words
  end
end
