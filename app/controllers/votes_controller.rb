class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_feature

  def create
    @vote = @feature.votes.new(user: current_user)

    respond_to do |format|
      if @vote.save
        format.html { redirect_to @feature, notice: 'Thanks for voting!' }
      else
        format.html { redirect_to @feature, alert: 'You have already voted for this feature.' }
      end
    end
  end

  private

  def set_feature
    @feature = Feature.find(params[:feature_id])
  end
end
