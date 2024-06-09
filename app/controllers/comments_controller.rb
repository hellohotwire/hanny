class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_feature

  def create
    @comment = @feature.comments.build(comment_params.merge(user: current_user))

    if @comment.save
      redirect_to @feature, notice: 'Comment was successfully created.'
    else
      redirect_to @feature, alert: 'Failed to add comment.'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @feature, notice: 'Comment was successfully destroyed.'
  end

  private

  def set_feature
    @feature = Feature.find(params[:feature_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :parent_id)
  end
end
