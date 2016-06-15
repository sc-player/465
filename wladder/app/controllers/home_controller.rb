load "#{Rails.root}/lib/ladder.rb"

class HomeController < ApplicationController
  def index
    @startend=dictionary.shuffle.take(2)
  end

  def show
    @words=Array.new
    @words[0]=params[:word0]
    @words[1]=params[:word1] if params[:word1]!=""
    @words[2]=params[:word2] if params[:word2]!=""
    @words[3]=params[:word3] if params[:word3]!=""
    @words[4]=params[:word4] if params[:word4]!=""
    @words[5]=params[:word5] if params[:word5]!=""
    @goal=params[:goal]
  end
end
