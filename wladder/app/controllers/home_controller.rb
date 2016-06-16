load "#{Rails.root}/lib/ladder.rb"
load "#{Rails.root}/lib/words4.rb"
load "#{Rails.root}/lib/words5.rb"
class HomeController < ApplicationController
  def index
    @startend=((params[:dictSize]=="true") ? wldictionary5.shuffle.take(2) : wldictionary4.shuffle.take(2))
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
