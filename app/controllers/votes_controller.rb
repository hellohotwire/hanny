class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_feature

  def create
    @vote = @feature.votes.new(user: current_user)

    respond_to do |format|
      if @vote.save
        flash.now[:notice] = "Vote casted successfully"
        format.html { redirect_to @feature }
        format.turbo_stream
      else
        flash.now[:alert] = "You have already voted for this feature"
        format.html { redirect_to @feature }
        format.turbo_stream
      end
    end
  end

  private

  def set_feature
    @feature = Feature.find(params[:feature_id])
  end
end
